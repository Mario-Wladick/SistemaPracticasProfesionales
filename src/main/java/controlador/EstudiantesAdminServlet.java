/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import dao.EstudianteDAO;
import dao.UsuarioDAO;
import modelo.Estudiante;
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

@WebServlet("/admin/estudiantes")
public class EstudiantesAdminServlet extends HttpServlet {
    
    private EstudianteDAO estudianteDAO;
    private UsuarioDAO usuarioDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        this.estudianteDAO = new EstudianteDAO();
        this.usuarioDAO = new UsuarioDAO();
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
            String filtroEspecialidad = request.getParameter("especialidad");
            String filtroCiclo = request.getParameter("ciclo");
            String busqueda = request.getParameter("busqueda");
            
            // Obtener todos los estudiantes
            List<Estudiante> todosEstudiantes = estudianteDAO.obtenerTodos();
            
            // Aplicar filtros
            List<Estudiante> estudiantesFiltrados = todosEstudiantes;
            
            if (filtroEspecialidad != null && !filtroEspecialidad.isEmpty() && !"todas".equals(filtroEspecialidad)) {
                estudiantesFiltrados = estudiantesFiltrados.stream()
                    .filter(e -> filtroEspecialidad.equals(e.getEspecialidad()))
                    .collect(Collectors.toList());
            }
            
            if (filtroCiclo != null && !filtroCiclo.isEmpty() && !"todos".equals(filtroCiclo)) {
                int cicloFiltro = Integer.parseInt(filtroCiclo);
                estudiantesFiltrados = estudiantesFiltrados.stream()
                    .filter(e -> e.getCiclo() == cicloFiltro)
                    .collect(Collectors.toList());
            }
            
            if (busqueda != null && !busqueda.trim().isEmpty()) {
                String busquedaLower = busqueda.toLowerCase().trim();
                estudiantesFiltrados = estudiantesFiltrados.stream()
                    .filter(e -> e.getNombres().toLowerCase().contains(busquedaLower) ||
                               e.getApellidos().toLowerCase().contains(busquedaLower) ||
                               (e.getCodigoUniversitario() != null && e.getCodigoUniversitario().toLowerCase().contains(busquedaLower)) ||
                               (e.getEmail() != null && e.getEmail().toLowerCase().contains(busquedaLower)))
                    .collect(Collectors.toList());
            }
            
            // Calcular estadísticas
            long totalEstudiantes = todosEstudiantes.size();
            long estudiantesActivos = todosEstudiantes.stream().filter(e -> e.getCiclo() >= 8).count();
            
            // Contar por especialidades
            long sistemas = todosEstudiantes.stream().filter(e -> "Ingeniería de Sistemas".equals(e.getEspecialidad())).count();
            long industrial = todosEstudiantes.stream().filter(e -> "Ingeniería Industrial".equals(e.getEspecialidad())).count();
            long civil = todosEstudiantes.stream().filter(e -> "Ingeniería Civil".equals(e.getEspecialidad())).count();
            long administracion = todosEstudiantes.stream().filter(e -> "Administración".equals(e.getEspecialidad())).count();
            
            // Promedio general
            double promedioGeneral = todosEstudiantes.stream()
                .filter(e -> e.getPromedioPonderado() > 0)
                .mapToDouble(Estudiante::getPromedioPonderado)
                .average()
                .orElse(0.0);
            
            // Establecer atributos para la vista
            request.setAttribute("estudiantes", estudiantesFiltrados);
            request.setAttribute("totalEstudiantes", totalEstudiantes);
            request.setAttribute("estudiantesActivos", estudiantesActivos);
            request.setAttribute("sistemas", sistemas);
            request.setAttribute("industrial", industrial);
            request.setAttribute("civil", civil);
            request.setAttribute("administracion", administracion);
            request.setAttribute("promedioGeneral", String.format("%.2f", promedioGeneral));
            request.setAttribute("filtroEspecialidad", filtroEspecialidad);
            request.setAttribute("filtroCiclo", filtroCiclo);
            request.setAttribute("busqueda", busqueda);
            
            // Reenviar a la vista
            request.getRequestDispatcher("/vistas/admin/estudiantes.jsp").forward(request, response);
            
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
                case "editar":
                    editarEstudiante(request, response);
                    break;
                case "eliminar":
                    eliminarEstudiante(request, response);
                    break;
                case "actualizar_estado":
                    actualizarEstadoEstudiante(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción no válida");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error interno del servidor");
        }
    }
    
    private void editarEstudiante(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        int idEstudiante = Integer.parseInt(request.getParameter("idEstudiante"));
        String nombres = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String email = request.getParameter("email");
        String telefono = request.getParameter("telefono");
        String especialidad = request.getParameter("especialidad");
        String cicloStr = request.getParameter("ciclo");
        String promedioStr = request.getParameter("promedio");
        String dni = request.getParameter("dni");
        String codigoUniversitario = request.getParameter("codigoUniversitario");
        
        Estudiante estudiante = estudianteDAO.obtenerPorId(idEstudiante);
        if (estudiante == null) {
            request.setAttribute("error", "Estudiante no encontrado");
            doGet(request, response);
            return;
        }
        
        // Actualizar datos
        estudiante.setNombres(nombres.trim());
        estudiante.setApellidos(apellidos.trim());
        estudiante.setEmail(email.trim());
        estudiante.setTelefono(telefono != null ? telefono.trim() : null);
        estudiante.setEspecialidad(especialidad);
        estudiante.setDni(dni != null ? dni.trim() : null);
        estudiante.setCodigoUniversitario(codigoUniversitario != null ? codigoUniversitario.trim() : null);
        
        // Convertir ciclo
        if (cicloStr != null && !cicloStr.trim().isEmpty()) {
            try {
                int ciclo = Integer.parseInt(cicloStr);
                estudiante.setCiclo(ciclo);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Ciclo debe ser un número válido");
                doGet(request, response);
                return;
            }
        }
        
        // Convertir promedio
        if (promedioStr != null && !promedioStr.trim().isEmpty()) {
            try {
                double promedio = Double.parseDouble(promedioStr);
                estudiante.setPromedioPonderado(promedio);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Promedio debe ser un número válido");
                doGet(request, response);
                return;
            }
        }
        
        estudianteDAO.actualizar(estudiante);
        
        response.sendRedirect(request.getContextPath() + "/admin/estudiantes?mensaje=Estudiante actualizado exitosamente");
    }
    
    private void eliminarEstudiante(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        int idEstudiante = Integer.parseInt(request.getParameter("idEstudiante"));
        
        Estudiante estudiante = estudianteDAO.obtenerPorId(idEstudiante);
        if (estudiante == null) {
            request.setAttribute("error", "Estudiante no encontrado");
            doGet(request, response);
            return;
        }
        
        // Eliminar estudiante (esto también debería eliminar el usuario asociado)
        estudianteDAO.eliminar(idEstudiante);
        
        response.sendRedirect(request.getContextPath() + "/admin/estudiantes?mensaje=Estudiante eliminado exitosamente");
    }
    
    private void actualizarEstadoEstudiante(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        int idEstudiante = Integer.parseInt(request.getParameter("idEstudiante"));
        String nuevoEstado = request.getParameter("estado");
        
        // Aquí implementarías la lógica para cambiar el estado del estudiante
        // Si tu modelo tiene un campo "estado" o "activo"
        
        response.sendRedirect(request.getContextPath() + "/admin/estudiantes?mensaje=Estado del estudiante actualizado");
    }
}