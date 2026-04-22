/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import dao.OfertaPracticaDAO;
import modelo.Usuario;
import modelo.Empresa;
import modelo.OfertaPractica;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/empresa/nueva-oferta")
public class NuevaOfertaServlet extends HttpServlet {
    
    private OfertaPracticaDAO ofertaDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
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
        
        // Verificar que sea una empresa
        if (!"empresa".equals(usuario.getTipoUsuario().toLowerCase())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        System.out.println("🏢 Mostrando formulario de nueva oferta para empresa: " + usuario.getUsername());
        
        // Mostrar el formulario
        request.getRequestDispatcher("/vistas/empresa/nueva-oferta.jsp").forward(request, response);
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
        Empresa empresa = (Empresa) session.getAttribute("empresa");
        
        if (!"empresa".equals(usuario.getTipoUsuario().toLowerCase()) || empresa == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            System.out.println("📝 Procesando nueva oferta de empresa: " + empresa.getIdEmpresa());
            
            // Obtener datos del formulario
            String titulo = request.getParameter("titulo");
            String area = request.getParameter("area");
            String modalidad = request.getParameter("modalidad");
            String descripcion = request.getParameter("descripcion");
            String requisitos = request.getParameter("requisitos");
            int duracion = Integer.parseInt(request.getParameter("duracion"));
            int vacantes = Integer.parseInt(request.getParameter("vacantes"));
            Date fechaLimite = Date.valueOf(request.getParameter("fechaLimite"));
            String beneficios = request.getParameter("beneficios");
            
            // Crear nueva oferta
            OfertaPractica oferta = new OfertaPractica();
            oferta.setEmpresaId(empresa.getIdEmpresa());
            oferta.setTitulo(titulo);
            oferta.setArea(area);
            oferta.setModalidad(modalidad);
            oferta.setDescripcion(descripcion);
            oferta.setRequisitos(requisitos);
            oferta.setDuracionMeses(duracion);
            oferta.setVacantes(vacantes);
            oferta.setFechaLimitePostulacion(fechaLimite);
            oferta.setEstado("activa");
            
            // Agregar beneficios a la descripción si existen
            if (beneficios != null && !beneficios.trim().isEmpty()) {
                oferta.setDescripcion(descripcion + "\n\nBeneficios adicionales:\n" + beneficios);
            }
            
            // Guardar en base de datos
            ofertaDAO.insertar(oferta);
            
            request.setAttribute("mensaje", "¡Oferta creada exitosamente! Ya está disponible para que los estudiantes se postulen.");
            System.out.println("✅ Oferta creada exitosamente: " + titulo);
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Error en los datos numéricos. Verifica duración y número de vacantes.");
            System.err.println("❌ Error de formato: " + e.getMessage());
        } catch (Exception e) {
            request.setAttribute("error", "Error al crear la oferta: " + e.getMessage());
            System.err.println("💥 Error al crear oferta: " + e.getMessage());
            e.printStackTrace();
        }
        
        // Volver a mostrar el formulario con el mensaje
        request.getRequestDispatcher("/vistas/empresa/nueva-oferta.jsp").forward(request, response);
    }
}