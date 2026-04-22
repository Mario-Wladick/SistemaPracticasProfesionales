package controlador;

import dao.EstudianteDAO;
import dao.UsuarioDAO;
import dao.EmpresaDAO;
import dao.SupervisorDAO;
import modelo.Estudiante;
import modelo.Empresa;
import modelo.Supervisor;
import modelo.Usuario;
import util.ConexionDB;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UsuarioDAO usuarioDAO;
    private EstudianteDAO estudianteDAO;
    private EmpresaDAO empresaDAO;
    private SupervisorDAO supervisorDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        usuarioDAO = new UsuarioDAO();
        estudianteDAO = new EstudianteDAO();
        empresaDAO = new EmpresaDAO();
        supervisorDAO = new SupervisorDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Si el usuario ya está logueado, redireccionar a página principal según su tipo
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("usuario") != null) {
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            redireccionarSegunTipoUsuario(request, response, usuario);
        } else {
            // Mostrar la página de login
            request.getRequestDispatcher("/vistas/login.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("🚀 Iniciando proceso de login - Probando conexión BD...");
        ConexionDB.probarConexion();
        
        // CAMBIO: Usar los nombres correctos de los parámetros del formulario
        String username = request.getParameter("usuario");  // Cambié de "username" a "usuario"
        String password = request.getParameter("contrasena"); // Cambié de "password" a "contrasena"
        String error = null;
        
        System.out.println("📝 Datos recibidos - Usuario: " + username + ", Password: " + (password != null ? "***" : "null"));
        
        try {
            // Autenticar usuario
            Usuario usuario = usuarioDAO.autenticar(username, password);
            
            if (usuario != null) {
                System.out.println("✅ Usuario autenticado: " + usuario.getUsername() + " - Tipo: " + usuario.getTipoUsuario());
                
                // Crear sesión
                HttpSession session = request.getSession(true);
                session.setAttribute("usuario", usuario);
                session.setAttribute("tipoUsuario", usuario.getTipoUsuario());
                session.setAttribute("nombreUsuario", usuario.getUsername());
                
                // Cargar información adicional según tipo de usuario (CAMBIO: minúsculas)
                switch (usuario.getTipoUsuario().toLowerCase()) {
                    case "estudiante":
                        try {
                            Estudiante estudiante = estudianteDAO.obtenerPorIdUsuario(usuario.getIdUsuario());
                            session.setAttribute("estudiante", estudiante);
                            System.out.println("📚 Datos de estudiante cargados: " + estudiante.getNombres());
                        } catch (Exception e) {
                            System.err.println("⚠️ Error al cargar datos de estudiante: " + e.getMessage());
                        }
                        break;
                    case "empresa":
                        try {
                            Empresa empresa = empresaDAO.obtenerPorIdUsuario(usuario.getIdUsuario());
                            session.setAttribute("empresa", empresa);
                            System.out.println("🏢 Datos de empresa cargados: " + empresa.getRazonSocial());
                        } catch (Exception e) {
                            System.err.println("⚠️ Error al cargar datos de empresa: " + e.getMessage());
                        }
                        break;
                    case "supervisor":
                        try {
                            Supervisor supervisor = supervisorDAO.obtenerPorIdUsuario(usuario.getIdUsuario());
                            session.setAttribute("supervisor", supervisor);
                            System.out.println("👨‍💼 Datos de supervisor cargados");
                        } catch (Exception e) {
                            System.err.println("⚠️ Error al cargar datos de supervisor: " + e.getMessage());
                        }
                        break;
                    case "admin":
                        System.out.println("👑 Usuario admin - sin datos adicionales");
                        break;
                }
                
                // Redirigir a la página correspondiente
                redireccionarSegunTipoUsuario(request, response, usuario);
            } else {
                // Credenciales inválidas
                System.out.println("❌ Credenciales inválidas para usuario: " + username);
                error = "Usuario o contraseña incorrectos";
                request.setAttribute("error", error);
                request.setAttribute("usuario", username); // Mantener el usuario en el formulario
                request.getRequestDispatcher("/vistas/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.err.println("💥 Error durante login: " + e.getMessage());
            e.printStackTrace();
            error = "Error de sistema: " + e.getMessage();
            request.setAttribute("error", error);
            request.getRequestDispatcher("/vistas/login.jsp").forward(request, response);
        }
    }
    
    private void redireccionarSegunTipoUsuario(HttpServletRequest request, HttpServletResponse response, Usuario usuario) throws IOException {
        String tipoUsuario = usuario.getTipoUsuario().toLowerCase();
        System.out.println("🔄 Redirigiendo usuario tipo: " + tipoUsuario);
        
        switch (tipoUsuario) {
            case "admin":
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                break;
            case "estudiante":
                response.sendRedirect(request.getContextPath() + "/estudiante/dashboard");
                break;
            case "empresa":
                response.sendRedirect(request.getContextPath() + "/empresa/dashboard");
                break;
            case "supervisor":
                response.sendRedirect(request.getContextPath() + "/supervisor/dashboard");
                break;
            default:
                System.out.println("⚠️ Tipo de usuario no reconocido: " + tipoUsuario);
                response.sendRedirect(request.getContextPath() + "/");
                break;
        }
    }
}