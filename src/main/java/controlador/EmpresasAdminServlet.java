/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import dao.EmpresaDAO;
import dao.UsuarioDAO;
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

@WebServlet("/admin/empresas")
public class EmpresasAdminServlet extends HttpServlet {
    
    private EmpresaDAO empresaDAO;
    private UsuarioDAO usuarioDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        this.empresaDAO = new EmpresaDAO();
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
            String filtroSector = request.getParameter("sector");
            String filtroUbicacion = request.getParameter("ubicacion");
            String busqueda = request.getParameter("busqueda");
            
            // Obtener todas las empresas
            List<Empresa> todasEmpresas = empresaDAO.obtenerTodos();
            
            // Aplicar filtros
            List<Empresa> empresasFiltradas = todasEmpresas;
            
            if (filtroSector != null && !filtroSector.isEmpty() && !"todos".equals(filtroSector)) {
                empresasFiltradas = empresasFiltradas.stream()
                    .filter(e -> filtroSector.equals(e.getSector()))
                    .collect(Collectors.toList());
            }
            
            if (filtroUbicacion != null && !filtroUbicacion.isEmpty() && !"todas".equals(filtroUbicacion)) {
                empresasFiltradas = empresasFiltradas.stream()
                    .filter(e -> e.getDireccion() != null && e.getDireccion().toLowerCase().contains(filtroUbicacion.toLowerCase()))
                    .collect(Collectors.toList());
            }
            
            if (busqueda != null && !busqueda.trim().isEmpty()) {
                String busquedaLower = busqueda.toLowerCase().trim();
                empresasFiltradas = empresasFiltradas.stream()
                    .filter(e -> e.getRazonSocial().toLowerCase().contains(busquedaLower) ||
                               (e.getRuc() != null && e.getRuc().toLowerCase().contains(busquedaLower)) ||
                               (e.getEmailContacto() != null && e.getEmailContacto().toLowerCase().contains(busquedaLower)))
                    .collect(Collectors.toList());
            }
            
            // Calcular estadísticas
            long totalEmpresas = todasEmpresas.size();
            
            // Contar por sectores
            long tecnologia = todasEmpresas.stream().filter(e -> "Tecnología".equals(e.getSector())).count();
            long manufactura = todasEmpresas.stream().filter(e -> "Manufactura".equals(e.getSector())).count();
            long servicios = todasEmpresas.stream().filter(e -> "Servicios".equals(e.getSector())).count();
            long construccion = todasEmpresas.stream().filter(e -> "Construcción".equals(e.getSector())).count();
            long salud = todasEmpresas.stream().filter(e -> "Salud".equals(e.getSector())).count();
            long otros = totalEmpresas - (tecnologia + manufactura + servicios + construccion + salud);
            
            // Empresas con más ofertas activas (simulado por ahora)
            long empresasActivas = todasEmpresas.stream().filter(e -> 
                e.getEmailContacto() != null && !e.getEmailContacto().isEmpty()
            ).count();
            
            // Establecer atributos para la vista
            request.setAttribute("empresas", empresasFiltradas);
            request.setAttribute("totalEmpresas", totalEmpresas);
            request.setAttribute("empresasActivas", empresasActivas);
            request.setAttribute("tecnologia", tecnologia);
            request.setAttribute("manufactura", manufactura);
            request.setAttribute("servicios", servicios);
            request.setAttribute("construccion", construccion);
            request.setAttribute("salud", salud);
            request.setAttribute("otros", otros);
            request.setAttribute("filtroSector", filtroSector);
            request.setAttribute("filtroUbicacion", filtroUbicacion);
            request.setAttribute("busqueda", busqueda);
            
            // Reenviar a la vista
            request.getRequestDispatcher("/vistas/admin/empresas.jsp").forward(request, response);
            
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
                    editarEmpresa(request, response);
                    break;
                case "eliminar":
                    eliminarEmpresa(request, response);
                    break;
                case "cambiar_estado":
                    cambiarEstadoEmpresa(request, response);
                    break;
                case "validar":
                    validarEmpresa(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción no válida");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error interno del servidor");
        }
    }
    
    private void editarEmpresa(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        int idEmpresa = Integer.parseInt(request.getParameter("idEmpresa"));
        String razonSocial = request.getParameter("nombre");
        String ruc = request.getParameter("ruc");
        String sector = request.getParameter("sector");
        String direccion = request.getParameter("ubicacion");
        String telefono = request.getParameter("telefono");
        String emailContacto = request.getParameter("contactoEmail");
        String descripcion = request.getParameter("descripcion");
        String sitioWeb = request.getParameter("sitioWeb");
        
        Empresa empresa = empresaDAO.obtenerPorId(idEmpresa);
        if (empresa == null) {
            request.setAttribute("error", "Empresa no encontrada");
            doGet(request, response);
            return;
        }
        
        // Actualizar datos
        empresa.setRazonSocial(razonSocial.trim());
        empresa.setRuc(ruc != null ? ruc.trim() : null);
        empresa.setSector(sector);
        empresa.setDireccion(direccion != null ? direccion.trim() : null);
        empresa.setTelefono(telefono != null ? telefono.trim() : null);
        empresa.setEmailContacto(emailContacto != null ? emailContacto.trim() : null);
        empresa.setDescripcion(descripcion != null ? descripcion.trim() : null);
        empresa.setSitioWeb(sitioWeb != null ? sitioWeb.trim() : null);
        
        empresaDAO.actualizar(empresa);
        
        response.sendRedirect(request.getContextPath() + "/admin/empresas?mensaje=Empresa actualizada exitosamente");
    }
    
    private void eliminarEmpresa(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        int idEmpresa = Integer.parseInt(request.getParameter("idEmpresa"));
        
        Empresa empresa = empresaDAO.obtenerPorId(idEmpresa);
        if (empresa == null) {
            request.setAttribute("error", "Empresa no encontrada");
            doGet(request, response);
            return;
        }
        
        // Eliminar empresa (esto también debería eliminar ofertas asociadas)
        empresaDAO.eliminar(idEmpresa);
        
        response.sendRedirect(request.getContextPath() + "/admin/empresas?mensaje=Empresa eliminada exitosamente");
    }
    
    private void cambiarEstadoEmpresa(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        int idEmpresa = Integer.parseInt(request.getParameter("idEmpresa"));
        String nuevoEstado = request.getParameter("estado");
        
        // Aquí implementarías la lógica para cambiar el estado de la empresa
        // Si tu modelo tiene un campo "estado" o "activo"
        
        response.sendRedirect(request.getContextPath() + "/admin/empresas?mensaje=Estado de la empresa actualizado");
    }
    
    private void validarEmpresa(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        int idEmpresa = Integer.parseInt(request.getParameter("idEmpresa"));
        boolean validada = Boolean.parseBoolean(request.getParameter("validada"));
        
        // Aquí implementarías la lógica para validar/invalidar empresa
        // Si tu modelo tiene un campo "validada" o "verificada"
        
        String mensaje = validada ? "Empresa validada correctamente" : "Validación de empresa removida";
        response.sendRedirect(request.getContextPath() + "/admin/empresas?mensaje=" + mensaje);
    }
}