/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import modelo.Empresa;
import util.ConexionDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class EmpresaDAO implements DAO<Empresa> {
    
    private static final Logger logger = Logger.getLogger(EmpresaDAO.class.getName());
    
    @Override
    public Empresa obtenerPorId(int id) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Empresa empresa = null;
        
        try {
            conexion = ConexionDB.getConexion(); // CORREGIDO
            String sql = "SELECT * FROM empresas WHERE id = ?"; // CORREGIDO: columna 'id' en PostgreSQL
            stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                empresa = mapearEmpresa(rs); // Método helper para mapear
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al obtener empresa por ID: " + id, e);
            throw e;
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return empresa;
    }
    
    public Empresa obtenerPorIdUsuario(int idUsuario) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Empresa empresa = null;
        
        try {
            conexion = ConexionDB.getConexion(); // CORREGIDO
            String sql = "SELECT * FROM empresas WHERE usuario_id = ?"; // CORREGIDO: columna 'usuario_id'
            stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, idUsuario);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                empresa = mapearEmpresa(rs);
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al obtener empresa por usuario ID: " + idUsuario, e);
            throw e;
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return empresa;
    }

    @Override
    public List<Empresa> obtenerTodos() throws Exception {
        Connection conexion = null;
        Statement stmt = null;
        ResultSet rs = null;
        List<Empresa> empresas = new ArrayList<>();
        
        try {
            conexion = ConexionDB.getConexion(); // CORREGIDO
            String sql = "SELECT * FROM empresas ORDER BY razon_social";
            stmt = conexion.createStatement();
            rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                empresas.add(mapearEmpresa(rs));
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al obtener todas las empresas", e);
            throw e;
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return empresas;
    }

    @Override
    public void insertar(Empresa empresa) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        
        try {
            conexion = ConexionDB.getConexion(); // CORREGIDO
            String sql = "INSERT INTO empresas (usuario_id, razon_social, ruc, descripcion, " +
                        "direccion, telefono, sitio_web, verificada) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            
            stmt = conexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, empresa.getIdUsuario());
            stmt.setString(2, empresa.getRazonSocial());
            stmt.setString(3, empresa.getRuc());
            stmt.setString(4, empresa.getDescripcion());
            stmt.setString(5, empresa.getDireccion());
            stmt.setString(6, empresa.getTelefono());
            stmt.setString(7, empresa.getSitioWeb());
            stmt.setBoolean(8, empresa.isVerificada()); // CORREGIDO: boolean en PostgreSQL
            
            int filasAfectadas = stmt.executeUpdate();
            
            if (filasAfectadas > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    empresa.setIdEmpresa(generatedKeys.getInt(1));
                }
                logger.info("Empresa insertada exitosamente: " + empresa.getRazonSocial());
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al insertar empresa: " + empresa.getRazonSocial(), e);
            throw e;
        } finally {
            cerrarRecursos(null, stmt, conexion);
        }
    }
    
    // NUEVO MÉTODO: Insertar y retornar boolean
 

    @Override
    public void actualizar(Empresa empresa) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        
        try {
            conexion = ConexionDB.getConexion(); // CORREGIDO
            String sql = "UPDATE empresas SET usuario_id = ?, razon_social = ?, ruc = ?, " +
                        "descripcion = ?, direccion = ?, telefono = ?, sitio_web = ?, " +
                        "verificada = ? WHERE id = ?";
            
            stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, empresa.getIdUsuario());
            stmt.setString(2, empresa.getRazonSocial());
            stmt.setString(3, empresa.getRuc());
            stmt.setString(4, empresa.getDescripcion());
            stmt.setString(5, empresa.getDireccion());
            stmt.setString(6, empresa.getTelefono());
            stmt.setString(7, empresa.getSitioWeb());
            stmt.setBoolean(8, empresa.isVerificada());
            stmt.setInt(9, empresa.getIdEmpresa());
            
            int filasAfectadas = stmt.executeUpdate();
            if (filasAfectadas > 0) {
                logger.info("Empresa actualizada exitosamente: " + empresa.getRazonSocial());
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al actualizar empresa: " + empresa.getIdEmpresa(), e);
            throw e;
        } finally {
            cerrarRecursos(null, stmt, conexion);
        }
    }

    @Override
    public void eliminar(int id) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        
        try {
            conexion = ConexionDB.getConexion(); // CORREGIDO
            String sql = "DELETE FROM empresas WHERE id = ?";
            stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, id);
            
            int filasAfectadas = stmt.executeUpdate();
            if (filasAfectadas > 0) {
                logger.info("Empresa eliminada exitosamente con ID: " + id);
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al eliminar empresa con ID: " + id, e);
            throw e;
        } finally {
            cerrarRecursos(null, stmt, conexion);
        }
    }
    
    // =================== MÉTODOS ADICIONALES NECESARIOS ===================
    
    /**
     * Verificar si existe una empresa con el RUC dado
     */
    public boolean existePorRuc(String ruc) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT COUNT(*) FROM empresas WHERE ruc = ?";
            stmt = conexion.prepareStatement(sql);
            stmt.setString(1, ruc);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al verificar RUC: " + ruc, e);
            throw e;
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return false;
    }
    
    /**
     * Verificar si existe una empresa con la razón social dada
     */
    public boolean existePorRazonSocial(String razonSocial) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT COUNT(*) FROM empresas WHERE LOWER(razon_social) = LOWER(?)";
            stmt = conexion.prepareStatement(sql);
            stmt.setString(1, razonSocial);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al verificar razón social: " + razonSocial, e);
            throw e;
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return false;
    }
    
    /**
     * Obtener empresas por estado de verificación
     */
    public List<Empresa> obtenerPorVerificacion(boolean verificada) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Empresa> empresas = new ArrayList<>();
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT * FROM empresas WHERE verificada = ? ORDER BY razon_social";
            stmt = conexion.prepareStatement(sql);
            stmt.setBoolean(1, verificada);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                empresas.add(mapearEmpresa(rs));
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al obtener empresas por verificación: " + verificada, e);
            throw e;
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return empresas;
    }
    
    /**
     * Verificar una empresa (aprobar)
     */
    public boolean verificarEmpresa(int empresaId) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "UPDATE empresas SET verificada = true, fecha_verificacion = CURRENT_TIMESTAMP WHERE id = ?";
            stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, empresaId);
            
            int filasAfectadas = stmt.executeUpdate();
            if (filasAfectadas > 0) {
                logger.info("Empresa verificada exitosamente con ID: " + empresaId);
                return true;
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al verificar empresa con ID: " + empresaId, e);
            throw e;
        } finally {
            cerrarRecursos(null, stmt, conexion);
        }
        return false;
    }
    
    /**
     * Obtener empresas pendientes de verificación
     */
    public List<Empresa> obtenerEmpresasPendientes() throws Exception {
        return obtenerPorVerificacion(false);
    }
    
    /**
     * Obtener empresas verificadas
     */
    public List<Empresa> obtenerEmpresasVerificadas() throws Exception {
        return obtenerPorVerificacion(true);
    }
    
    // =================== MÉTODOS HELPER ===================
    
    /**
     * Mapear ResultSet a objeto Empresa
     */
    private Empresa mapearEmpresa(ResultSet rs) throws Exception {
        Empresa empresa = new Empresa();
        empresa.setIdEmpresa(rs.getInt("id"));
        empresa.setIdUsuario(rs.getInt("usuario_id"));
        empresa.setRazonSocial(rs.getString("razon_social"));
        empresa.setRuc(rs.getString("ruc"));
        empresa.setDescripcion(rs.getString("descripcion"));
        empresa.setDireccion(rs.getString("direccion"));
        empresa.setTelefono(rs.getString("telefono"));
        empresa.setSitioWeb(rs.getString("sitio_web"));
        empresa.setVerificada(rs.getBoolean("verificada"));
        
        // Campos opcionales que pueden no existir en versiones anteriores
        try {
            empresa.setFechaRegistro(rs.getTimestamp("fecha_registro"));
        } catch (Exception e) {
            // Campo no existe, se ignora
        }
        
        try {
            empresa.setFechaVerificacion(rs.getTimestamp("fecha_verificacion"));
        } catch (Exception e) {
            // Campo no existe, se ignora
        }
        
        return empresa;
    }
    
    /**
     * Cerrar recursos de base de datos
     */
    private void cerrarRecursos(ResultSet rs, Statement stmt, Connection conexion) {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conexion != null) ConexionDB.cerrarConexion(); // CORREGIDO
        } catch (Exception e) {
            logger.log(Level.WARNING, "Error al cerrar recursos", e);
        }
    }
    public List<Empresa> obtenerPorEstado(String estado) throws Exception {
    boolean verificada = "verificada".equals(estado) || "activa".equals(estado);
    return obtenerPorVerificacion(verificada);
}
}