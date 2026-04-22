/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import dao.EstudianteDAO;
import modelo.Usuario;
import modelo.Estudiante;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/estudiante/practicas")
public class PracticasEstudianteServlet extends HttpServlet {
    
    private EstudianteDAO estudianteDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        this.estudianteDAO = new EstudianteDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Verificar autenticación (igual que el servlet de perfil)
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        
        // Verificar que sea un estudiante (igual que el servlet de perfil)
        if (!"estudiante".equals(usuario.getTipoUsuario().toLowerCase())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            // Obtener estudiante (igual que el servlet de perfil)
            Estudiante estudiante = (Estudiante) session.getAttribute("estudiante");
            
            if (estudiante == null) {
                estudiante = estudianteDAO.obtenerPorIdUsuario(usuario.getIdUsuario());
                if (estudiante != null) {
                    session.setAttribute("estudiante", estudiante);
                }
            }
            
            // Establecer atributos para la vista
            request.setAttribute("estudiante", estudiante);
            
            // Reenviar a la vista
            request.getRequestDispatcher("/vistas/estudiante/practicas.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error interno del servidor");
        }
    }
}