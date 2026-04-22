/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import modelo.OfertaPractica;
import util.ConexionDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class OfertaPracticaDAO implements DAO<OfertaPractica> {
    
    private static final Logger logger = Logger.getLogger(OfertaPracticaDAO.class.getName());
    
    @Override
    public OfertaPractica obtenerPorId(int id) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        OfertaPractica oferta = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT * FROM ofertas_practica WHERE id = ?";
            stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                oferta = mapearOferta(rs);
            }
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return oferta;
    }

    @Override
    public List<OfertaPractica> obtenerTodos() throws Exception {
        Connection conexion = null;
        Statement stmt = null;
        ResultSet rs = null;
        List<OfertaPractica> ofertas = new ArrayList<>();
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT * FROM ofertas_practica ORDER BY fecha_publicacion DESC";
            stmt = conexion.createStatement();
            rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                ofertas.add(mapearOferta(rs));
            }
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return ofertas;
    }
    
    public List<OfertaPractica> obtenerActivas() throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<OfertaPractica> ofertas = new ArrayList<>();
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT * FROM ofertas_practica WHERE estado = 'activa' AND fecha_limite_postulacion >= CURRENT_DATE ORDER BY fecha_publicacion DESC";
            stmt = conexion.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                ofertas.add(mapearOferta(rs));
            }
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return ofertas;
    }

    @Override
    public void insertar(OfertaPractica oferta) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "INSERT INTO ofertas_practica (empresa_id, titulo, descripcion, requisitos, modalidad, area, duracion_meses, vacantes, fecha_limite_postulacion) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            stmt = conexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, oferta.getEmpresaId());
            stmt.setString(2, oferta.getTitulo());
            stmt.setString(3, oferta.getDescripcion());
            stmt.setString(4, oferta.getRequisitos());
            stmt.setString(5, oferta.getModalidad());
            stmt.setString(6, oferta.getArea());
            stmt.setInt(7, oferta.getDuracionMeses());
            stmt.setInt(8, oferta.getVacantes());
            stmt.setDate(9, oferta.getFechaLimitePostulacion());
            
            stmt.executeUpdate();
            
            ResultSet generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                oferta.setId(generatedKeys.getInt(1));
            }
        } finally {
            cerrarRecursos(null, stmt, conexion);
        }
    }

    @Override
    public void actualizar(OfertaPractica oferta) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "UPDATE ofertas_practica SET empresa_id = ?, titulo = ?, descripcion = ?, requisitos = ?, modalidad = ?, area = ?, duracion_meses = ?, vacantes = ?, fecha_limite_postulacion = ?, estado = ? WHERE id = ?";
            
            stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, oferta.getEmpresaId());
            stmt.setString(2, oferta.getTitulo());
            stmt.setString(3, oferta.getDescripcion());
            stmt.setString(4, oferta.getRequisitos());
            stmt.setString(5, oferta.getModalidad());
            stmt.setString(6, oferta.getArea());
            stmt.setInt(7, oferta.getDuracionMeses());
            stmt.setInt(8, oferta.getVacantes());
            stmt.setDate(9, oferta.getFechaLimitePostulacion());
            stmt.setString(10, oferta.getEstado());
            stmt.setInt(11, oferta.getId());
            
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
            String sql = "DELETE FROM ofertas_practica WHERE id = ?";
            stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } finally {
            cerrarRecursos(null, stmt, conexion);
        }
    }
    
    private OfertaPractica mapearOferta(ResultSet rs) throws Exception {
        OfertaPractica oferta = new OfertaPractica();
        oferta.setId(rs.getInt("id"));
        oferta.setEmpresaId(rs.getInt("empresa_id"));
        oferta.setTitulo(rs.getString("titulo"));
        oferta.setDescripcion(rs.getString("descripcion"));
        oferta.setRequisitos(rs.getString("requisitos"));
        oferta.setModalidad(rs.getString("modalidad"));
        oferta.setArea(rs.getString("area"));
        oferta.setDuracionMeses(rs.getInt("duracion_meses"));
        oferta.setVacantes(rs.getInt("vacantes"));
        oferta.setFechaLimitePostulacion(rs.getDate("fecha_limite_postulacion"));
        oferta.setEstado(rs.getString("estado"));
        oferta.setFechaPublicacion(rs.getTimestamp("fecha_publicacion"));
        return oferta;
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
public int contarOfertasActivas() throws Exception {
    Connection conexion = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    
    try {
        conexion = ConexionDB.getConexion();
        String sql = "SELECT COUNT(*) FROM ofertas_practica WHERE estado = 'activa' AND fecha_limite_postulacion >= CURRENT_DATE";
        stmt = conexion.prepareStatement(sql);
        rs = stmt.executeQuery();
        
        if (rs.next()) {
            return rs.getInt(1);
        }
    } finally {
        cerrarRecursos(rs, stmt, conexion);
    }
    return 0;
}

public List<OfertaPractica> obtenerUltimasOfertasActivas(int limite) throws Exception {
    Connection conexion = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    List<OfertaPractica> ofertas = new ArrayList<>();
    
    try {
        conexion = ConexionDB.getConexion();
        String sql = "SELECT * FROM ofertas_practica WHERE estado = 'activa' AND fecha_limite_postulacion >= CURRENT_DATE ORDER BY fecha_publicacion DESC LIMIT ?";
        stmt = conexion.prepareStatement(sql);
        stmt.setInt(1, limite);
        rs = stmt.executeQuery();
        
        while (rs.next()) {
            ofertas.add(mapearOferta(rs));
        }
    } finally {
        cerrarRecursos(rs, stmt, conexion);
    }
    return ofertas;
}

public List<OfertaPractica> obtenerOfertasActivas(String area, String modalidad) throws Exception {
    Connection conexion = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    List<OfertaPractica> ofertas = new ArrayList<>();
    
    try {
        conexion = ConexionDB.getConexion();
        String sql = "SELECT * FROM ofertas_practica WHERE estado = 'activa' AND fecha_limite_postulacion >= CURRENT_DATE";
        
        if (area != null && !area.trim().isEmpty()) {
            sql += " AND area = ?";
        }
        if (modalidad != null && !modalidad.trim().isEmpty()) {
            sql += " AND modalidad = ?";
        }
        
        sql += " ORDER BY fecha_publicacion DESC";
        
        stmt = conexion.prepareStatement(sql);
        int paramIndex = 1;
        
        if (area != null && !area.trim().isEmpty()) {
            stmt.setString(paramIndex++, area);
        }
        if (modalidad != null && !modalidad.trim().isEmpty()) {
            stmt.setString(paramIndex, modalidad);
        }
        
        rs = stmt.executeQuery();
        
        while (rs.next()) {
            ofertas.add(mapearOferta(rs));
        }
    } finally {
        cerrarRecursos(rs, stmt, conexion);
    }
    return ofertas;
}

public List<String> obtenerAreasDisponibles() throws Exception {
    Connection conexion = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    List<String> areas = new ArrayList<>();
    
    try {
        conexion = ConexionDB.getConexion();
        String sql = "SELECT DISTINCT area FROM ofertas_practica WHERE estado = 'activa' ORDER BY area";
        stmt = conexion.prepareStatement(sql);
        rs = stmt.executeQuery();
        
        while (rs.next()) {
            areas.add(rs.getString("area"));
        }
    } finally {
        cerrarRecursos(rs, stmt, conexion);
    }
    return areas;
}

public List<String> obtenerModalidadesDisponibles() throws Exception {
    Connection conexion = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    List<String> modalidades = new ArrayList<>();
    
    try {
        conexion = ConexionDB.getConexion();
        String sql = "SELECT DISTINCT modalidad FROM ofertas_practica WHERE estado = 'activa' ORDER BY modalidad";
        stmt = conexion.prepareStatement(sql);
        rs = stmt.executeQuery();
        
        while (rs.next()) {
            modalidades.add(rs.getString("modalidad"));
        }
    } finally {
        cerrarRecursos(rs, stmt, conexion);
    }
    return modalidades;
}

}