/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import dao.OfertaPracticaDAO;
import dao.PostulacionDAO;
import modelo.Usuario;
import modelo.Estudiante;
import modelo.OfertaPractica;
import modelo.Postulacion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.sql.Timestamp;

@WebServlet("/estudiante/ofertas")
public class OfertasEstudianteServlet extends HttpServlet {
    
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
        
        // Verificar que sea un estudiante
        if (!"estudiante".equals(usuario.getTipoUsuario().toLowerCase())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        try {
            if ("postular".equals(action)) {
                postularseOferta(request, response, session);
            } else if ("detalle".equals(action)) {
                verDetalleOferta(request, response, session);
            } else if ("buscar".equals(action)) {
                buscarOfertas(request, response, session);
            } else {
                listarOfertas(request, response, session);
            }
        } catch (Exception e) {
            System.err.println("💥 Error en OfertasEstudianteServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error al procesar la solicitud: " + e.getMessage());
            request.getRequestDispatcher("/vistas/estudiante/ofertas.jsp").forward(request, response);
        }
    }
    
    private void listarOfertas(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        
        try {
            System.out.println("📋 Listando ofertas disponibles...");
            
            Estudiante estudiante = (Estudiante) session.getAttribute("estudiante");
            
            // Obtener todas las ofertas activas - ajustado según tus métodos disponibles
            List<OfertaPractica> ofertas = null;
            
            try {
                // Intentar primero sin parámetros
                ofertas = ofertaDAO.obtenerTodos();
            } catch (Exception e) {
                try {
                    // Si falla, intentar con parámetros por defecto
                    ofertas = ofertaDAO.obtenerOfertasActivas("", "");
                } catch (Exception e2) {
                    System.err.println("Error obteniendo ofertas: " + e2.getMessage());
                    ofertas = new java.util.ArrayList<>();
                }
            }
            
            // Verificar qué ofertas ya tienen postulación del estudiante
            if (estudiante != null && ofertas != null) {
                for (OfertaPractica oferta : ofertas) {
                    try {
                        // Verificar si existe postulación - ajustar según tu método
                        boolean yaPostulado = verificarPostulacion(estudiante.getIdEstudiante(), oferta.getIdOferta());
                        // Guardar esta información en algún atributo o mapa
                    } catch (Exception e) {
                        System.err.println("Error verificando postulación: " + e.getMessage());
                    }
                }
            }
            
            request.setAttribute("ofertas", ofertas);
            request.setAttribute("totalOfertas", ofertas != null ? ofertas.size() : 0);
            request.setAttribute("estudiante", estudiante);
            
            System.out.println("✅ " + (ofertas != null ? ofertas.size() : 0) + " ofertas cargadas correctamente");
            
        } catch (Exception e) {
            System.err.println("💥 Error al listar ofertas: " + e.getMessage());
            throw new ServletException("Error al obtener ofertas", e);
        }
        
        request.getRequestDispatcher("/vistas/estudiante/ofertas.jsp").forward(request, response);
    }
    
    private void buscarOfertas(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        
        String termino = request.getParameter("termino");
        String area = request.getParameter("area");
        String modalidad = request.getParameter("modalidad");
        
        try {
            System.out.println("🔍 Buscando ofertas con término: " + termino);
            
            Estudiante estudiante = (Estudiante) session.getAttribute("estudiante");
            List<OfertaPractica> ofertas = null;
            
            try {
                // Ajustar según los métodos disponibles en tu DAO
                if (termino != null && !termino.trim().isEmpty()) {
                    // Si tienes método de búsqueda, úsalo
                    ofertas = ofertaDAO.obtenerTodos(); // Temporal, filtrar después
                } else {
                    ofertas = ofertaDAO.obtenerTodos();
                }
            } catch (Exception e) {
                System.err.println("Error en búsqueda: " + e.getMessage());
                ofertas = new java.util.ArrayList<>();
            }
            
            request.setAttribute("ofertas", ofertas);
            request.setAttribute("totalOfertas", ofertas != null ? ofertas.size() : 0);
            request.setAttribute("estudiante", estudiante);
            request.setAttribute("terminoBusqueda", termino);
            request.setAttribute("areaSeleccionada", area);
            request.setAttribute("modalidadSeleccionada", modalidad);
            
            System.out.println("✅ Búsqueda completada: " + (ofertas != null ? ofertas.size() : 0) + " resultados");
            
        } catch (Exception e) {
            System.err.println("💥 Error en búsqueda: " + e.getMessage());
            throw new ServletException("Error en búsqueda de ofertas", e);
        }
        
        request.getRequestDispatcher("/vistas/estudiante/ofertas.jsp").forward(request, response);
    }
    
