/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import dao.OfertaPracticaDAO;
import dao.EmpresaDAO;
import modelo.OfertaPractica;
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

@WebServlet("/admin/ofertas")
public class OfertasAdminServlet extends HttpServlet {
    
    private OfertaPracticaDAO ofertaDAO;
    private EmpresaDAO empresaDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        this.ofertaDAO = new OfertaPracticaDAO();
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
            String filtroModalidad = request.getParameter("modalidad");
            String filtroArea = request.getParameter("area");
            String busqueda = request.getParameter("busqueda");
            
            // Obtener todas las ofertas
            List<OfertaPractica> todasOfertas = ofertaDAO.obtenerTodos();
            
            // Aplicar filtros
            List<OfertaPractica> ofertasFiltradas = todasOfertas;
            
            if (filtroEstado != null && !filtroEstado.isEmpty() && !"todas".equals(filtroEstado)) {
                ofertasFiltradas = ofertasFiltradas.stream()
                    .filter(o -> filtroEstado.equals(o.getEstado()))
                    .collect(Collectors.toList());
            }
            
            if (filtroModalidad != null && !filtroModalidad.isEmpty() && !"todas".equals(filtroModalidad)) {
                ofertasFiltradas = ofertasFiltradas.stream()
                    .filter(o -> filtroModalidad.equals(o.getModalidad()))
                    .collect(Collectors.toList());
            }
            
            if (filtroArea != null && !filtroArea.isEmpty() && !"todas".equals(filtroArea)) {
                ofertasFiltradas = ofertasFiltradas.stream()
                    .filter(o -> o.getArea() != null && o.getArea().contains(filtroArea))
                    .collect(Collectors.toList());
            }
            
            if (busqueda != null && !busqueda.trim().isEmpty()) {
                String busquedaLower = busqueda.toLowerCase().trim();
                ofertasFiltradas = ofertasFiltradas.stream()
                    .filter(o -> o.getTitulo().toLowerCase().contains(busquedaLower) ||
                               o.getDescripcion().toLowerCase().contains(busquedaLower))
                    .collect(Collectors.toList());
            }
            
            // Calcular estadísticas
            long totalOfertas = todasOfertas.size();
            long ofertasActivas = todasOfertas.stream().filter(o -> "activa".equals(o.getEstado())).count();
            long ofertasVencidas = todasOfertas.stream().filter(o -> "vencida".equals(o.getEstado())).count();
            long ofertasSuspendidas = todasOfertas.stream().filter(o -> "suspendida".equals(o.getEstado())).count();
            
            // Contar por modalidad
            long presencial = todasOfertas.stream().filter(o -> "Presencial".equals(o.getModalidad())).count();
            long remoto = todasOfertas.stream().filter(o -> "Remoto".equals(o.getModalidad())).count();
            long hibrido = todasOfertas.stream().filter(o -> "Híbrido".equals(o.getModalidad())).count();
            
            // Promedio de duración en meses
            double promedioDuracion = todasOfertas.stream()
                .filter(o -> o.getDuracionMeses() > 0)
                .mapToInt(OfertaPractica::getDuracionMeses)
                .average()
                .orElse(0.0);
            
            // Establecer atributos para la vista
            request.setAttribute("ofertas", ofertasFiltradas);
            request.setAttribute("totalOfertas", totalOfertas);
            request.setAttribute("ofertasActivas", ofertasActivas);
            request.setAttribute("ofertasVencidas", ofertasVencidas);
            request.setAttribute("ofertasSuspendidas", ofertasSuspendidas);
            request.setAttribute("presencial", presencial);
            request.setAttribute("remoto", remoto);
            request.setAttribute("hibrido", hibrido);
            request.setAttribute("promedioDuracion", String.format("%.1f", promedioDuracion));
            request.setAttribute("filtroEstado", filtroEstado);
            request.setAttribute("filtroModalidad", filtroModalidad);
            request.setAttribute("filtroArea", filtroArea);
            request.setAttribute("busqueda", busqueda);
            
