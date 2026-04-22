package dao;

import modelo.Supervisor;
import util.ConexionDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class SupervisorDAO implements DAO<Supervisor> {
    
    private static final Logger logger = Logger.getLogger(SupervisorDAO.class.getName());
    
    @Override
    public Supervisor obtenerPorId(int id) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Supervisor supervisor = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT * FROM supervisores WHERE id = ?";
            stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                supervisor = mapearSupervisor(rs);
            }
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return supervisor;
    }

    @Override
    public List<Supervisor> obtenerTodos() throws Exception {
        Connection conexion = null;
        Statement stmt = null;
        ResultSet rs = null;
        List<Supervisor> supervisores = new ArrayList<>();
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "SELECT * FROM supervisores ORDER BY apellidos, nombres";
            stmt = conexion.createStatement();
            rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                supervisores.add(mapearSupervisor(rs));
            }
        } finally {
            cerrarRecursos(rs, stmt, conexion);
        }
        return supervisores;
    }

    @Override
    public void insertar(Supervisor supervisor) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "INSERT INTO supervisores (usuario_id, empresa_id, nombres, apellidos, cargo, telefono) VALUES (?, ?, ?, ?, ?, ?)";
            
            stmt = conexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, supervisor.getUsuarioId());
            stmt.setInt(2, supervisor.getEmpresaId());
            stmt.setString(3, supervisor.getNombres());
            stmt.setString(4, supervisor.getApellidos());
            stmt.setString(5, supervisor.getCargo());
            stmt.setString(6, supervisor.getTelefono());
            
            stmt.executeUpdate();
            
            ResultSet generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                supervisor.setId(generatedKeys.getInt(1));
            }
        } finally {
            cerrarRecursos(null, stmt, conexion);
        }
    }

    @Override
    public void actualizar(Supervisor supervisor) throws Exception {
        Connection conexion = null;
        PreparedStatement stmt = null;
        
        try {
            conexion = ConexionDB.getConexion();
            String sql = "UPDATE supervisores SET usuario_id = ?, empresa_id = ?, nombres = ?, apellidos = ?, cargo = ?, telefono = ? WHERE id = ?";
            
            stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, supervisor.getUsuarioId());
            stmt.setInt(2, supervisor.getEmpresaId());
            stmt.setString(3, supervisor.getNombres());
            stmt.setString(4, supervisor.getApellidos());
            stmt.setString(5, supervisor.getCargo());
            stmt.setString(6, supervisor.getTelefono());
            stmt.setInt(7, supervisor.getId());
            
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
            String sql = "DELETE FROM supervisores WHERE id = ?";
            stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } finally {
            cerrarRecursos(null, stmt, conexion);
        }
    }
    
    private Supervisor mapearSupervisor(ResultSet rs) throws Exception {
        Supervisor supervisor = new Supervisor();
        supervisor.setId(rs.getInt("id"));
        supervisor.setUsuarioId(rs.getInt("usuario_id"));
        supervisor.setEmpresaId(rs.getInt("empresa_id"));
        supervisor.setNombres(rs.getString("nombres"));
        supervisor.setApellidos(rs.getString("apellidos"));
        supervisor.setCargo(rs.getString("cargo"));
        supervisor.setTelefono(rs.getString("telefono"));
        return supervisor;
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
    public Supervisor obtenerPorIdUsuario(int idUsuario) throws Exception {
    Connection conexion = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    Supervisor supervisor = null;
    
    try {
        conexion = ConexionDB.getConexion();
        String sql = "SELECT * FROM supervisores WHERE usuario_id = ?";
        stmt = conexion.prepareStatement(sql);
        stmt.setInt(1, idUsuario);
        rs = stmt.executeQuery();
        
        if (rs.next()) {
            supervisor = mapearSupervisor(rs);
        }
    } finally {
        cerrarRecursos(rs, stmt, conexion);
    }
    return supervisor;
}
}
