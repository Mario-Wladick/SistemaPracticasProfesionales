/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import dao.UsuarioDAO;
import modelo.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/admin/usuarios")
public class UsuariosAdminServlet extends HttpServlet {
    
    private UsuarioDAO usuarioDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        this.usuarioDAO = new UsuarioDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Verificar autenticación y rol de administrador
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (!"admin".equals(usuario.getTipoUsuario().toLowerCase())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Acceso denegado");
            return;
        }
        
        try {
            // Obtener parámetros de filtro
            String filtroTipo = request.getParameter("tipo");
            String busqueda = request.getParameter("busqueda");
            
            // Obtener todos los usuarios
            List<Usuario> todosUsuarios = usuarioDAO.obtenerTodos();
            
            // Aplicar filtros
            List<Usuario> usuariosFiltrados = todosUsuarios;
            
            if (filtroTipo != null && !filtroTipo.isEmpty() && !"todos".equals(filtroTipo)) {
                usuariosFiltrados = usuariosFiltrados.stream()
                    .filter(u -> filtroTipo.equals(u.getTipoUsuario().toLowerCase()))
                    .collect(Collectors.toList());
            }
            
            if (busqueda != null && !busqueda.trim().isEmpty()) {
                String busquedaLower = busqueda.toLowerCase().trim();
                usuariosFiltrados = usuariosFiltrados.stream()
                    .filter(u -> u.getUsername().toLowerCase().contains(busquedaLower) ||
                               u.getEmail().toLowerCase().contains(busquedaLower))
                    .collect(Collectors.toList());
            }
            
            // Calcular estadísticas
            long totalUsuarios = todosUsuarios.size();
            long totalAdmins = todosUsuarios.stream().filter(u -> "admin".equals(u.getTipoUsuario())).count();
            long totalEstudiantes = todosUsuarios.stream().filter(u -> "estudiante".equals(u.getTipoUsuario())).count();
            long totalEmpresas = todosUsuarios.stream().filter(u -> "empresa".equals(u.getTipoUsuario())).count();
            
            // Establecer atributos para la vista
            request.setAttribute("usuarios", usuariosFiltrados);
            request.setAttribute("totalUsuarios", totalUsuarios);
            request.setAttribute("totalAdmins", totalAdmins);
            request.setAttribute("totalEstudiantes", totalEstudiantes);
            request.setAttribute("totalEmpresas", totalEmpresas);
            request.setAttribute("filtroTipo", filtroTipo);
            request.setAttribute("busqueda", busqueda);
            
            // Reenviar a la vista
            request.getRequestDispatcher("/vistas/admin/usuarios.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error interno del servidor");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Verificar autenticación y rol de administrador
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (!"admin".equals(usuario.getTipoUsuario().toLowerCase())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Acceso denegado");
            return;
        }
        
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "crear":
                    crearUsuario(request, response);
                    break;
                case "editar":
                    editarUsuario(request, response);
                    break;
                case "eliminar":
                    eliminarUsuario(request, response);
                    break;
                case "cambiar_estado":
                    cambiarEstadoUsuario(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción no válida");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error interno del servidor");
        }
    }
    
    private void crearUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String tipoUsuario = request.getParameter("tipoUsuario");
        
        // Validaciones básicas
        if (username == null || username.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            tipoUsuario == null || tipoUsuario.trim().isEmpty()) {
            
            request.setAttribute("error", "Todos los campos son obligatorios");
            doGet(request, response);
            return;
        }
        
        // Verificar si el usuario ya existe
        if (usuarioDAO.existeUsuario(username)) {
            request.setAttribute("error", "El nombre de usuario ya existe");
            doGet(request, response);
            return;
        }
        
        // Crear nuevo usuario
        Usuario nuevoUsuario = new Usuario();
        nuevoUsuario.setUsername(username.trim());
        nuevoUsuario.setEmail(email.trim());
        nuevoUsuario.setPassword(password); // En producción, encriptar la contraseña
        nuevoUsuario.setTipoUsuario(tipoUsuario);
        
        usuarioDAO.insertar(nuevoUsuario);
        
        request.setAttribute("mensaje", "Usuario creado exitosamente");
        response.sendRedirect(request.getContextPath() + "/admin/usuarios?mensaje=Usuario creado exitosamente");
    }
    
    private void editarUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
        String email = request.getParameter("email");
        String tipoUsuario = request.getParameter("tipoUsuario");
        
        Usuario usuario = usuarioDAO.obtenerPorId(idUsuario);
        if (usuario == null) {
            request.setAttribute("error", "Usuario no encontrado");
            doGet(request, response);
            return;
        }
        
        // Actualizar datos
        usuario.setEmail(email.trim());
        usuario.setTipoUsuario(tipoUsuario);
        
        usuarioDAO.actualizar(usuario);
        
        response.sendRedirect(request.getContextPath() + "/admin/usuarios?mensaje=Usuario actualizado exitosamente");
    }
    
    private void eliminarUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
        
        // No permitir eliminar al usuario actual
        Usuario usuarioActual = (Usuario) request.getSession().getAttribute("usuario");
        if (usuarioActual.getIdUsuario() == idUsuario) {
            request.setAttribute("error", "No puedes eliminar tu propia cuenta");
            doGet(request, response);
            return;
        }
        
        usuarioDAO.eliminar(idUsuario);
        
        response.sendRedirect(request.getContextPath() + "/admin/usuarios?mensaje=Usuario eliminado exitosamente");
    }
    
    private void cambiarEstadoUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
        boolean activo = Boolean.parseBoolean(request.getParameter("activo"));
        
        // Aquí implementarías la lógica para activar/desactivar usuario
        // Si tu modelo Usuario tiene un campo "activo"
        
        response.sendRedirect(request.getContextPath() + "/admin/usuarios?mensaje=Estado del usuario actualizado");
    }
}