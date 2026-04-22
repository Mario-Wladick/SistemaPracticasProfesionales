/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import dao.PostulacionDAO;
import modelo.Usuario;
import modelo.Estudiante;
import modelo.Postulacion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/estudiante/postulaciones")
public class PostulacionesEstudianteServlet extends HttpServlet {
    
    private PostulacionDAO postulacionDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
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
        
        // Verificar que sea un estudiante
        if (!"estudiante".equals(usuario.getTipoUsuario().toLowerCase())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        try {
            if ("cancelar".equals(action)) {
                cancelarPostulacion(request, response, session);
            } else if ("filtrar".equals(action)) {
                filtrarPostulaciones(request, response, session);
            } else if ("detalle".equals(action)) {
                verDetallePostulacion(request, response, session);
            } else {
                listarPostulaciones(request, response, session);
            }
        } catch (Exception e) {
            System.err.println("💥 Error en PostulacionesEstudianteServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error al procesar la solicitud: " + e.getMessage());
            request.getRequestDispatcher("/vistas/estudiante/postulaciones.jsp").forward(request, response);
        }
    }
    
    private void listarPostulaciones(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        
        try {
            Estudiante estudiante = (Estudiante) session.getAttribute("estudiante");
            
            if (estudiante == null) {
                request.setAttribute("error", "No se encontraron datos del estudiante.");
                request.getRequestDispatcher("/vistas/estudiante/postulaciones.jsp").forward(request, response);
                return;
            }
            
            System.out.println("📋 Listando postulaciones para estudiante: " + estudiante.getIdEstudiante());
            
            // Obtener todas las postulaciones y filtrar por estudiante
            List<Postulacion> todasPostulaciones = postulacionDAO.obtenerTodos();
            List<Postulacion> postulaciones = todasPostulaciones.stream()
                .filter(p -> p.getEstudianteId() == estudiante.getIdEstudiante())
                .collect(Collectors.toList());
            
            // Contar por estados
            int pendientes = 0, aceptadas = 0, rechazadas = 0;
            
            for (Postulacion postulacion : postulaciones) {
                String estado = postulacion.getEstado().toLowerCase();
                switch (estado) {
                    case "pendiente":
                        pendientes++;
                        break;
                    case "aceptada":
                    case "aprobada":
                        aceptadas++;
                        break;
                    case "rechazada":
                    case "denegada":
                        rechazadas++;
                        break;
                }
            }
            
            // Establecer atributos para la vista
            request.setAttribute("postulaciones", postulaciones);
            request.setAttribute("totalPostulaciones", postulaciones.size());
            request.setAttribute("pendientes", pendientes);
            request.setAttribute("aceptadas", aceptadas);
            request.setAttribute("rechazadas", rechazadas);
            request.setAttribute("estudiante", estudiante);
            
            System.out.println("✅ " + postulaciones.size() + " postulaciones cargadas - P:" + pendientes + " A:" + aceptadas + " R:" + rechazadas);
            
        } catch (Exception e) {
            System.err.println("💥 Error al listar postulaciones: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar las postulaciones: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/vistas/estudiante/postulaciones.jsp").forward(request, response);
    }
    
    private void filtrarPostulaciones(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        
        String estado = request.getParameter("estado");
        
        try {
            Estudiante estudiante = (Estudiante) session.getAttribute("estudiante");
            
            if (estudiante == null) {
                request.setAttribute("error", "No se encontraron datos del estudiante.");
                request.getRequestDispatcher("/vistas/estudiante/postulaciones.jsp").forward(request, response);
                return;
            }
            
            System.out.println("🔍 Filtrando postulaciones por estado: " + estado);
            
            // Obtener todas las postulaciones del estudiante
            List<Postulacion> todasPostulaciones = postulacionDAO.obtenerTodos();
            List<Postulacion> postulacionesEstudiante = todasPostulaciones.stream()
                .filter(p -> p.getEstudianteId() == estudiante.getIdEstudiante())
                .collect(Collectors.toList());
            
            // Filtrar por estado si se especifica
            List<Postulacion> postulacionesFiltradas;
            if (estado != null && !estado.isEmpty() && !"todos".equalsIgnoreCase(estado)) {
                postulacionesFiltradas = postulacionesEstudiante.stream()
                    .filter(p -> estado.equalsIgnoreCase(p.getEstado()))
                    .collect(Collectors.toList());
            } else {
                postulacionesFiltradas = postulacionesEstudiante;
            }
            
            // Contar por estados (del total, no solo filtradas)
            int pendientes = 0, aceptadas = 0, rechazadas = 0;
            
            for (Postulacion postulacion : postulacionesEstudiante) {
                String estadoPost = postulacion.getEstado().toLowerCase();
                switch (estadoPost) {
                    case "pendiente":
                        pendientes++;
                        break;
                    case "aceptada":
                    case "aprobada":
                        aceptadas++;
                        break;
                    case "rechazada":
                    case "denegada":
                        rechazadas++;
                        break;
                }
            }
            
            // Establecer atributos para la vista
            request.setAttribute("postulaciones", postulacionesFiltradas);
            request.setAttribute("totalPostulaciones", postulacionesEstudiante.size());
            request.setAttribute("postulacionesFiltradas", postulacionesFiltradas.size());
            request.setAttribute("pendientes", pendientes);
            request.setAttribute("aceptadas", aceptadas);
            request.setAttribute("rechazadas", rechazadas);
            request.setAttribute("estadoFiltro", estado);
            request.setAttribute("estudiante", estudiante);
            
            System.out.println("✅ Filtro aplicado: " + postulacionesFiltradas.size() + " de " + postulacionesEstudiante.size() + " postulaciones");
            
        } catch (Exception e) {
            System.err.println("💥 Error al filtrar postulaciones: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error al filtrar postulaciones: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/vistas/estudiante/postulaciones.jsp").forward(request, response);
    }
    
    private void cancelarPostulacion(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        
        try {
            int idPostulacion = Integer.parseInt(request.getParameter("idPostulacion"));
            Estudiante estudiante = (Estudiante) session.getAttribute("estudiante");
            
            if (estudiante == null) {
                request.setAttribute("error", "No se encontraron datos del estudiante.");
                listarPostulaciones(request, response, session);
                return;
            }
            
            System.out.println("❌ Cancelando postulación: " + idPostulacion);
            
            // Verificar que la postulación pertenece al estudiante
            Postulacion postulacion = postulacionDAO.obtenerPorId(idPostulacion);
            
            if (postulacion == null) {
                request.setAttribute("error", "Postulación no encontrada.");
                listarPostulaciones(request, response, session);
                return;
            }
            
            if (postulacion.getEstudianteId() != estudiante.getIdEstudiante()) {
                request.setAttribute("error", "No tienes permisos para cancelar esta postulación.");
                listarPostulaciones(request, response, session);
                return;
            }
            
            // Solo se pueden cancelar postulaciones pendientes
            if (!"pendiente".equalsIgnoreCase(postulacion.getEstado())) {
                request.setAttribute("error", "Solo puedes cancelar postulaciones que estén pendientes.");
                listarPostulaciones(request, response, session);
                return;
            }
            
            // Actualizar estado a cancelada
            postulacion.setEstado("cancelada");
            postulacionDAO.actualizar(postulacion);
            
            request.setAttribute("mensaje", "Postulación cancelada exitosamente.");
            System.out.println("✅ Postulación cancelada correctamente");
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de postulación inválido.");
            System.err.println("❌ ID de postulación inválido: " + request.getParameter("idPostulacion"));
        } catch (Exception e) {
            request.setAttribute("error", "Error al cancelar postulación: " + e.getMessage());
            System.err.println("💥 Error al cancelar postulación: " + e.getMessage());
            e.printStackTrace();
        }
        
        listarPostulaciones(request, response, session);
    }
    
    private void verDetallePostulacion(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        
        try {
            int idPostulacion = Integer.parseInt(request.getParameter("idPostulacion"));
            Estudiante estudiante = (Estudiante) session.getAttribute("estudiante");
            
            System.out.println("👁️ Viendo detalle de postulación: " + idPostulacion);
            
            Postulacion postulacion = postulacionDAO.obtenerPorId(idPostulacion);
            
            if (postulacion != null && postulacion.getEstudianteId() == estudiante.getIdEstudiante()) {
                request.setAttribute("postulacion", postulacion);
                request.setAttribute("estudiante", estudiante);
                request.getRequestDispatcher("/vistas/estudiante/detalle-postulacion.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Postulación no encontrada o no tienes permisos para verla.");
                listarPostulaciones(request, response, session);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de postulación inválido.");
            listarPostulaciones(request, response, session);
        } catch (Exception e) {
            request.setAttribute("error", "Error al obtener detalle de la postulación: " + e.getMessage());
            listarPostulaciones(request, response, session);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}