    private void postularseOferta(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        
        try {
            int idOferta = Integer.parseInt(request.getParameter("idOferta"));
            Estudiante estudiante = (Estudiante) session.getAttribute("estudiante");
            
            if (estudiante == null) {
                request.setAttribute("error", "Error: No se encontraron datos del estudiante.");
                listarOfertas(request, response, session);
                return;
            }
            
            System.out.println("📝 Procesando postulación de estudiante " + estudiante.getIdEstudiante() + " a oferta " + idOferta);
            
            // Verificar que no se haya postulado antes
            if (verificarPostulacion(estudiante.getIdEstudiante(), idOferta)) {
                request.setAttribute("error", "Ya te has postulado a esta oferta anteriormente.");
                listarOfertas(request, response, session);
                return;
            }
            
            // Crear nueva postulación - ajustar según tu modelo
            Postulacion postulacion = new Postulacion();
            
            // Usar los setters correctos según tu modelo
            try {
                // Ajustar estos métodos según tu clase Postulacion
                if (hasMethod(postulacion, "setEstudianteId")) {
                    postulacion.getClass().getMethod("setEstudianteId", int.class).invoke(postulacion, estudiante.getIdEstudiante());
                } else if (hasMethod(postulacion, "setIdEstudiante")) {
                    postulacion.getClass().getMethod("setIdEstudiante", int.class).invoke(postulacion, estudiante.getIdEstudiante());
                }
                
                if (hasMethod(postulacion, "setOfertaId")) {
                    postulacion.getClass().getMethod("setOfertaId", int.class).invoke(postulacion, idOferta);
                } else if (hasMethod(postulacion, "setIdOferta")) {
                    postulacion.getClass().getMethod("setIdOferta", int.class).invoke(postulacion, idOferta);
                }
                
                // Establecer estado
                postulacion.setEstado("PENDIENTE");
                
                // Establecer fecha - usar Timestamp en lugar de Date
                if (hasMethod(postulacion, "setFechaPostulacion")) {
                    postulacion.getClass().getMethod("setFechaPostulacion", Timestamp.class)
                        .invoke(postulacion, new Timestamp(System.currentTimeMillis()));
                }
                
            } catch (Exception e) {
                System.err.println("Error configurando postulación: " + e.getMessage());
                request.setAttribute("error", "Error al configurar la postulación.");
                listarOfertas(request, response, session);
                return;
            }
            
            // Guardar la postulación - ajustar según tu DAO
            boolean exito = false;
            try {
                if (hasMethod(postulacionDAO, "crear")) {
                    exito = (Boolean) postulacionDAO.getClass().getMethod("crear", Postulacion.class).invoke(postulacionDAO, postulacion);
                } else if (hasMethod(postulacionDAO, "insertar")) {
                    exito = (Boolean) postulacionDAO.getClass().getMethod("insertar", Postulacion.class).invoke(postulacionDAO, postulacion);
                } else if (hasMethod(postulacionDAO, "guardar")) {
                    exito = (Boolean) postulacionDAO.getClass().getMethod("guardar", Postulacion.class).invoke(postulacionDAO, postulacion);
                }
            } catch (Exception e) {
                System.err.println("Error guardando postulación: " + e.getMessage());
                exito = false;
            }
            
            if (exito) {
                request.setAttribute("mensaje", "¡Postulación enviada exitosamente! La empresa revisará tu solicitud pronto.");
                System.out.println("✅ Postulación creada exitosamente");
            } else {
                request.setAttribute("error", "Error al enviar la postulación. Por favor, inténtalo nuevamente.");
                System.err.println("❌ Error al crear postulación en BD");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de oferta inválido.");
            System.err.println("❌ ID de oferta inválido: " + request.getParameter("idOferta"));
        } catch (Exception e) {
            request.setAttribute("error", "Error al procesar postulación: " + e.getMessage());
            System.err.println("💥 Error al postularse: " + e.getMessage());
            e.printStackTrace();
        }
        
        listarOfertas(request, response, session);
    }
    
    private void verDetalleOferta(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        
        try {
            int idOferta = Integer.parseInt(request.getParameter("idOferta"));
            Estudiante estudiante = (Estudiante) session.getAttribute("estudiante");
            
            System.out.println("👁️ Viendo detalle de oferta: " + idOferta);
            
            OfertaPractica oferta = ofertaDAO.obtenerPorId(idOferta);
            
            if (oferta != null) {
                // Verificar si ya se postuló
                boolean yaPostulado = false;
                if (estudiante != null) {
                    yaPostulado = verificarPostulacion(estudiante.getIdEstudiante(), idOferta);
                }
                
                request.setAttribute("oferta", oferta);
                request.setAttribute("yaPostulado", yaPostulado);
                request.setAttribute("estudiante", estudiante);
                
                request.getRequestDispatcher("/vistas/estudiante/detalle-oferta.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Oferta no encontrada.");
                listarOfertas(request, response, session);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de oferta inválido.");
            listarOfertas(request, response, session);
        } catch (Exception e) {
            request.setAttribute("error", "Error al obtener detalle de la oferta: " + e.getMessage());
            listarOfertas(request, response, session);
        }
    }
    
    // Método auxiliar para verificar postulaciones
    private boolean verificarPostulacion(int idEstudiante, int idOferta) {
        try {
            // Ajustar según los métodos disponibles en tu PostulacionDAO
            List<Postulacion> postulaciones = postulacionDAO.obtenerTodos();
            for (Postulacion p : postulaciones) {
                // Ajustar según los getters de tu modelo
                if (getEstudianteId(p) == idEstudiante && getOfertaId(p) == idOferta) {
                    return true;
                }
            }
            return false;
        } catch (Exception e) {
            System.err.println("Error verificando postulación: " + e.getMessage());
            return false;
        }
    }
    
    // Métodos auxiliares para obtener IDs según tu modelo
    private int getEstudianteId(Postulacion p) {
        try {
            if (hasMethod(p, "getIdEstudiante")) {
                return (Integer) p.getClass().getMethod("getIdEstudiante").invoke(p);
            } else if (hasMethod(p, "getEstudianteId")) {
                return (Integer) p.getClass().getMethod("getEstudianteId").invoke(p);
            }
        } catch (Exception e) {
            System.err.println("Error obteniendo ID estudiante: " + e.getMessage());
        }
        return -1;
    }
    
    private int getOfertaId(Postulacion p) {
        try {
            if (hasMethod(p, "getIdOferta")) {
                return (Integer) p.getClass().getMethod("getIdOferta").invoke(p);
            } else if (hasMethod(p, "getOfertaId")) {
                return (Integer) p.getClass().getMethod("getOfertaId").invoke(p);
            }
        } catch (Exception e) {
            System.err.println("Error obteniendo ID oferta: " + e.getMessage());
        }
        return -1;
    }
    
    // Método auxiliar para verificar si existe un método
    private boolean hasMethod(Object obj, String methodName) {
        try {
            obj.getClass().getMethod(methodName);
            return true;
        } catch (NoSuchMethodException e) {
            return false;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}