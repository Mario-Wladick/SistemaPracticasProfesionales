package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Clase para manejar la conexión a la base de datos PostgreSQL
 * Sistema de Prácticas Profesionales - FINESI
 */
public class ConexionDB {
    
    // Configuración de la base de datos PostgreSQL
    private static final String URL = "jdbc:postgresql://localhost:5432/sist_practicas_profecionalesdb";
    private static final String USUARIO = "postgres";
    private static final String PASSWORD = "231927196156"; // Cambiar por tu contraseña
    private static final String DRIVER = "org.postgresql.Driver";
    
    private static final Logger logger = Logger.getLogger(ConexionDB.class.getName());
    
    // Pool de conexiones simple (opcional)
    private static Connection conexion = null;
    
    /**
     * Establece la conexión con la base de datos PostgreSQL
     * @return Connection objeto de conexión
     */
    public static Connection getConexion() {
        try {
            // Cargar el driver de PostgreSQL
            Class.forName(DRIVER);
            
            // Establecer la conexión
            conexion = DriverManager.getConnection(URL, USUARIO, PASSWORD);
            
            if (conexion != null) {
                logger.info("Conexión establecida exitosamente con PostgreSQL");
            }
            
        } catch (ClassNotFoundException e) {
            logger.log(Level.SEVERE, "Driver de PostgreSQL no encontrado", e);
            System.err.println("Error: Driver PostgreSQL no encontrado - " + e.getMessage());
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error al conectar con la base de datos", e);
            System.err.println("Error de conexión a PostgreSQL: " + e.getMessage());
        }
        
        return conexion;
    }
    
    /**
     * Cierra la conexión a la base de datos
     */
    public static void cerrarConexion() {
        try {
            if (conexion != null && !conexion.isClosed()) {
                conexion.close();
                logger.info("Conexión cerrada correctamente");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error al cerrar la conexión", e);
        }
    }
    
    /**
     * Verifica si la conexión está activa
     * @return boolean true si la conexión está activa
     */
    public static boolean isConexionActiva() {
        try {
            return conexion != null && !conexion.isClosed();
        } catch (SQLException e) {
            return false;
        }
    }
    
    /**
     * Método para probar la conexión
     */
    public static void probarConexion() {
        Connection conn = getConexion();
        if (conn != null) {
            System.out.println("✅ Conexión a PostgreSQL exitosa!");
            try {
                System.out.println("📊 Base de datos: " + conn.getCatalog());
                System.out.println("🔗 URL: " + conn.getMetaData().getURL());
                cerrarConexion();
            } catch (SQLException e) {
                logger.log(Level.WARNING, "Error al obtener metadata", e);
            }
        } else {
            System.out.println("❌ Error en la conexión a PostgreSQL");
        }
    }
    
}