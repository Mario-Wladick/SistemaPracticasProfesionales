/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import modelo.Estudiante;
import util.ConexionDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class EstudianteDAO implements DAO<Estudiante> {
    
    private static final Logger logger = Logger.getLogger(EstudianteDAO.class.getName());
    
    @Override
    public Estudiante obtenerPorId(int id) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Estudiante estudiante = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT * FROM estudiantes WHERE id = ?";
            stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                estudiante = mapearEstudiante(rs);
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al obtener estudiante por ID: " + id, e);
            throw e;
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return estudiante;
    }
    
    public Estudiante obtenerPorIdUsuario(int idUsuario) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Estudiante estudiante = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT * FROM estudiantes WHERE usuario_id = ?";
            stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, idUsuario);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                estudiante = mapearEstudiante(rs);
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al obtener estudiante por usuario ID: " + idUsuario, e);
            throw e;
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return estudiante;
    }
    
    public Estudiante obtenerPorCodigoUniversitario(String codigo) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Estudiante estudiante = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT * FROM estudiantes WHERE codigo_universitario = ?";
            stmt = conexion.prepareStatement(sql);
            stmt.setString(1, codigo);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                estudiante = mapearEstudiante(rs);
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al obtener estudiante por código: " + codigo, e);
            throw e;
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return estudiante;
    }

    @Override
    public List<Estudiante> obtenerTodos() throws Exception {
        Connection conexion = null;
        Statement stmt = null;
        ResultSet rs = null;
        List<Estudiante> estudiantes = new ArrayList<>();
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT * FROM estudiantes ORDER BY apellidos, nombres";
            stmt = conexion.createStatement();
            rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                estudiantes.add(mapearEstudiante(rs));
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al obtener todos los estudiantes", e);
            throw e;
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return estudiantes;
    }

    @Override
    public void insertar(Estudiante estudiante) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "INSERT INTO estudiantes (usuario_id, codigo_universitario, nombres, apellidos, " +
                        "dni, telefono, especialidad, ciclo_actual, promedio_ponderado) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            stmt = conexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, estudiante.getIdUsuario());
            stmt.setString(2, estudiante.getCodigoUniversitario());
            stmt.setString(3, estudiante.getNombres());
            stmt.setString(4, estudiante.getApellidos());
            stmt.setString(5, estudiante.getDni());
            stmt.setString(6, estudiante.getTelefono());
            stmt.setString(7, estudiante.getEspecialidad());
            stmt.setInt(8, estudiante.getCiclo());
            stmt.setDouble(9, estudiante.getPromedioPonderado());
            
            int filasAfectadas = stmt.executeUpdate();
            
            if (filasAfectadas > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    estudiante.setIdEstudiante(generatedKeys.getInt(1));
                }
                logger.info("Estudiante insertado exitosamente: " + estudiante.getCodigoUniversitario());
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al insertar estudiante: " + estudiante.getCodigoUniversitario(), e);
            throw e;
        } finally {
            cerrarRecursos(null, stmt, conexion);
        }
    }
    
    // MÉTODO NUEVO: Insertar y retornar boolean
 

    @Override
    public void actualizar(Estudiante estudiante) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "UPDATE estudiantes SET usuario_id = ?, codigo_universitario = ?, nombres = ?, " +
                        "apellidos = ?, dni = ?, telefono = ?, especialidad = ?, ciclo_actual = ?, " +
                        "promedio_ponderado = ? WHERE id = ?";
            
            stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, estudiante.getIdUsuario());
            stmt.setString(2, estudiante.getCodigoUniversitario());
            stmt.setString(3, estudiante.getNombres());
            stmt.setString(4, estudiante.getApellidos());
            stmt.setString(5, estudiante.getDni());
            stmt.setString(6, estudiante.getTelefono());
            stmt.setString(7, estudiante.getEspecialidad());
            stmt.setInt(8, estudiante.getCiclo());
            stmt.setDouble(9, estudiante.getPromedioPonderado());
            stmt.setInt(10, estudiante.getIdEstudiante());
            
            int filasAfectadas = stmt.executeUpdate();
            if (filasAfectadas > 0) {
                logger.info("Estudiante actualizado exitosamente: " + estudiante.getCodigoUniversitario());
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al actualizar estudiante: " + estudiante.getIdEstudiante(), e);
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
            String sql = "DELETE FROM estudiantes WHERE id = ?";
            stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, id);
            
            int filasAfectadas = stmt.executeUpdate();
            if (filasAfectadas > 0) {
                logger.info("Estudiante eliminado exitosamente con ID: " + id);
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al eliminar estudiante con ID: " + id, e);
            throw e;
        } finally {
            cerrarRecursos(null, stmt, conexion);
        }
    }
    
    // =================== MÉTODOS ADICIONALES ===================
    
    public boolean existePorDni(String dni) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT COUNT(*) FROM estudiantes WHERE dni = ?";
            stmt = conexion.prepareStatement(sql);
            stmt.setString(1, dni);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al verificar DNI: " + dni, e);
            throw e;
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return false;
    }
    
    public boolean existePorCodigoUniversitario(String codigo) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT COUNT(*) FROM estudiantes WHERE codigo_universitario = ?";
            stmt = conexion.prepareStatement(sql);
            stmt.setString(1, codigo);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al verificar código universitario: " + codigo, e);
            throw e;
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return false;
    }
    
    public List<Estudiante> obtenerPorEspecialidad(String especialidad) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Estudiante> estudiantes = new ArrayList<>();
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT * FROM estudiantes WHERE especialidad = ? ORDER BY apellidos, nombres";
            stmt = conexion.prepareStatement(sql);
            stmt.setString(1, especialidad);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                estudiantes.add(mapearEstudiante(rs));
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al obtener estudiantes por especialidad: " + especialidad, e);
            throw e;
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return estudiantes;
    }
    
    public List<Estudiante> obtenerPorCiclo(int ciclo) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Estudiante> estudiantes = new ArrayList<>();
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT * FROM estudiantes WHERE ciclo_actual = ? ORDER BY apellidos, nombres";
            stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, ciclo);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                estudiantes.add(mapearEstudiante(rs));
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al obtener estudiantes por ciclo: " + ciclo, e);
            throw e;
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return estudiantes;
    }
    
    public List<Estudiante> buscarPorNombre(String termino) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Estudiante> estudiantes = new ArrayList<>();
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT * FROM estudiantes WHERE LOWER(nombres) LIKE LOWER(?) OR LOWER(apellidos) LIKE LOWER(?) ORDER BY apellidos, nombres";
            stmt = conexion.prepareStatement(sql);
            String busqueda = "%" + termino + "%";
            stmt.setString(1, busqueda);
            stmt.setString(2, busqueda);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                estudiantes.add(mapearEstudiante(rs));
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error al buscar estudiantes por nombre: " + termino, e);
            throw e;
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return estudiantes;
    }
    
    // =================== MÉTODOS HELPER ===================
    
    private Estudiante mapearEstudiante(ResultSet rs) throws Exception {
        Estudiante estudiante = new Estudiante();
        estudiante.setIdEstudiante(rs.getInt("id"));
        estudiante.setIdUsuario(rs.getInt("usuario_id"));
        estudiante.setCodigoUniversitario(rs.getString("codigo_universitario"));
        estudiante.setNombres(rs.getString("nombres"));
        estudiante.setApellidos(rs.getString("apellidos"));
        estudiante.setDni(rs.getString("dni"));
        estudiante.setTelefono(rs.getString("telefono"));
        estudiante.setEspecialidad(rs.getString("especialidad"));
        estudiante.setCiclo(rs.getInt("ciclo_actual"));
        estudiante.setPromedioPonderado(rs.getDouble("promedio_ponderado"));
        
        // Campos opcionales
        try {
            estudiante.setEmail(rs.getString("email"));
        } catch (Exception e) {
            // Campo puede no existir en versiones anteriores
        }
        
        return estudiante;
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