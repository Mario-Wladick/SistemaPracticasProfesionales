/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import modelo.Postulacion;
import util.ConexionDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class PostulacionDAO implements DAO<Postulacion> {
    
    private static final Logger logger = Logger.getLogger(PostulacionDAO.class.getName());
    
    @Override
    public Postulacion obtenerPorId(int id) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Postulacion postulacion = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT * FROM postulaciones WHERE id = ?";
            stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                postulacion = mapearPostulacion(rs);
            }
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return postulacion;
    }

    @Override
    public List<Postulacion> obtenerTodos() throws Exception {
        Connection conexion = null;
        Statement stmt = null;
        ResultSet rs = null;
        List<Postulacion> postulaciones = new ArrayList<>();
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT * FROM postulaciones ORDER BY fecha_postulacion DESC";
            stmt = conexion.createStatement();
            rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                postulaciones.add(mapearPostulacion(rs));
            }
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return postulaciones;
    }

    @Override
    public void insertar(Postulacion postulacion) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "INSERT INTO postulaciones (estudiante_id, oferta_id, carta_presentacion) VALUES (?, ?, ?)";
            
            stmt = conexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, postulacion.getEstudianteId());
            stmt.setInt(2, postulacion.getOfertaId());
            stmt.setString(3, postulacion.getCartaPresentacion());
            
            stmt.executeUpdate();
            
            ResultSet generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                postulacion.setId(generatedKeys.getInt(1));
            }
        } finally {
            cerrarRecursos(null, stmt, conexion);
        }
    }

    @Override
    public void actualizar(Postulacion postulacion) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "UPDATE postulaciones SET estudiante_id = ?, oferta_id = ?, carta_presentacion = ?, estado = ?, comentarios_empresa = ? WHERE id = ?";
            
            stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, postulacion.getEstudianteId());
            stmt.setInt(2, postulacion.getOfertaId());
            stmt.setString(3, postulacion.getCartaPresentacion());
            stmt.setString(4, postulacion.getEstado());
            stmt.setString(5, postulacion.getComentariosEmpresa());
            stmt.setInt(6, postulacion.getId());
            
            stmt.executeUpdate();
        } finally {
            cerrarRecursos(null, stmt, conexion);
        }
    }

    @Override
    public void eliminar(int id) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "DELETE FROM postulaciones WHERE id = ?";
            stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } finally {
            cerrarRecursos(null, stmt, conexion);
        }
    }
    
    private Postulacion mapearPostulacion(ResultSet rs) throws Exception {
        Postulacion postulacion = new Postulacion();
        postulacion.setId(rs.getInt("id"));
        postulacion.setEstudianteId(rs.getInt("estudiante_id"));
        postulacion.setOfertaId(rs.getInt("oferta_id"));
        postulacion.setCartaPresentacion(rs.getString("carta_presentacion"));
        postulacion.setEstado(rs.getString("estado"));
        postulacion.setFechaPostulacion(rs.getTimestamp("fecha_postulacion"));
        postulacion.setFechaRespuesta(rs.getTimestamp("fecha_respuesta"));
        postulacion.setComentariosEmpresa(rs.getString("comentarios_empresa"));
        return postulacion;
    }
    
    private void cerrarRecursos(ResultSet rs, Statement stmt, Connection conexion) {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conexion != null) ConexionDB.cerrarConexion();
        } catch (Exception e) {
            logger.log(Level.WARNING, "Error al cerrar recursos", e);
        }
    }
    public int contarPostulacionesPorEstudiante(int estudianteId) throws Exception {
    Connection conexion = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    
    try {
        conexion = ConexionDB.getConexion();
        String sql = "SELECT COUNT(*) FROM postulaciones WHERE estudiante_id = ?";
        stmt = conexion.prepareStatement(sql);
        stmt.setInt(1, estudianteId);
        rs = stmt.executeQuery();
        
        if (rs.next()) {
            return rs.getInt(1);
        }
    } finally {
        cerrarRecursos(rs, stmt, conexion);
    }
    return 0;
}

public boolean verificarPostulacion(int estudianteId, int ofertaId) throws Exception {
    Connection conexion = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    
    try {
        conexion = ConexionDB.getConexion();
        String sql = "SELECT COUNT(*) FROM postulaciones WHERE estudiante_id = ? AND oferta_id = ?";
        stmt = conexion.prepareStatement(sql);
        stmt.setInt(1, estudianteId);
        stmt.setInt(2, ofertaId);
        rs = stmt.executeQuery();
        
        if (rs.next()) {
            return rs.getInt(1) > 0;
        }
    } finally {
        cerrarRecursos(rs, stmt, conexion);
    }
    return false;
}
}