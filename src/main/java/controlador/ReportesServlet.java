/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import dao.OfertaPracticaDAO;
import dao.PostulacionDAO;
import modelo.Usuario;
import modelo.Empresa;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/empresa/reportes")
public class ReportesServlet extends HttpServlet {
    
    private OfertaPracticaDAO ofertaDAO;
    private PostulacionDAO postulacionDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        ofertaDAO = new OfertaPracticaDAO();
        postulacionDAO = new PostulacionDAO();
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
            Empresa empresa = (Empresa) session.getAttribute("empresa");
            
            System.out.println("📊 Cargando reportes para empresa: " + usuario.getUsername());
            
            // Obtener estadísticas básicas
            int totalOfertas = contarOfertasPorEmpresa(empresa.getIdEmpresa());
            int totalPostulaciones = contarPostulacionesPorEmpresa(empresa.getIdEmpresa());
            int postulacionesPendientes = contarPostulacionesPendientesPorEmpresa(empresa.getIdEmpresa());
            int postulacionesAceptadas = contarPostulacionesAceptadasPorEmpresa(empresa.getIdEmpresa());
            
            // Calcular métricas adicionales
            double promedioPostulaciones = totalOfertas > 0 ? (double) totalPostulaciones / totalOfertas : 0;
            int tasaRespuesta = totalPostulaciones > 0 ? 
                (int) ((double) (postulacionesAceptadas + (totalPostulaciones - postulacionesPendientes - postulacionesAceptadas)) / totalPostulaciones * 100) : 0;
            
            // Establecer atributos para la vista
            request.setAttribute("empresa", empresa);
            request.setAttribute("totalOfertas", totalOfertas);
            request.setAttribute("totalPostulaciones", totalPostulaciones);
            request.setAttribute("postulacionesPendientes", postulacionesPendientes);
            request.setAttribute("postulacionesAceptadas", postulacionesAceptadas);
            request.setAttribute("promedioPostulaciones", String.format("%.1f", promedioPostulaciones));
            request.setAttribute("tasaRespuesta", tasaRespuesta);
            
            // Datos adicionales para reportes
            request.setAttribute("mesActual", java.time.LocalDate.now().getMonth().toString());
            request.setAttribute("añoActual", java.time.LocalDate.now().getYear());
            
            System.out.println("✅ Estadísticas cargadas - Ofertas:" + totalOfertas + 
                             " Postulaciones:" + totalPostulaciones + 
                             " Pendientes:" + postulacionesPendientes);
            
        } catch (Exception e) {
            System.err.println("💥 Error al cargar reportes: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar los reportes: " + e.getMessage());
            
            // Valores por defecto en caso de error
            request.setAttribute("totalOfertas", 0);
            request.setAttribute("totalPostulaciones", 0);
            request.setAttribute("postulacionesPendientes", 0);
            request.setAttribute("postulacionesAceptadas", 0);
            request.setAttribute("promedioPostulaciones", "0.0");
            request.setAttribute("tasaRespuesta", 0);
        }
        
        // Mostrar la vista de reportes
        request.getRequestDispatcher("/vistas/empresa/reportes.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        try {
            if ("generar".equals(accion)) {
                generarReporte(request, response);
            } else if ("filtrar".equals(accion)) {
                aplicarFiltros(request, response);
            } else {
                doGet(request, response);
            }
        } catch (Exception e) {
            System.err.println("💥 Error en POST reportes: " + e.getMessage());
            request.setAttribute("error", "Error al procesar la solicitud: " + e.getMessage());
            doGet(request, response);
        }
    }
    
    private void generarReporte(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String tipoReporte = request.getParameter("tipo");
        String formato = request.getParameter("formato");
        
        System.out.println("📄 Generando reporte tipo: " + tipoReporte + " formato: " + formato);
        
        // Aquí iría la lógica real de generación de reportes
        // Por ahora simularemos la respuesta
        
        switch (tipoReporte) {
            case "ofertas":
                request.setAttribute("mensaje", "Reporte de ofertas generado exitosamente.");
                break;
            case "postulaciones":
                request.setAttribute("mensaje", "Reporte de postulaciones generado exitosamente.");
                break;
            case "rendimiento":
                request.setAttribute("mensaje", "Reporte de rendimiento generado exitosamente.");
                break;
            case "personalizado":
                request.setAttribute("mensaje", "Reporte personalizado generado exitosamente.");
                break;
            default:
                request.setAttribute("error", "Tipo de reporte no válido.");
        }
        
        doGet(request, response);
    }
    
    private void aplicarFiltros(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String fechaInicio = request.getParameter("fechaInicio");
        String fechaFin = request.getParameter("fechaFin");
        String estado = request.getParameter("estado");
        
        System.out.println("🔍 Aplicando filtros - Inicio: " + fechaInicio + " Fin: " + fechaFin + " Estado: " + estado);
        
        // Guardar filtros en la sesión para mantenerlos
        HttpSession session = request.getSession();
        session.setAttribute("filtroFechaInicio", fechaInicio);
        session.setAttribute("filtroFechaFin", fechaFin);
        session.setAttribute("filtroEstado", estado);
        
        request.setAttribute("mensaje", "Filtros aplicados exitosamente.");
        request.setAttribute("filtrosAplicados", true);
        
        doGet(request, response);
    }
    
    // Métodos auxiliares para obtener estadísticas
    private int contarOfertasPorEmpresa(int empresaId) {
        try {
            // Aquí iría la consulta real a la base de datos
            // Por ahora retornamos valores simulados
            return 5;
        } catch (Exception e) {
            System.err.println("Error contando ofertas: " + e.getMessage());
            return 0;
        }
    }
    
    private int contarPostulacionesPorEmpresa(int empresaId) {
        try {
            // Consulta simulada
            return 12;
        } catch (Exception e) {
            System.err.println("Error contando postulaciones: " + e.getMessage());
            return 0;
        }
    }
    
    private int contarPostulacionesPendientesPorEmpresa(int empresaId) {
        try {
            // Consulta simulada
            return 4;
        } catch (Exception e) {
            System.err.println("Error contando pendientes: " + e.getMessage());
            return 0;
        }
    }
    
    private int contarPostulacionesAceptadasPorEmpresa(int empresaId) {
        try {
            // Consulta simulada
            return 6;
        } catch (Exception e) {
            System.err.println("Error contando aceptadas: " + e.getMessage());
            return 0;
        }
    }
}