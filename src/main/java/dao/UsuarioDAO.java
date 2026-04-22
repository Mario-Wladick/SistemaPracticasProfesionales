/*
 * UsuarioDAO - Versión PostgreSQL Completa
 * Sistema de Prácticas Profesionales - FINESI
 */
package dao;

import modelo.Usuario;
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

public class UsuarioDAO implements DAO<Usuario> {
    
    private static final Logger logger = Logger.getLogger(UsuarioDAO.class.getName());
    
    @Override
    public Usuario obtenerPorId(int id) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Usuario usuario = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT * FROM usuarios WHERE id = ?";
            stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                usuario = mapearUsuario(rs);
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al obtener usuario por ID: " + id, e);
            throw e;
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return usuario;
    }
    
    public Usuario obtenerPorUsername(String username) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Usuario usuario = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT * FROM usuarios WHERE usuario = ?";
            stmt = conexion.prepareStatement(sql);
            stmt.setString(1, username);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                usuario = mapearUsuario(rs);
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al obtener usuario por username: " + username, e);
            throw e;
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return usuario;
    }
    
    public Usuario obtenerPorEmail(String email) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Usuario usuario = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT * FROM usuarios WHERE email = ?";
            stmt = conexion.prepareStatement(sql);
            stmt.setString(1, email.toLowerCase());
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                usuario = mapearUsuario(rs);
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al obtener usuario por email: " + email, e);
            throw e;
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return usuario;
    }
    public boolean existeUsuario(String username) throws Exception {
    Connection conexion = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    
    try {
        conexion = ConexionDB.getConexion();
        String sql = "SELECT COUNT(*) FROM usuarios WHERE usuario = ?";
        stmt = conexion.prepareStatement(sql);
        stmt.setString(1, username);
        rs = stmt.executeQuery();
        
        if (rs.next()) {
            return rs.getInt(1) > 0;
        }
    } finally {
        cerrarRecursos(rs, stmt, conexion);
    }
    return false;
}

    @Override
    public List<Usuario> obtenerTodos() throws Exception {
        Connection conexion = null;
        Statement stmt = null;
        ResultSet rs = null;
        List<Usuario> usuarios = new ArrayList<>();
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT * FROM usuarios ORDER BY fecha_registro DESC";
            stmt = conexion.createStatement();
            rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                usuarios.add(mapearUsuario(rs));
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al obtener todos los usuarios", e);
            throw e;
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return usuarios;
    }

    @Override
    public void insertar(Usuario usuario) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "INSERT INTO usuarios (usuario, email, password, tipo_usuario, activo, fecha_registro) VALUES (?, ?, ?, ?, ?, ?)";
            
            stmt = conexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, usuario.getUsername());
            stmt.setString(2, usuario.getEmail().toLowerCase());
            stmt.setString(3, usuario.getPassword());
            stmt.setString(4, usuario.getTipoUsuario());
            stmt.setBoolean(5, usuario.isEstado());
            stmt.setTimestamp(6, usuario.getFechaRegistro());
            
            int filasAfectadas = stmt.executeUpdate();
            
            if (filasAfectadas > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    usuario.setIdUsuario(generatedKeys.getInt(1));
                }
                logger.info("Usuario insertado exitosamente: " + usuario.getUsername());
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al insertar usuario: " + usuario.getUsername(), e);
            throw e;
        } finally {
            cerrarRecursos(null, stmt, conexion);
        }
    }
    
    // MÉTODO NUEVO: Insertar y retornar ID
    public int insertarConRetorno(Usuario usuario) throws Exception {
        insertar(usuario);
        return usuario.getIdUsuario();
    }

    @Override
    public void actualizar(Usuario usuario) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "UPDATE usuarios SET usuario = ?, email = ?, password = ?, tipo_usuario = ?, activo = ? WHERE id = ?";
            
            stmt = conexion.prepareStatement(sql);
            stmt.setString(1, usuario.getUsername());
            stmt.setString(2, usuario.getEmail().toLowerCase());
            stmt.setString(3, usuario.getPassword());
            stmt.setString(4, usuario.getTipoUsuario());
            stmt.setBoolean(5, usuario.isEstado());
            stmt.setInt(6, usuario.getIdUsuario());
            
            int filasAfectadas = stmt.executeUpdate();
            if (filasAfectadas > 0) {
                logger.info("Usuario actualizado exitosamente: " + usuario.getUsername());
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al actualizar usuario: " + usuario.getIdUsuario(), e);
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
            conexion = ConexionDB.getConexion();
            String sql = "DELETE FROM usuarios WHERE id = ?";
            stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, id);
            
            int filasAfectadas = stmt.executeUpdate();
            if (filasAfectadas > 0) {
                logger.info("Usuario eliminado exitosamente con ID: " + id);
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al eliminar usuario con ID: " + id, e);
            throw e;
        } finally {
            cerrarRecursos(null, stmt, conexion);
        }
    }
    
    // =================== MÉTODOS ADICIONALES ===================
    
    public boolean existePorUsername(String username) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT COUNT(*) FROM usuarios WHERE usuario = ?";
            stmt = conexion.prepareStatement(sql);
            stmt.setString(1, username);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al verificar username: " + username, e);
            throw e;
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return false;
    }
    
    public boolean existePorEmail(String email) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT COUNT(*) FROM usuarios WHERE email = ?";
            stmt = conexion.prepareStatement(sql);
            stmt.setString(1, email.toLowerCase());
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al verificar email: " + email, e);
            throw e;
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return false;
    }
    
    public Usuario autenticar(String username, String password) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Usuario usuario = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT * FROM usuarios WHERE usuario = ? AND password = ? AND activo = true";
            stmt = conexion.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                usuario = mapearUsuario(rs);
                // Actualizar último acceso
                actualizarUltimoAcceso(usuario.getIdUsuario());
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al autenticar usuario: " + username, e);
            throw e;
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return usuario;
    }
    
    public void actualizarUltimoAcceso(int usuarioId) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "UPDATE usuarios SET ultimo_acceso = CURRENT_TIMESTAMP WHERE id = ?";
            stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, usuarioId);
            stmt.executeUpdate();
        } catch (Exception e) {
            logger.log(Level.WARNING, "Error al actualizar último acceso: " + usuarioId, e);
            // No lanzar excepción porque no es crítico
        } finally {
            cerrarRecursos(null, stmt, conexion);
        }
    }
    
    public List<Usuario> obtenerPorTipo(String tipoUsuario) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Usuario> usuarios = new ArrayList<>();
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT * FROM usuarios WHERE tipo_usuario = ? ORDER BY fecha_registro DESC";
            stmt = conexion.prepareStatement(sql);
            stmt.setString(1, tipoUsuario);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                usuarios.add(mapearUsuario(rs));
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al obtener usuarios por tipo: " + tipoUsuario, e);
            throw e;
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return usuarios;
    }
    
    // =================== MÉTODOS HELPER ===================
    
    private Usuario mapearUsuario(ResultSet rs) throws Exception {
        Usuario usuario = new Usuario();
        usuario.setIdUsuario(rs.getInt("id"));
        usuario.setUsername(rs.getString("usuario"));
        usuario.setEmail(rs.getString("email"));
        usuario.setPassword(rs.getString("password"));
        usuario.setTipoUsuario(rs.getString("tipo_usuario"));
        usuario.setEstado(rs.getBoolean("activo"));
        usuario.setFechaRegistro(rs.getTimestamp("fecha_registro"));
        
        try {
            usuario.setUltimoAcceso(rs.getTimestamp("ultimo_acceso"));
        } catch (Exception e) {
            // Campo puede ser null
        }
        
        return usuario;
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
}