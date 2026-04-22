/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import modelo.Practica;
import util.ConexionDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class PracticaDAO implements DAO<Practica> {
    
    private static final Logger logger = Logger.getLogger(PracticaDAO.class.getName());
    
    @Override
    public Practica obtenerPorId(int id) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Practica practica = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT * FROM practicas WHERE id = ?";
            stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                practica = mapearPractica(rs);
            }
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return practica;
    }

    @Override
    public List<Practica> obtenerTodos() throws Exception {
        Connection conexion = null;
        Statement stmt = null;
        ResultSet rs = null;
        List<Practica> practicas = new ArrayList<>();
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT * FROM practicas ORDER BY fecha_inicio DESC";
            stmt = conexion.createStatement();
            rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                practicas.add(mapearPractica(rs));
            }
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return practicas;
    }

    @Override
    public void insertar(Practica practica) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "INSERT INTO practicas (postulacion_id, supervisor_id, fecha_inicio, fecha_fin, horas_requeridas) VALUES (?, ?, ?, ?, ?)";
            
            stmt = conexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, practica.getPostulacionId());
            stmt.setInt(2, practica.getSupervisorId());
            stmt.setDate(3, practica.getFechaInicio());
            stmt.setDate(4, practica.getFechaFin());
            stmt.setInt(5, practica.getHorasRequeridas());
            
            stmt.executeUpdate();
            
            ResultSet generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                practica.setId(generatedKeys.getInt(1));
            }
        } finally {
            cerrarRecursos(null, stmt, conexion);
        }
    }

    @Override
    public void actualizar(Practica practica) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "UPDATE practicas SET postulacion_id = ?, supervisor_id = ?, fecha_inicio = ?, fecha_fin = ?, estado = ?, horas_completadas = ?, horas_requeridas = ?, calificacion_final = ? WHERE id = ?";
            
            stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, practica.getPostulacionId());
            stmt.setInt(2, practica.getSupervisorId());
            stmt.setDate(3, practica.getFechaInicio());
            stmt.setDate(4, practica.getFechaFin());
            stmt.setString(5, practica.getEstado());
            stmt.setInt(6, practica.getHorasCompletadas());
            stmt.setInt(7, practica.getHorasRequeridas());
            stmt.setDouble(8, practica.getCalificacionFinal());
            stmt.setInt(9, practica.getId());
            
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
            String sql = "DELETE FROM practicas WHERE id = ?";
            stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } finally {
            cerrarRecursos(null, stmt, conexion);
        }
    }
    
    private Practica mapearPractica(ResultSet rs) throws Exception {
        Practica practica = new Practica();
        practica.setId(rs.getInt("id"));
        practica.setPostulacionId(rs.getInt("postulacion_id"));
        practica.setSupervisorId(rs.getInt("supervisor_id"));
        practica.setFechaInicio(rs.getDate("fecha_inicio"));
        practica.setFechaFin(rs.getDate("fecha_fin"));
        practica.setEstado(rs.getString("estado"));
        practica.setHorasCompletadas(rs.getInt("horas_completadas"));
        practica.setHorasRequeridas(rs.getInt("horas_requeridas"));
        practica.setCalificacionFinal(rs.getDouble("calificacion_final"));
        return practica;
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
    public int contarPracticasPorEstudiante(int estudianteId) throws Exception {
    Connection conexion = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    
    try {
        conexion = ConexionDB.getConexion();
        String sql = "SELECT COUNT(*) FROM practicas p JOIN postulaciones po ON p.postulacion_id = po.id WHERE po.estudiante_id = ?";
        stmt = conexion.prepareStatement(sql);
        stmt.setInt(1, estudianteId);
        rs = stmt.executeQuery();
        
        if (rs.next()) {
            return rs.getInt(1);
        }
    } 
    
    finally {
        cerrarRecursos(rs, stmt, conexion);
    }
    return 0;
    
}
    
}