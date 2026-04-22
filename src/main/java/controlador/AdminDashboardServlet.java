/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import dao.EstudianteDAO;
import dao.EmpresaDAO;
import dao.OfertaPracticaDAO;
import dao.PracticaDAO;
import dao.UsuarioDAO;
import modelo.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private UsuarioDAO usuarioDAO;
    private EstudianteDAO estudianteDAO;
    private EmpresaDAO empresaDAO;
    private OfertaPracticaDAO ofertaPracticaDAO;
    private PracticaDAO practicaDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        usuarioDAO = new UsuarioDAO();
        estudianteDAO = new EstudianteDAO();
        empresaDAO = new EmpresaDAO();
        ofertaPracticaDAO = new OfertaPracticaDAO();
        practicaDAO = new PracticaDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Verificar autenticación
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        
        // Verificar que sea administrador
        if (!"admin".equals(usuario.getTipoUsuario().toLowerCase())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            // Obtener estadísticas generales
            int totalUsuarios = usuarioDAO.obtenerTodos().size();
            int totalEstudiantes = estudianteDAO.obtenerTodos().size();
            int totalEmpresas = empresaDAO.obtenerTodos().size();
            int ofertasActivas = ofertaPracticaDAO.contarOfertasActivas();
            int totalPracticas = practicaDAO.obtenerTodos().size();
            
            // Obtener empresas pendientes de aprobación
            int empresasPendientes = empresaDAO.obtenerPorEstado("PENDIENTE").size();
            
            // Establecer atributos para la vista
            request.setAttribute("totalUsuarios", totalUsuarios);
            request.setAttribute("totalEstudiantes", totalEstudiantes);
            request.setAttribute("totalEmpresas", totalEmpresas);
            request.setAttribute("ofertasActivas", ofertasActivas);
            request.setAttribute("totalPracticas", totalPracticas);
            request.setAttribute("empresasPendientes", empresasPendientes);
            
            // Mostrar el dashboard
            request.getRequestDispatcher("/vistas/admin/dashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar el dashboard: " + e.getMessage());
            request.getRequestDispatcher("/vistas/error.jsp").forward(request, response);
        }
    }
}