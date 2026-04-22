/*
 * RegistroEstudianteServlet - Versión PostgreSQL Optimizada
 * Sistema de Prácticas Profesionales - FINESI
 */
package controlador;

import dao.EstudianteDAO;
import dao.UsuarioDAO;
import modelo.Estudiante;
import modelo.Usuario;
import util.ConexionDB;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/registro/estudiante")
public class RegistroEstudianteServlet extends HttpServlet {
    
    private static final Logger logger = Logger.getLogger(RegistroEstudianteServlet.class.getName());
    private UsuarioDAO usuarioDAO;
    private EstudianteDAO estudianteDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        usuarioDAO = new UsuarioDAO();
        estudianteDAO = new EstudianteDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Mostrar formulario de registro
        request.getRequestDispatcher("/vistas/registro/estudiante.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Configurar encoding para PostgreSQL
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        Connection conn = null;
        
        try {
            // Obtener parámetros del formulario
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
            String codigoUniversitario = request.getParameter("codigoUniversitario");
            String nombres = request.getParameter("nombres");
            String apellidos = request.getParameter("apellidos");
            String dni = request.getParameter("dni");
            String email = request.getParameter("email");
            String telefono = request.getParameter("telefono");
            String cicloStr = request.getParameter("ciclo");
            String promedioStr = request.getParameter("promedio");
            String especialidad = request.getParameter("especialidad");
            
            // =================== VALIDACIONES MEJORADAS ===================
            
            // Validaciones básicas
            if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                nombres == null || nombres.trim().isEmpty() ||
                apellidos == null || apellidos.trim().isEmpty() ||
                dni == null || dni.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                codigoUniversitario == null || codigoUniversitario.trim().isEmpty()) {
                
                request.setAttribute("error", "Todos los campos obligatorios deben ser completados.");
                request.getRequestDispatcher("/vistas/registro/estudiante.jsp").forward(request, response);
                return;
            }
            
            // Validar confirmación de contraseña
            if (!password.equals(confirmPassword)) {
                request.setAttribute("error", "Las contraseñas no coinciden.");
                request.getRequestDispatcher("/vistas/registro/estudiante.jsp").forward(request, response);
                return;
            }
            
            // Validar longitud de contraseña
            if (password.length() < 6) {
                request.setAttribute("error", "La contraseña debe tener al menos 6 caracteres.");
                request.getRequestDispatcher("/vistas/registro/estudiante.jsp").forward(request, response);
                return;
            }
            
            // Validar formato de email
            if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {
                request.setAttribute("error", "Formato de email inválido.");
                request.getRequestDispatcher("/vistas/registro/estudiante.jsp").forward(request, response);
                return;
            }
            
            // Validar DNI (8 dígitos para Perú)
            if (!dni.matches("^[0-9]{8}$")) {
                request.setAttribute("error", "El DNI debe tener exactamente 8 dígitos.");
                request.getRequestDispatcher("/vistas/registro/estudiante.jsp").forward(request, response);
                return;
            }
            
            // Validar código universitario
            if (!codigoUniversitario.matches("^[0-9]{6,10}$")) {
    request.setAttribute("error", "El código universitario debe tener entre 6 y 10 dígitos.");
    request.getRequestDispatcher("/vistas/registro/estudiante.jsp").forward(request, response);
    return;
}
            
            // =================== TRANSACCIÓN POSTGRESQL ===================
            
            // Obtener conexión
            conn = ConexionDB.getConexion();
            if (conn == null) {
                throw new SQLException("No se pudo establecer conexión con PostgreSQL");
            }
            
            // Iniciar transacción
            conn.setAutoCommit(false);
            logger.info("Iniciando transacción de registro para usuario: " + username);
            
            // =================== VERIFICACIONES DE UNICIDAD ===================
            
            // Verificar si el usuario ya existe
            if (usuarioDAO.existePorUsername(username.trim())) {
                request.setAttribute("error", "El nombre de usuario ya está registrado.");
                request.getRequestDispatcher("/vistas/registro/estudiante.jsp").forward(request, response);
                return;
            }
            
            // Verificar si el email ya existe
            if (usuarioDAO.existePorEmail(email.trim())) {
                request.setAttribute("error", "El email ya está registrado en el sistema.");
                request.getRequestDispatcher("/vistas/registro/estudiante.jsp").forward(request, response);
                return;
            }
            
            // Verificar si el DNI ya existe
            if (estudianteDAO.existePorDni(dni.trim())) {
                request.setAttribute("error", "El DNI ya está registrado.");
                request.getRequestDispatcher("/vistas/registro/estudiante.jsp").forward(request, response);
                return;
            }
            
            // Verificar si el código universitario ya existe
            if (estudianteDAO.existePorCodigoUniversitario(codigoUniversitario.trim())) {
                request.setAttribute("error", "El código universitario ya está registrado.");
                request.getRequestDispatcher("/vistas/registro/estudiante.jsp").forward(request, response);
                return;
            }
            
            // =================== CREAR Y GUARDAR USUARIO ===================
            
            Usuario usuario = new Usuario();
            usuario.setUsername(username.trim());
            usuario.setPassword(password); // TODO: Implementar encriptación BCrypt
            usuario.setEmail(email.trim().toLowerCase());
            usuario.setTipoUsuario("estudiante"); // Minúscula para PostgreSQL
            usuario.setEstado(true);
            usuario.setFechaRegistro(new Timestamp(System.currentTimeMillis()));
            
            // Insertar usuario y obtener ID generado
            int usuarioId = usuarioDAO.insertarConRetorno(usuario);
            
            if (usuarioId <= 0) {
                throw new SQLException("Error al insertar usuario - ID no válido");
            }
            
            logger.info("Usuario registrado exitosamente con ID: " + usuarioId);
            
            // =================== CREAR Y GUARDAR ESTUDIANTE ===================
            
            Estudiante estudiante = new Estudiante();
            estudiante.setIdUsuario(usuarioId);
            estudiante.setCodigoUniversitario(codigoUniversitario.trim().toUpperCase());
            estudiante.setNombres(nombres.trim());
            estudiante.setApellidos(apellidos.trim());
            estudiante.setDni(dni.trim());
            estudiante.setEmail(email.trim().toLowerCase());
            estudiante.setTelefono(telefono != null && !telefono.trim().isEmpty() ? telefono.trim() : null);
            
            // Procesar ciclo con validación
            try {
                if (cicloStr != null && !cicloStr.trim().isEmpty()) {
                    int ciclo = Integer.parseInt(cicloStr);
                    if (ciclo >= 1 && ciclo <= 10) {
                        estudiante.setCiclo(ciclo);
                    } else {
                        estudiante.setCiclo(1);
                        logger.warning("Ciclo fuera de rango para usuario: " + username + ", establecido en 1");
                    }
                } else {
                    estudiante.setCiclo(1);
                }
            } catch (NumberFormatException e) {
                estudiante.setCiclo(1);
                logger.warning("Error al parsear ciclo para usuario: " + username);
            }
            
            // Procesar promedio con validación
            try {
                if (promedioStr != null && !promedioStr.trim().isEmpty()) {
                    double promedio = Double.parseDouble(promedioStr);
                    if (promedio >= 0.0 && promedio <= 20.0) {
                        estudiante.setPromedioPonderado(promedio);
                    } else {
                        estudiante.setPromedioPonderado(0.0);
                        logger.warning("Promedio fuera de rango para usuario: " + username);
                    }
                } else {
                    estudiante.setPromedioPonderado(0.0);
                }
            } catch (NumberFormatException e) {
                estudiante.setPromedioPonderado(0.0);
                logger.warning("Error al parsear promedio para usuario: " + username);
            }
            
            // Establecer especialidad
            estudiante.setEspecialidad(especialidad != null && !especialidad.trim().isEmpty() ? 
                                     especialidad : "Ingeniería de Sistemas");
            
            // Insertar estudiante
            estudianteDAO.insertar(estudiante);
boolean estudianteInsertado = true;
            
            if (!estudianteInsertado) {
                throw new SQLException("Error al insertar datos del estudiante");
            }
            
            // =================== CONFIRMAR TRANSACCIÓN ===================
            
            conn.commit();
            logger.info("Registro completado exitosamente para: " + username);
            
            // =================== RESPUESTA EXITOSA ===================
            
            // Redirigir a login con mensaje de éxito
            response.sendRedirect(request.getContextPath() + 
                "/login?registro=exitoso&mensaje=Registro completado exitosamente. Ya puedes iniciar sesión.");
            
        } catch (SQLException e) {
            // Rollback automático en caso de error de base de datos
            if (conn != null) {
                try {
                    conn.rollback();
                    logger.warning("Rollback ejecutado debido a error SQL");
                } catch (SQLException rollbackEx) {
                    logger.log(Level.SEVERE, "Error en rollback", rollbackEx);
                }
            }
            
            logger.log(Level.SEVERE, "Error SQL en registro de estudiante", e);
            request.setAttribute("error", "Error de base de datos: " + e.getMessage());
            request.getRequestDispatcher("/vistas/registro/estudiante.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            logger.log(Level.WARNING, "Error de formato numérico", e);
            request.setAttribute("error", "Error en el formato de los datos numéricos.");
            request.getRequestDispatcher("/vistas/registro/estudiante.jsp").forward(request, response);
            
        } catch (Exception e) {
            // Error general
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException rollbackEx) {
                    logger.log(Level.SEVERE, "Error en rollback", rollbackEx);
                }
            }
            
            logger.log(Level.SEVERE, "Error inesperado en registro de estudiante", e);
            request.setAttribute("error", "Error interno del sistema. Por favor, contacta al administrador.");
            request.getRequestDispatcher("/vistas/error.jsp").forward(request, response);
            
        } finally {
            // Cerrar conexión y restaurar autocommit
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    ConexionDB.cerrarConexion();
                } catch (SQLException e) {
                    logger.log(Level.WARNING, "Error al cerrar conexión", e);
                }
            }
        }
    }
}   