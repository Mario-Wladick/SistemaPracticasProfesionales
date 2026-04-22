/*
 * RegistroEmpresaServlet - Versión PostgreSQL Optimizada
 * Sistema de Prácticas Profesionales - FINESI
 */
package controlador;

import dao.EmpresaDAO;
import dao.UsuarioDAO;
import modelo.Empresa;
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

@WebServlet("/registro/empresa")
public class RegistroEmpresaServlet extends HttpServlet {
    
    private static final Logger logger = Logger.getLogger(RegistroEmpresaServlet.class.getName());
    private UsuarioDAO usuarioDAO;
    private EmpresaDAO empresaDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        usuarioDAO = new UsuarioDAO();
        empresaDAO = new EmpresaDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Mostrar formulario de registro de empresa
        request.getRequestDispatcher("/vistas/registro/empresa.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Configurar encoding para PostgreSQL
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        Connection conn = null;
        
        try {
            // =================== OBTENER PARÁMETROS DEL FORMULARIO ===================
            
            // Datos de acceso
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
            String emailContacto = request.getParameter("emailContacto");
            
            // Datos de la empresa
            String razonSocial = request.getParameter("razonSocial");
            String ruc = request.getParameter("ruc");
            String descripcion = request.getParameter("descripcion");
            String direccion = request.getParameter("direccion");
            String telefono = request.getParameter("telefono");
            String sitioWeb = request.getParameter("sitioWeb");
            String sector = request.getParameter("sector");
            String tipoEmpresa = request.getParameter("tipoEmpresa");
            
            // =================== VALIDACIONES BÁSICAS ===================
            
            if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                emailContacto == null || emailContacto.trim().isEmpty() ||
                razonSocial == null || razonSocial.trim().isEmpty() ||
                ruc == null || ruc.trim().isEmpty()) {
                
                request.setAttribute("error", "Todos los campos obligatorios deben ser completados.");
                request.getRequestDispatcher("/vistas/registro/empresa.jsp").forward(request, response);
                return;
            }
            
            // Validar confirmación de contraseña
            if (!password.equals(confirmPassword)) {
                request.setAttribute("error", "Las contraseñas no coinciden.");
                request.getRequestDispatcher("/vistas/registro/empresa.jsp").forward(request, response);
                return;
            }
            
            // Validar longitud de contraseña
            if (password.length() < 6) {
                request.setAttribute("error", "La contraseña debe tener al menos 6 caracteres.");
                request.getRequestDispatcher("/vistas/registro/empresa.jsp").forward(request, response);
                return;
            }
            
            // Validar formato de email
            if (!emailContacto.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {
                request.setAttribute("error", "Formato de email inválido.");
                request.getRequestDispatcher("/vistas/registro/empresa.jsp").forward(request, response);
                return;
            }
            
            // Validar RUC (11 dígitos para empresas en Perú)
            if (!ruc.matches("^[0-9]{11}$")) {
                request.setAttribute("error", "El RUC debe tener exactamente 11 dígitos.");
                request.getRequestDispatcher("/vistas/registro/empresa.jsp").forward(request, response);
                return;
            }
            
            // Validar razón social (mínimo 3 caracteres)
            if (razonSocial.trim().length() < 3) {
                request.setAttribute("error", "La razón social debe tener al menos 3 caracteres.");
                request.getRequestDispatcher("/vistas/registro/empresa.jsp").forward(request, response);
                return;
            }
            
            // =================== VALIDACIONES AVANZADAS ===================
            
            // Validar y normalizar sitio web
            if (sitioWeb != null && !sitioWeb.trim().isEmpty()) {
                sitioWeb = sitioWeb.trim().toLowerCase();
                if (!sitioWeb.startsWith("http://") && !sitioWeb.startsWith("https://")) {
                    sitioWeb = "https://" + sitioWeb;
                }
                
                // Validar formato básico de URL
                if (!sitioWeb.matches("^https?://[A-Za-z0-9.-]+\\.[A-Za-z]{2,}.*$")) {
                    request.setAttribute("error", "Formato de sitio web inválido.");
                    request.getRequestDispatcher("/vistas/registro/empresa.jsp").forward(request, response);
                    return;
                }
            }
            
            // Validar teléfono si se proporciona
            if (telefono != null && !telefono.trim().isEmpty()) {
                telefono = telefono.trim().replaceAll("[^0-9]", ""); // Solo números
                if (telefono.length() < 7 || telefono.length() > 15) {
                    request.setAttribute("error", "El teléfono debe tener entre 7 y 15 dígitos.");
                    request.getRequestDispatcher("/vistas/registro/empresa.jsp").forward(request, response);
                    return;
                }
            }
            
            // =================== TRANSACCIÓN POSTGRESQL ===================
            
            // Obtener conexión
            conn = ConexionDB.getConexion();
            if (conn == null) {
                throw new SQLException("No se pudo establecer conexión con PostgreSQL");
            }
            
            // Iniciar transacción
            conn.setAutoCommit(false);
            logger.info("Iniciando transacción de registro para empresa: " + razonSocial);
            
            // =================== VERIFICACIONES DE UNICIDAD ===================
            
            // Verificar si el usuario ya existe
            if (usuarioDAO.existePorUsername(username.trim())) {
                request.setAttribute("error", "El nombre de usuario ya está registrado.");
                request.getRequestDispatcher("/vistas/registro/empresa.jsp").forward(request, response);
                return;
            }
            
            // Verificar si el email ya existe
            if (usuarioDAO.existePorEmail(emailContacto.trim())) {
                request.setAttribute("error", "El email ya está registrado en el sistema.");
                request.getRequestDispatcher("/vistas/registro/empresa.jsp").forward(request, response);
                return;
            }
            
            // Verificar si el RUC ya existe
            if (empresaDAO.existePorRuc(ruc.trim())) {
                request.setAttribute("error", "El RUC ya está registrado en el sistema.");
                request.getRequestDispatcher("/vistas/registro/empresa.jsp").forward(request, response);
                return;
            }
            
            // Verificar si la razón social ya existe
            if (empresaDAO.existePorRazonSocial(razonSocial.trim())) {
                request.setAttribute("error", "Ya existe una empresa con la misma razón social.");
                request.getRequestDispatcher("/vistas/registro/empresa.jsp").forward(request, response);
                return;
            }
            
            // =================== CREAR Y GUARDAR USUARIO ===================
            
            Usuario usuario = new Usuario();
            usuario.setUsername(username.trim());
            usuario.setPassword(password); // TODO: Implementar encriptación BCrypt
            usuario.setEmail(emailContacto.trim().toLowerCase());
            usuario.setTipoUsuario("empresa"); // Minúscula para PostgreSQL
            usuario.setEstado(true);
            usuario.setFechaRegistro(new Timestamp(System.currentTimeMillis()));
            
            // Insertar usuario y obtener ID generado
            int usuarioId = usuarioDAO.insertarConRetorno(usuario);
            
            if (usuarioId <= 0) {
                throw new SQLException("Error al insertar usuario - ID no válido");
            }
            
            logger.info("Usuario empresa registrado exitosamente con ID: " + usuarioId);
            
            // =================== CREAR Y GUARDAR EMPRESA ===================
            
            Empresa empresa = new Empresa();
            empresa.setIdUsuario(usuarioId);
            empresa.setRazonSocial(razonSocial.trim());
            empresa.setRuc(ruc.trim());
            empresa.setDescripcion(descripcion != null && !descripcion.trim().isEmpty() ? 
                                 descripcion.trim() : null);
            empresa.setDireccion(direccion != null && !direccion.trim().isEmpty() ? 
                               direccion.trim() : null);
            empresa.setTelefono(telefono != null && !telefono.trim().isEmpty() ? 
                              telefono.trim() : null);
            empresa.setSitioWeb(sitioWeb != null && !sitioWeb.trim().isEmpty() ? 
                              sitioWeb.trim() : null);
            
            // Establecer sector
            if (sector != null && !sector.trim().isEmpty() && !sector.equals("selecciona")) {
                empresa.setSector(sector);
            } else {
                empresa.setSector("Tecnología"); // Valor por defecto
            }
            
            // Establecer tipo de empresa
            if (tipoEmpresa != null && !tipoEmpresa.trim().isEmpty() && !tipoEmpresa.equals("selecciona")) {
                empresa.setTipoEmpresa(tipoEmpresa);
            } else {
                empresa.setTipoEmpresa("mediana"); // Valor por defecto
            }
            
            // Estado inicial: no verificada (requiere aprobación del admin)
            empresa.setVerificada(false);
            empresa.setFechaRegistro(new Timestamp(System.currentTimeMillis()));
            
            // Insertar empresa
            empresaDAO.insertar(empresa);
boolean empresaGuardada = true;
            
            if (!empresaGuardada) {
                throw new SQLException("Error al insertar datos de la empresa");
            }
            
            // =================== CONFIRMAR TRANSACCIÓN ===================
            
            conn.commit();
            logger.info("Registro de empresa completado exitosamente: " + razonSocial + " (RUC: " + ruc + ")");
            
            // =================== RESPUESTA EXITOSA ===================
            
            // Redirigir a login con mensaje especial para empresas
            String mensaje = "Registro exitoso. Tu empresa ha sido registrada y está pendiente de verificación. " +
                           "Recibirás una confirmación por email una vez que sea aprobada por nuestro equipo.";
            
            response.sendRedirect(request.getContextPath() + 
                "/login?registro=empresa&mensaje=" + java.net.URLEncoder.encode(mensaje, "UTF-8"));
            
        } catch (SQLException e) {
            // Rollback automático en caso de error de base de datos
            if (conn != null) {
                try {
                    conn.rollback();
                    logger.warning("Rollback ejecutado debido a error SQL en registro de empresa");
                } catch (SQLException rollbackEx) {
                    logger.log(Level.SEVERE, "Error en rollback", rollbackEx);
                }
            }
            
            logger.log(Level.SEVERE, "Error SQL en registro de empresa", e);
            
            // Mensaje de error específico según el tipo de violación
            String errorMsg;
            if (e.getMessage().contains("unique") || e.getMessage().contains("duplicate")) {
                errorMsg = "Ya existe una empresa registrada con estos datos. Verifica RUC, email o razón social.";
            } else {
                errorMsg = "Error de base de datos: " + e.getMessage();
            }
            
            request.setAttribute("error", errorMsg);
            request.getRequestDispatcher("/vistas/registro/empresa.jsp").forward(request, response);
            
        } catch (Exception e) {
            // Error general
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException rollbackEx) {
                    logger.log(Level.SEVERE, "Error en rollback", rollbackEx);
                }
            }
            
            logger.log(Level.SEVERE, "Error inesperado en registro de empresa", e);
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