/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet para cerrar sesión de usuarios
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Obtener la sesión actual
        HttpSession session = request.getSession(false);
        
        // Si existe una sesión, invalidarla
        if (session != null) {
            // Limpiar atributos específicos si es necesario
            session.removeAttribute("usuario");
            session.removeAttribute("estudiante");
            session.removeAttribute("empresa");
            session.removeAttribute("supervisor");
            
            // Invalidar completamente la sesión
            session.invalidate();
        }
        
        // Redirigir a la página de login con mensaje opcional
        response.sendRedirect(request.getContextPath() + "/login?logout=true");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirigir al método GET para mantener consistencia
        doGet(request, response);
    }
}