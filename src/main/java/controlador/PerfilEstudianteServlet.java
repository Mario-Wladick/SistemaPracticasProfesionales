/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import dao.EstudianteDAO;
import modelo.Usuario;
import modelo.Estudiante;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/estudiante/perfil")
public class PerfilEstudianteServlet extends HttpServlet {
    
    private EstudianteDAO estudianteDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        estudianteDAO = new EstudianteDAO();
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
            Estudiante estudiante = (Estudiante) session.getAttribute("estudiante");
            
            System.out.println("👤 Cargando perfil de estudiante: " + usuario.getUsername());
            
            // Si no está en sesión, obtenerlo de la BD
            if (estudiante == null) {
                estudiante = estudianteDAO.obtenerPorIdUsuario(usuario.getIdUsuario());
                if (estudiante != null) {
                    session.setAttribute("estudiante", estudiante);
                }
            }
            
            // Establecer datos para la vista
            request.setAttribute("estudiante", estudiante);
            request.setAttribute("usuario", usuario);
            
            // Calcular completitud del perfil
            int completitud = calcularCompletitudPerfil(estudiante);
            request.setAttribute("completitudPerfil", completitud);
            
            // Determinar si el perfil está completo
            boolean perfilCompleto = completitud >= 80;
            request.setAttribute("perfilCompleto", perfilCompleto);
            
            System.out.println("✅ Perfil cargado - Completitud: " + completitud + "%");
            
        } catch (Exception e) {
            System.err.println("💥 Error al cargar perfil: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar el perfil: " + e.getMessage());
        }
        
        // Mostrar la vista del perfil
        request.getRequestDispatcher("/vistas/estudiante/perfil.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Verificar autenticación
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        Estudiante estudiante = (Estudiante) session.getAttribute("estudiante");
        
        if (!"estudiante".equals(usuario.getTipoUsuario().toLowerCase()) || estudiante == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            System.out.println("💾 Actualizando perfil de estudiante: " + estudiante.getIdEstudiante());
            
            // Obtener datos del formulario (solo campos que existen en tu modelo)
            String nombres = request.getParameter("nombres");
            String apellidos = request.getParameter("apellidos");
            String email = request.getParameter("email");
            String telefono = request.getParameter("telefono");
            String especialidad = request.getParameter("especialidad");
            String cicloStr = request.getParameter("ciclo");
            String promedioStr = request.getParameter("promedio");
            String dni = request.getParameter("dni");
            
            // Actualizar datos del estudiante (solo campos que existen)
            estudiante.setNombres(nombres);
            estudiante.setApellidos(apellidos);
            estudiante.setEmail(email);
            estudiante.setTelefono(telefono);
            estudiante.setEspecialidad(especialidad);
            estudiante.setDni(dni);
            
            // Convertir ciclo a int
            if (cicloStr != null && !cicloStr.trim().isEmpty()) {
                try {
                    int ciclo = Integer.parseInt(cicloStr);
                    estudiante.setCiclo(ciclo);
                } catch (NumberFormatException e) {
                    System.err.println("Error al convertir ciclo: " + cicloStr);
                }
            }
            
            // Convertir promedio a double
            if (promedioStr != null && !promedioStr.trim().isEmpty()) {
                try {
                    double promedio = Double.parseDouble(promedioStr);
                    estudiante.setPromedioPonderado(promedio);
                } catch (NumberFormatException e) {
                    System.err.println("Error al convertir promedio: " + promedioStr);
                }
            }
            
            // Guardar en base de datos
            estudianteDAO.actualizar(estudiante);
            
            // Actualizar en sesión
            session.setAttribute("estudiante", estudiante);
            
            request.setAttribute("mensaje", "Perfil actualizado exitosamente.");
            System.out.println("✅ Perfil actualizado correctamente");
            
        } catch (Exception e) {
            request.setAttribute("error", "Error al actualizar el perfil: " + e.getMessage());
            System.err.println("💥 Error al actualizar perfil: " + e.getMessage());
            e.printStackTrace();
        }
        
        // Volver a cargar el perfil
        doGet(request, response);
    }
    
    // Método auxiliar para calcular completitud del perfil (solo campos que existen)
    private int calcularCompletitudPerfil(Estudiante estudiante) {
        if (estudiante == null) return 0;
        
        int campos = 0;
        int completados = 0;
        
        // Campos obligatorios que existen en tu modelo
        campos++; if (estudiante.getNombres() != null && !estudiante.getNombres().trim().isEmpty()) completados++;
        campos++; if (estudiante.getApellidos() != null && !estudiante.getApellidos().trim().isEmpty()) completados++;
        campos++; if (estudiante.getEmail() != null && !estudiante.getEmail().trim().isEmpty()) completados++;
        campos++; if (estudiante.getEspecialidad() != null && !estudiante.getEspecialidad().trim().isEmpty()) completados++;
        campos++; if (estudiante.getCiclo() > 0) completados++;
        
        // Campos opcionales pero importantes
        campos++; if (estudiante.getTelefono() != null && !estudiante.getTelefono().trim().isEmpty()) completados++;
        campos++; if (estudiante.getDni() != null && !estudiante.getDni().trim().isEmpty()) completados++;
        campos++; if (estudiante.getCodigoUniversitario() != null && !estudiante.getCodigoUniversitario().trim().isEmpty()) completados++;
        campos++; if (estudiante.getPromedioPonderado() > 0) completados++;
        
        return campos > 0 ? (int) ((double) completados / campos * 100) : 0;
    }
}