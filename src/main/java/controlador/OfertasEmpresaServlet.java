/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import dao.EmpresaDAO;
import modelo.Usuario;
import modelo.Empresa;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/empresa/ofertas")
public class OfertasEmpresaServlet extends HttpServlet {
    
    private EmpresaDAO empresaDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        empresaDAO = new EmpresaDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Verificar autenticación
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        
        // Verificar que sea una empresa
        if (!"empresa".equals(usuario.getTipoUsuario().toLowerCase())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            System.out.println("💼 Cargando ofertas para empresa: " + usuario.getUsername());
            
            Empresa empresa = (Empresa) session.getAttribute("empresa");
            if (empresa == null) {
                empresa = empresaDAO.obtenerPorIdUsuario(usuario.getIdUsuario());
                session.setAttribute("empresa", empresa);
            }
            
            // Datos para la vista
            request.setAttribute("empresa", empresa);
            request.setAttribute("mensaje", "Módulo de ofertas en desarrollo");
            
        } catch (Exception e) {
            System.err.println("💥 Error en OfertasEmpresaServlet: " + e.getMessage());
            request.setAttribute("error", "Error al cargar las ofertas");
        }
        
        // Por ahora mostrar JSP básico
        request.getRequestDispatcher("/vistas/empresa/ofertas.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}