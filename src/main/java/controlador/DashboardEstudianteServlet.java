/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import dao.EstudianteDAO;
import dao.OfertaPracticaDAO;
import modelo.Usuario;
import modelo.Estudiante;
import modelo.OfertaPractica;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/estudiante/dashboard")
public class DashboardEstudianteServlet extends HttpServlet {
    
    private EstudianteDAO estudianteDAO;
    private OfertaPracticaDAO ofertaDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        estudianteDAO = new EstudianteDAO();
        ofertaDAO = new OfertaPracticaDAO();
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
        
        // Verificar que sea un estudiante
        if (!"estudiante".equals(usuario.getTipoUsuario().toLowerCase())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            System.out.println("🎓 Cargando dashboard para estudiante: " + usuario.getUsername());
            
            // Obtener datos del estudiante
            Estudiante estudiante = (Estudiante) session.getAttribute("estudiante");
            if (estudiante == null) {
                estudiante = estudianteDAO.obtenerPorIdUsuario(usuario.getIdUsuario());
                if (estudiante != null) {
                    session.setAttribute("estudiante", estudiante);
                    System.out.println("✅ Datos de estudiante cargados: " + estudiante.getNombres());
                }
            }
            
            // 🚀 NUEVO: Obtener ofertas reales de la base de datos
            int totalOfertasReales = 0;
            List<OfertaPractica> ofertasRecientes = null;
            
            try {
                totalOfertasReales = ofertaDAO.contarOfertasActivas();
                ofertasRecientes = ofertaDAO.obtenerUltimasOfertasActivas(5); // Últimas 5 ofertas
                System.out.println("📊 Ofertas reales encontradas: " + totalOfertasReales);
                System.out.println("🔍 Ofertas recientes para mostrar: " + ofertasRecientes.size());
            } catch (Exception e) {
                System.err.println("⚠️ Error al consultar ofertas reales: " + e.getMessage());
                totalOfertasReales = 0;
            }
            
            // 📈 Combinar datos reales + ficticios para demo completa
            int ofertasFicticias = 3; // Las que ya tienes en el JSP
            int totalOfertas = totalOfertasReales + ofertasFicticias;
            
            // Datos del dashboard (combinando reales + simulados)
            request.setAttribute("estudiante", estudiante);
            
            // ✅ DATOS REALES
            request.setAttribute("totalOfertas", totalOfertas);
            request.setAttribute("totalOfertasReales", totalOfertasReales);
            request.setAttribute("ofertasRecientes", ofertasRecientes);
            
            // 📋 DATOS SIMULADOS PARA DEMO (mejorados)
            request.setAttribute("totalPostulaciones", 3);
            request.setAttribute("postulacionesPendientes", 1);
            request.setAttribute("postulacionesAceptadas", 1);
            request.setAttribute("postulacionesRechazadas", 1);
            request.setAttribute("ofertasRecomendadas", Math.max(2, totalOfertasReales));
            request.setAttribute("alertasImportantes", 0);
            request.setAttribute("necesitaAtencion", false);
            request.setAttribute("perfilIncompleto", false);
            
            // 🎯 DATOS ADICIONALES PARA EL DASHBOARD
            request.setAttribute("progresoGeneral", 85);
            request.setAttribute("practicasActivas", 2);
            request.setAttribute("horasCompletadas", 320);
            
            System.out.println("📊 Dashboard cargado - Ofertas totales: " + totalOfertas + 
                             " (Reales: " + totalOfertasReales + " + Ficticias: " + ofertasFicticias + ")");
            
        } catch (Exception e) {
            System.err.println("💥 Error al cargar dashboard de estudiante: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar el dashboard: " + e.getMessage());
            
            // En caso de error, usar datos por defecto
            request.setAttribute("totalOfertas", 3);
            request.setAttribute("totalOfertasReales", 0);
        }
        
        // Mostrar la vista del dashboard
        request.getRequestDispatcher("/vistas/estudiante/dashboard.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}