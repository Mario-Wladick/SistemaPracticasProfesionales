/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import dao.PracticaDAO;
import dao.EstudianteDAO;
import dao.EmpresaDAO;
import modelo.Practica;
import modelo.Estudiante;
import modelo.Empresa;
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

@WebServlet("/admin/practicas")
public class PracticasAdminServlet extends HttpServlet {
    
    private PracticaDAO practicaDAO;
    private EstudianteDAO estudianteDAO;
    private EmpresaDAO empresaDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        this.practicaDAO = new PracticaDAO();
        this.estudianteDAO = new EstudianteDAO();
        this.empresaDAO = new EmpresaDAO();
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
            String filtroEstado = request.getParameter("estado");
            String busqueda = request.getParameter("busqueda");
            
            // Obtener todas las prácticas
            List<Practica> todasPracticas = practicaDAO.obtenerTodos();
            
            // Aplicar filtros
            List<Practica> practicasFiltradas = todasPracticas;
            
            if (filtroEstado != null && !filtroEstado.isEmpty() && !"todas".equals(filtroEstado)) {
                practicasFiltradas = practicasFiltradas.stream()
                    .filter(p -> filtroEstado.equals(p.getEstado()))
                    .collect(Collectors.toList());
            }
            
            if (busqueda != null && !busqueda.trim().isEmpty()) {
                String busquedaLower = busqueda.toLowerCase().trim();
                practicasFiltradas = practicasFiltradas.stream()
                    .filter(p -> {
                        // Aquí podrías buscar por estudiante o empresa
                        // Por ahora filtro por ID (podrías mejorarlo con JOINs)
                        return String.valueOf(p.getId()).contains(busquedaLower) ||
                               String.valueOf(p.getPostulacionId()).contains(busquedaLower);
                    })
                    .collect(Collectors.toList());
            }
            
            // Calcular estadísticas
            long totalPracticas = todasPracticas.size();
            long practicasEnCurso = todasPracticas.stream().filter(p -> "en_curso".equals(p.getEstado())).count();
            long practicasCompletadas = todasPracticas.stream().filter(p -> "completada".equals(p.getEstado())).count();
            long practicasCanceladas = todasPracticas.stream().filter(p -> "cancelada".equals(p.getEstado())).count();
            
            // Promedio de horas completadas
            double promedioHoras = todasPracticas.stream()
                .filter(p -> p.getHorasCompletadas() > 0)
                .mapToInt(Practica::getHorasCompletadas)
                .average()
                .orElse(0.0);
            
            // Promedio de calificaciones
            double promedioCalificaciones = todasPracticas.stream()
                .filter(p -> p.getCalificacionFinal() > 0)
                .mapToDouble(Practica::getCalificacionFinal)
                .average()
                .orElse(0.0);
            
            // Establecer atributos para la vista
            request.setAttribute("practicas", practicasFiltradas);
            request.setAttribute("totalPracticas", totalPracticas);
            request.setAttribute("practicasEnCurso", practicasEnCurso);
            request.setAttribute("practicasCompletadas", practicasCompletadas);
            request.setAttribute("practicasCanceladas", practicasCanceladas);
            request.setAttribute("promedioHoras", String.format("%.0f", promedioHoras));
            request.setAttribute("promedioCalificaciones", String.format("%.1f", promedioCalificaciones));
            request.setAttribute("filtroEstado", filtroEstado);
            request.setAttribute("busqueda", busqueda);
            
            // Reenviar a la vista
            request.getRequestDispatcher("/vistas/admin/practicas.jsp").forward(request, response);
            
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
                case "cambiar_estado":
                    cambiarEstadoPractica(request, response);
                    break;
                case "asignar_supervisor":
                    asignarSupervisor(request, response);
                    break;
                case "actualizar_horas":
                    actualizarHoras(request, response);
                    break;
                case "finalizar":
                    finalizarPractica(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción no válida");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error interno del servidor");
        }
    }
    
    private void cambiarEstadoPractica(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        int idPractica = Integer.parseInt(request.getParameter("idPractica"));
        String nuevoEstado = request.getParameter("estado");
        
        Practica practica = practicaDAO.obtenerPorId(idPractica);
        if (practica == null) {
            request.setAttribute("error", "Práctica no encontrada");
            doGet(request, response);
            return;
        }
        
        practica.setEstado(nuevoEstado);
        practicaDAO.actualizar(practica);
        
        response.sendRedirect(request.getContextPath() + "/admin/practicas?mensaje=Estado de la práctica actualizado");
    }
    
    private void asignarSupervisor(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        int idPractica = Integer.parseInt(request.getParameter("idPractica"));
        int supervisorId = Integer.parseInt(request.getParameter("supervisorId"));
        
        Practica practica = practicaDAO.obtenerPorId(idPractica);
        if (practica == null) {
            request.setAttribute("error", "Práctica no encontrada");
            doGet(request, response);
            return;
        }
        
        practica.setSupervisorId(supervisorId);
        practicaDAO.actualizar(practica);
        
        response.sendRedirect(request.getContextPath() + "/admin/practicas?mensaje=Supervisor asignado correctamente");
    }
    
    private void actualizarHoras(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        int idPractica = Integer.parseInt(request.getParameter("idPractica"));
        int horasCompletadas = Integer.parseInt(request.getParameter("horasCompletadas"));
        
        Practica practica = practicaDAO.obtenerPorId(idPractica);
        if (practica == null) {
            request.setAttribute("error", "Práctica no encontrada");
            doGet(request, response);
            return;
        }
        
        practica.setHorasCompletadas(horasCompletadas);
        
        // Si completó todas las horas, cambiar estado automáticamente
        if (horasCompletadas >= practica.getHorasRequeridas()) {
            practica.setEstado("completada");
        }
        
        practicaDAO.actualizar(practica);
        
        response.sendRedirect(request.getContextPath() + "/admin/practicas?mensaje=Horas actualizadas correctamente");
    }
    
    private void finalizarPractica(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        int idPractica = Integer.parseInt(request.getParameter("idPractica"));
        String calificacionStr = request.getParameter("calificacion");
        
        Practica practica = practicaDAO.obtenerPorId(idPractica);
        if (practica == null) {
            request.setAttribute("error", "Práctica no encontrada");
            doGet(request, response);
            return;
        }
        
        // Actualizar calificación y estado
        if (calificacionStr != null && !calificacionStr.trim().isEmpty()) {
            try {
                double calificacion = Double.parseDouble(calificacionStr);
                practica.setCalificacionFinal(calificacion);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Calificación debe ser un número válido");
                doGet(request, response);
                return;
            }
        }
        
        practica.setEstado("completada");
        practicaDAO.actualizar(practica);
        
        response.sendRedirect(request.getContextPath() + "/admin/practicas?mensaje=Práctica finalizada correctamente");
    }
}