            // Reenviar a la vista
            request.getRequestDispatcher("/vistas/admin/ofertas.jsp").forward(request, response);
            
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
                    cambiarEstadoOferta(request, response);
                    break;
                case "editar":
                    editarOferta(request, response);
                    break;
                case "eliminar":
                    eliminarOferta(request, response);
                    break;
                case "suspender":
                    suspenderOferta(request, response);
                    break;
                case "activar":
                    activarOferta(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción no válida");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error interno del servidor");
        }
    }
    
    private void cambiarEstadoOferta(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        int idOferta = Integer.parseInt(request.getParameter("idOferta"));
        String nuevoEstado = request.getParameter("estado");
        
        OfertaPractica oferta = ofertaDAO.obtenerPorId(idOferta);
        if (oferta == null) {
            request.setAttribute("error", "Oferta no encontrada");
            doGet(request, response);
            return;
        }
        
        oferta.setEstado(nuevoEstado);
        ofertaDAO.actualizar(oferta);
        
        response.sendRedirect(request.getContextPath() + "/admin/ofertas?mensaje=Estado de la oferta actualizado");
    }
    
    private void editarOferta(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        int idOferta = Integer.parseInt(request.getParameter("idOferta"));
        String titulo = request.getParameter("titulo");
        String descripcion = request.getParameter("descripcion");
        String requisitos = request.getParameter("requisitos");
        String modalidad = request.getParameter("modalidad");
        String areaPractica = request.getParameter("areaPractica");
        String duracionStr = request.getParameter("duracion");
        
        OfertaPractica oferta = ofertaDAO.obtenerPorId(idOferta);
        if (oferta == null) {
            request.setAttribute("error", "Oferta no encontrada");
            doGet(request, response);
            return;
        }
        
        // Actualizar datos
        oferta.setTitulo(titulo.trim());
        oferta.setDescripcion(descripcion.trim());
        oferta.setRequisitos(requisitos != null ? requisitos.trim() : null);
        oferta.setModalidad(modalidad);
        oferta.setArea(areaPractica != null ? areaPractica.trim() : null);
        
        // Convertir duración
        if (duracionStr != null && !duracionStr.trim().isEmpty()) {
            try {
                int duracion = Integer.parseInt(duracionStr);
                oferta.setDuracionMeses(duracion);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Duración debe ser un número válido");
                doGet(request, response);
                return;
            }
        }
        
        ofertaDAO.actualizar(oferta);
        
        response.sendRedirect(request.getContextPath() + "/admin/ofertas?mensaje=Oferta actualizada exitosamente");
    }
    
    private void eliminarOferta(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        int idOferta = Integer.parseInt(request.getParameter("idOferta"));
        
        OfertaPractica oferta = ofertaDAO.obtenerPorId(idOferta);
        if (oferta == null) {
            request.setAttribute("error", "Oferta no encontrada");
            doGet(request, response);
            return;
        }
        
        // Eliminar oferta (esto también debería eliminar postulaciones asociadas)
        ofertaDAO.eliminar(idOferta);
        
        response.sendRedirect(request.getContextPath() + "/admin/ofertas?mensaje=Oferta eliminada exitosamente");
    }
    
    private void suspenderOferta(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        int idOferta = Integer.parseInt(request.getParameter("idOferta"));
        String motivo = request.getParameter("motivo");
        
        OfertaPractica oferta = ofertaDAO.obtenerPorId(idOferta);
        if (oferta == null) {
            request.setAttribute("error", "Oferta no encontrada");
            doGet(request, response);
            return;
        }
        
        oferta.setEstado("suspendida");
        // Aquí podrías agregar el motivo si tu modelo lo tiene
        ofertaDAO.actualizar(oferta);
        
        response.sendRedirect(request.getContextPath() + "/admin/ofertas?mensaje=Oferta suspendida correctamente");
    }
    
    private void activarOferta(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        int idOferta = Integer.parseInt(request.getParameter("idOferta"));
        
        OfertaPractica oferta = ofertaDAO.obtenerPorId(idOferta);
        if (oferta == null) {
            request.setAttribute("error", "Oferta no encontrada");
            doGet(request, response);
            return;
        }
        
        oferta.setEstado("activa");
        ofertaDAO.actualizar(oferta);
        
        response.sendRedirect(request.getContextPath() + "/admin/ofertas?mensaje=Oferta activada correctamente");
    }
}