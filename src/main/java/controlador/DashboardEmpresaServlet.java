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

@WebServlet("/empresa/dashboard")
public class DashboardEmpresaServlet extends HttpServlet {
    
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
            System.out.println("🏢 Cargando dashboard para empresa: " + usuario.getUsername());
            
            // Obtener datos de la empresa
            Empresa empresa = (Empresa) session.getAttribute("empresa");
            if (empresa == null) {
                empresa = empresaDAO.obtenerPorIdUsuario(usuario.getIdUsuario());
                if (empresa != null) {
                    session.setAttribute("empresa", empresa);
                    System.out.println("✅ Datos de empresa cargados: " + empresa.getRazonSocial());
                }
            }
            
            // Datos básicos para la vista (valores simulados por ahora)
            request.setAttribute("empresa", empresa);
            request.setAttribute("totalOfertas", 5);
            request.setAttribute("ofertasActivas", 3);
            request.setAttribute("totalPostulaciones", 12);
            request.setAttribute("postulacionesPendientes", 4);
            request.setAttribute("postulacionesAceptadas", 6);
            request.setAttribute("postulacionesRechazadas", 2);
            request.setAttribute("alertasImportantes", 1);
            request.setAttribute("necesitaAtencion", true);
            
            System.out.println("📊 Dashboard básico cargado para: " + (empresa != null ? empresa.getRazonSocial() : "Empresa"));
            
        } catch (Exception e) {
            System.err.println("💥 Error al cargar dashboard de empresa: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar el dashboard: " + e.getMessage());
        }
        
        // Mostrar la vista del dashboard
        request.getRequestDispatcher("/vistas/empresa/dashboard.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}