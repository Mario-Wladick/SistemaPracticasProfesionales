<%-- 
    Document   : ofertas
    Created on : 9 jul. 2025, 2:58:23 p. m.
    Author     : LENOVO
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.OfertaPractica" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Ofertas - Panel Administrativo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-blue: #1e40af;
            --light-blue: #3b82f6;
            --lighter-blue: #dbeafe;
            --dark-blue: #1e3a8a;
            --gray-light: #f8fafc;
            --gray-medium: #64748b;
            --white: #ffffff;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --info: #06b6d4;
            --purple: #8b5cf6;
        }

        body {
            background-color: var(--gray-light);
            color: #1e293b;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .navbar {
            background: linear-gradient(135deg, var(--primary-blue), var(--light-blue));
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .navbar-brand {
            color: var(--white) !important;
            font-weight: bold;
        }

        .sidebar {
            background: var(--white);
            min-height: calc(100vh - 76px);
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
            padding: 0;
        }

        .sidebar-header {
            background: var(--primary-blue);
            color: var(--white);
            padding: 1rem;
            font-weight: bold;
        }

        .sidebar-menu {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .sidebar-menu li {
            border-bottom: 1px solid #e2e8f0;
        }

        .sidebar-menu a {
            display: block;
            padding: 1rem 1.5rem;
            color: var(--gray-medium);
            text-decoration: none;
            transition: all 0.2s ease;
        }

        .sidebar-menu a:hover {
            background-color: var(--lighter-blue);
            color: var(--primary-blue);
        }

        .sidebar-menu a.active {
            background-color: var(--light-blue);
            color: var(--white);
        }

        .main-content {
            padding: 2rem;
        }

        .stats-card {
            background: var(--white);
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border: 1px solid #e2e8f0;
            text-align: center;
            transition: transform 0.2s ease;
        }

        .stats-card:hover {
            transform: translateY(-2px);
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            color: var(--primary-blue);
        }

        .stat-label {
            color: var(--gray-medium);
            font-size: 0.95rem;
        }

        .content-card {
            background: var(--white);
            border-radius: 12px;
            padding: 2rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border: 1px solid #e2e8f0;
        }

        .filter-section {
            background: var(--lighter-blue);
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .offer-card {
            background: var(--white);
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            border: 1px solid #e2e8f0;
            transition: all 0.2s ease;
            border-left: 4px solid var(--info);
        }

        .offer-card:hover {
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transform: translateY(-1px);
        }

        .offer-card.activa {
            border-left-color: var(--success);
        }

        .offer-card.vencida {
            border-left-color: var(--warning);
        }

        .offer-card.suspendida {
            border-left-color: var(--danger);
        }

        .offer-icon {
            width: 60px;
            height: 60px;
            background: var(--lighter-blue);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: var(--primary-blue);
        }

        .status-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .status-activa {
            background-color: #dcfce7;
            color: #166534;
        }

        .status-vencida {
            background-color: #fef3c7;
            color: #92400e;
        }

        .status-suspendida {
            background-color: #fee2e2;
            color: #dc2626;
        }

        .status-borrador {
            background-color: #f3f4f6;
            color: #374151;
        }

        .modality-badge {
            padding: 0.25rem 0.5rem;
            border-radius: 15px;
            font-size: 0.75rem;
            font-weight: 500;
        }

        .modality-presencial {
            background-color: #dbeafe;
            color: #1d4ed8;
        }

        .modality-remoto {
            background-color: #ecfdf5;
            color: #059669;
        }

        .modality-hibrido {
            background-color: #fef3c7;
            color: #d97706;
        }

        .offer-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--text-color);
            margin-bottom: 0.5rem;
        }

        .offer-company {
            color: var(--gray-medium);
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }

        .offer-detail {
            font-size: 0.85rem;
            color: var(--gray-medium);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 0.25rem;
        }

        .btn-admin {
            background-color: var(--primary-blue);
            color: var(--white);
            border: none;
            border-radius: 6px;
            padding: 0.5rem 1rem;
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .btn-admin:hover {
            background-color: var(--dark-blue);
            color: var(--white);
        }

        .btn-edit {
            background-color: var(--warning);
            color: var(--white);
            border: none;
            border-radius: 6px;
            padding: 0.25rem 0.5rem;
            font-size: 0.8rem;
        }

        .btn-delete {
            background-color: var(--danger);
            color: var(--white);
            border: none;
            border-radius: 6px;
            padding: 0.25rem 0.5rem;
            font-size: 0.8rem;
        }

        .btn-view {
            background-color: var(--info);
            color: var(--white);
            border: none;
            border-radius: 6px;
            padding: 0.25rem 0.5rem;
            font-size: 0.8rem;
        }

        .btn-suspend {
            background-color: var(--danger);
            color: var(--white);
            border: none;
            border-radius: 6px;
            padding: 0.25rem 0.5rem;
            font-size: 0.8rem;
        }

        .btn-activate {
            background-color: var(--success);
            color: var(--white);
            border: none;
            border-radius: 6px;
            padding: 0.25rem 0.5rem;
            font-size: 0.8rem;
        }

        .form-control {
            border-radius: 6px;
            border: 1px solid #d1d5db;
        }

        .form-control:focus {
            border-color: var(--light-blue);
            box-shadow: 0 0 0 0.2rem rgba(59, 130, 246, 0.25);
        }

        .modal-header {
            background-color: var(--primary-blue);
            color: var(--white);
        }

        .alert-admin {
            border-radius: 8px;
            border: none;
        }

        .applications-count {
            background: var(--info);
            color: var(--white);
            border-radius: 50%;
            width: 35px;
            height: 35px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
            font-weight: bold;
        }

        .offer-description {
            color: var(--gray-medium);
            font-size: 0.9rem;
            margin: 1rem 0;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <a class="navbar-brand" href="<%= request.getContextPath() %>/admin/dashboard">
                <i class="fas fa-user-shield"></i> Panel Administrativo
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link text-white" href="<%= request.getContextPath() %>/logout">
                    <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
                </a>
            </div>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-2 p-0">
                <div class="sidebar">
                    <div class="sidebar-header">
                        <i class="fas fa-bars"></i> Menú Admin
                    </div>
                    <ul class="sidebar-menu">
                        <li><a href="<%= request.getContextPath() %>/admin/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                        <li><a href="<%= request.getContextPath() %>/admin/usuarios"><i class="fas fa-users"></i> Usuarios</a></li>
                        <li><a href="<%= request.getContextPath() %>/admin/estudiantes"><i class="fas fa-user-graduate"></i> Estudiantes</a></li>
                        <li><a href="<%= request.getContextPath() %>/admin/empresas"><i class="fas fa-building"></i> Empresas</a></li>
                        <li><a href="<%= request.getContextPath() %>/admin/ofertas" class="active"><i class="fas fa-briefcase"></i> Ofertas</a></li>
                        <li><a href="<%= request.getContextPath() %>/admin/practicas"><i class="fas fa-clipboard-list"></i> Prácticas</a></li>
                        <li><a href="<%= request.getContextPath() %>/admin/reportes"><i class="fas fa-chart-bar"></i> Reportes</a></li>
                    </ul>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-10">
                <div class="main-content">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h2><i class="fas fa-briefcase"></i> Gestión de Ofertas</h2>
                        <div>
                            <button class="btn btn-admin me-2">
                                <i class="fas fa-download"></i> Exportar Excel
                            </button>
                            <button class="btn btn-admin">
                                <i class="fas fa-chart-bar"></i> Ver Reportes
                            </button>
                        </div>
                    </div>

                    <!-- Alertas -->
                    <% if (request.getParameter("mensaje") != null) { %>
                        <div class="alert alert-success alert-admin alert-dismissible fade show">
                            <i class="fas fa-check-circle"></i> <%= request.getParameter("mensaje") %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    <% } %>
                    
                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger alert-admin alert-dismissible fade show">
                            <i class="fas fa-exclamation-triangle"></i> <%= request.getAttribute("error") %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    <% } %>

                    <!-- Estadísticas -->
                    <div class="row mb-4">
                        <div class="col-md-2">
                            <div class="stats-card">
                                <div class="stat-number"><%= request.getAttribute("totalOfertas") %></div>
                                <div class="stat-label">Total Ofertas</div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="stats-card">
                                <div class="stat-number"><%= request.getAttribute("ofertasActivas") %></div>
                                <div class="stat-label">Activas</div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="stats-card">
                                <div class="stat-number"><%= request.getAttribute("ofertasVencidas") %></div>
                                <div class="stat-label">Vencidas</div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="stats-card">
                                <div class="stat-number"><%= request.getAttribute("presencial") %></div>
                                <div class="stat-label">Presencial</div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="stats-card">
                                <div class="stat-number"><%= request.getAttribute("remoto") %></div>
                                <div class="stat-label">Remoto</div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="stats-card">
                                <div class="stat-number"><%= request.getAttribute("promedioDuracion") %></div>
                                <div class="stat-label">Duración Promedio</div>
                            </div>
                        </div>
                    </div>

                    <!-- Filtros -->
                    <div class="filter-section">
                        <form method="GET" action="<%= request.getContextPath() %>/admin/ofertas">
                            <div class="row">
                                <div class="col-md-3">
                                    <label class="form-label"><strong>Buscar:</strong></label>
                                    <input type="text" class="form-control" name="busqueda" 
                                           value="<%= request.getAttribute("busqueda") != null ? request.getAttribute("busqueda") : "" %>"
                                           placeholder="Título o descripción...">
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label"><strong>Estado:</strong></label>
                                    <select class="form-control" name="estado">
                                        <option value="todas">Todos los estados</option>
                                        <option value="activa" <%= "activa".equals(request.getAttribute("filtroEstado")) ? "selected" : "" %>>Activa</option>
                                        <option value="vencida" <%= "vencida".equals(request.getAttribute("filtroEstado")) ? "selected" : "" %>>Vencida</option>
                                        <option value="suspendida" <%= "suspendida".equals(request.getAttribute("filtroEstado")) ? "selected" : "" %>>Suspendida</option>
                                        <option value="borrador" <%= "borrador".equals(request.getAttribute("filtroEstado")) ? "selected" : "" %>>Borrador</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label"><strong>Modalidad:</strong></label>
                                    <select class="form-control" name="modalidad">
                                        <option value="todas">Todas las modalidades</option>
                                        <option value="Presencial" <%= "Presencial".equals(request.getAttribute("filtroModalidad")) ? "selected" : "" %>>Presencial</option>
                                        <option value="Remoto" <%= "Remoto".equals(request.getAttribute("filtroModalidad")) ? "selected" : "" %>>Remoto</option>
                                        <option value="Híbrido" <%= "Híbrido".equals(request.getAttribute("filtroModalidad")) ? "selected" : "" %>>Híbrido</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label"><strong>Área:</strong></label>
                                    <input type="text" class="form-control" name="area" 
                                           value="<%= request.getAttribute("filtroArea") != null ? request.getAttribute("filtroArea") : "" %>"
                                           placeholder="Área de práctica...">
                                </div>
                                <div class="col-md-3 d-flex align-items-end">
                                    <button type="submit" class="btn btn-admin me-2">
                                        <i class="fas fa-search"></i> Filtrar
                                    </button>
                                    <a href="<%= request.getContextPath() %>/admin/ofertas" class="btn btn-outline-secondary">
                                        <i class="fas fa-times"></i> Limpiar
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>

                    <!-- Lista de Ofertas -->
                    <div class="content-card">
                        <%
                            List<OfertaPractica> ofertas = (List<OfertaPractica>) request.getAttribute("ofertas");
                            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                            
                            if (ofertas != null && !ofertas.isEmpty()) {
                                for (OfertaPractica oferta : ofertas) {
                                    String statusClass = "status-" + (oferta.getEstado() != null ? oferta.getEstado() : "borrador");
                                    String modalityClass = "modality-" + (oferta.getModalidad() != null ? oferta.getModalidad().toLowerCase() : "presencial");
                                    String cardClass = "offer-card " + (oferta.getEstado() != null ? oferta.getEstado() : "borrador");
                        %>
                        <div class="<%= cardClass %>">
                            <div class="row align-items-center">
                                <div class="col-md-1">
                                    <div class="offer-icon">
                                        <i class="fas fa-briefcase"></i>
                                    </div>
                                </div>
                                <div class="col-md-5">
                                    <div class="offer-title"><%= oferta.getTitulo() %></div>
                                    <div class="offer-company">
                                        <i class="fas fa-building"></i>
                                        Empresa ID: <%= oferta.getEmpresaId() %> <!-- Aquí deberías mostrar el nombre de la empresa -->
                                    </div>
                                    <div class="offer-description">
                                        <%= oferta.getDescripcion() != null ? oferta.getDescripcion() : "Sin descripción" %>
                                    </div>
                                    <div class="d-flex gap-2 align-items-center mt-2">
                                        <span class="status-badge <%= statusClass %>">
                                            <%= oferta.getEstado() != null ? oferta.getEstado().substring(0, 1).toUpperCase() + oferta.getEstado().substring(1) : "Borrador" %>
                                        </span>
                                        <span class="modality-badge <%= modalityClass %>">
                                            <%= oferta.getModalidad() != null ? oferta.getModalidad() : "Presencial" %>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="offer-detail">
                                        <i class="fas fa-calendar"></i>
                                        <span>Duración: <%= oferta.getDuracionMeses() %> meses</span>
                                    </div>
                                    <div class="offer-detail">
                                        <i class="fas fa-clock"></i>
                                        <span>Publicado: <%= oferta.getFechaPublicacion() != null ? sdf.format(oferta.getFechaPublicacion()) : "N/A" %></span>
                                    </div>
                                    <% if (oferta.getFechaLimitePostulacion() != null) { %>
                                    <div class="offer-detail">
                                        <i class="fas fa-hourglass-end"></i>
                                        <span>Vence: <%= sdf.format(oferta.getFechaLimitePostulacion()) %></span>
                                    </div>
                                    <% } %>
                                    <% if (oferta.getArea() != null) { %>
                                    <div class="offer-detail">
                                        <i class="fas fa-tag"></i>
                                        <span><%= oferta.getArea() %></span>
                                    </div>
                                    <% } %>
                                </div>
                                <div class="col-md-2 text-center">
                                    <div class="applications-count" title="Postulaciones recibidas">
                                        8
                                    </div>
                                    <small class="text-muted">Postulaciones</small>
                                    
                                    <div class="mt-2">
                                        <small class="text-muted">
                                            <i class="fas fa-eye"></i> 156 vistas
                                        </small>
                                    </div>
                                </div>
                                <div class="col-md-2 text-end">
                                    <button class="btn btn-view me-1" 
                                            onclick="verDetalles(<%= oferta.getId() %>)">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button class="btn btn-edit me-1" 
                                            onclick="editarOferta(<%= oferta.getId() %>, '<%= oferta.getTitulo() %>', '<%= oferta.getDescripcion() != null ? oferta.getDescripcion().replace("'", "\\'") : "" %>', '<%= oferta.getRequisitos() != null ? oferta.getRequisitos().replace("'", "\\'") : "" %>', '<%= oferta.getModalidad() != null ? oferta.getModalidad() : "" %>', '<%= oferta.getArea() != null ? oferta.getArea() : "" %>', <%= oferta.getDuracionMeses() %>)">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <br class="my-1">
                                    <% if ("activa".equals(oferta.getEstado())) { %>
                                    <button class="btn btn-suspend me-1" 
                                            onclick="suspenderOferta(<%= oferta.getId() %>, '<%= oferta.getTitulo() %>')">
                                        <i class="fas fa-pause"></i>
                                    </button>
                                    <% } else if ("suspendida".equals(oferta.getEstado())) { %>
                                    <button class="btn btn-activate me-1" 
                                            onclick="activarOferta(<%= oferta.getId() %>)">
                                        <i class="fas fa-play"></i>
                                    </button>
                                    <% } %>
                                    <button class="btn btn-delete" 
                                            onclick="eliminarOferta(<%= oferta.getId() %>, '<%= oferta.getTitulo() %>')">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <%
                                }
                            } else {
                        %>
                        <div class="text-center py-5">
                            <i class="fas fa-briefcase fa-5x text-muted mb-3"></i>
                            <h4 class="text-muted">No se encontraron ofertas</h4>
                            <p class="text-muted">No hay ofertas que coincidan con los filtros seleccionados.</p>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Ver Detalles -->
    <div class="modal fade" id="modalDetalles" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Detalles de la Oferta</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <h6>Información General</h6>
                            <p><strong>Título:</strong> <span id="detTitulo"></span></p>
                            <p><strong>Estado:</strong> <span id="detEstado"></span></p>
                            <p><strong>Modalidad:</strong> <span id="detModalidad"></span></p>
                            <p><strong>Duración:</strong> <span id="detDuracion"></span></p>
                            <p><strong>Área de Práctica:</strong> <span id="detArea"></span></p>
                        </div>
                        <div class="col-md-6">
                            <h6>Fechas Importantes</h6>
                            <p><strong>Fecha Publicación:</strong> <span id="detFechaPublicacion"></span></p>
                            <p><strong>Fecha Vencimiento:</strong> <span id="detFechaVencimiento"></span></p>
                            <p><strong>Postulaciones:</strong> <span id="detPostulaciones"></span></p>
                            <p><strong>Vistas:</strong> <span id="detVistas"></span></p>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-md-12">
                            <h6>Descripción</h6>
                            <p id="detDescripcion"></p>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-md-12">
                            <h6>Requisitos</h6>
                            <p id="detRequisitos"></p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Editar Oferta -->
    <div class="modal fade" id="modalEditarOferta" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Editar Oferta</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form method="POST" action="<%= request.getContextPath() %>/admin/ofertas">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="editar">
                        <input type="hidden" name="idOferta" id="editIdOferta">
                        
                        <div class="mb-3">
                            <label class="form-label">Título:</label>
                            <input type="text" class="form-control" name="titulo" id="editTitulo" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Descripción:</label>
                            <textarea class="form-control" name="descripcion" id="editDescripcion" rows="3" required></textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Requisitos:</label>
                            <textarea class="form-control" name="requisitos" id="editRequisitos" rows="3"></textarea>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label">Modalidad:</label>
                                    <select class="form-control" name="modalidad" id="editModalidad" required>
                                        <option value="Presencial">Presencial</option>
                                        <option value="Remoto">Remoto</option>
                                        <option value="Híbrido">Híbrido</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label">Duración (meses):</label>
                                    <input type="number" class="form-control" name="duracion" id="editDuracion" min="1" max="12" required>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label">Área de Práctica:</label>
                                    <input type="text" class="form-control" name="areaPractica" id="editAreaPractica">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-admin">Actualizar Oferta</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal Suspender Oferta -->
    <div class="modal fade" id="modalSuspender" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Suspender Oferta</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form method="POST" action="<%= request.getContextPath() %>/admin/ofertas">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="suspender">
                        <input type="hidden" name="idOferta" id="suspendIdOferta">
                        
                        <div class="alert alert-warning">
                            <i class="fas fa-exclamation-triangle"></i>
                            <strong>¿Estás seguro?</strong><br>
                            Esta acción suspenderá la oferta y no será visible para los estudiantes.
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Motivo de la suspensión (opcional):</label>
                            <textarea class="form-control" name="motivo" rows="3" placeholder="Describe el motivo por el cual se suspende esta oferta..."></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-danger">Suspender Oferta</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function verDetalles(id) {
            // Aquí cargarías los detalles de la oferta por AJAX
            const modal = new bootstrap.Modal(document.getElementById('modalDetalles'));
            modal.show();
        }

        function editarOferta(id, titulo, descripcion, requisitos, modalidad, areaPractica, duracion) {
            document.getElementById('editIdOferta').value = id;
            document.getElementById('editTitulo').value = titulo;
            document.getElementById('editDescripcion').value = descripcion;
            document.getElementById('editRequisitos').value = requisitos;
            document.getElementById('editModalidad').value = modalidad;
            document.getElementById('editAreaPractica').value = areaPractica;
            document.getElementById('editDuracion').value = duracion;
            
            const modal = new bootstrap.Modal(document.getElementById('modalEditarOferta'));
            modal.show();
        }

        function eliminarOferta(id, titulo) {
            if (confirm('¿Estás seguro de que deseas eliminar la oferta "' + titulo + '"?\n\nEsta acción no se puede deshacer y eliminará también:\n- Todas las postulaciones recibidas\n- El historial de la oferta')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '<%= request.getContextPath() %>/admin/ofertas';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'eliminar';
                
                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'idOferta';
                idInput.value = id;
                
                form.appendChild(actionInput);
                form.appendChild(idInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        function suspenderOferta(id, titulo) {
            document.getElementById('suspendIdOferta').value = id;
            const modal = new bootstrap.Modal(document.getElementById('modalSuspender'));
            modal.show();
        }

        function activarOferta(id) {
            if (confirm('¿Activar esta oferta?\n\nLa oferta volverá a ser visible para los estudiantes.')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '<%= request.getContextPath() %>/admin/ofertas';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'activar';
                
                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'idOferta';
                idInput.value = id;
                
                form.appendChild(actionInput);
                form.appendChild(idInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        // Validación en tiempo real
        document.addEventListener('DOMContentLoaded', function() {
            const duracionInput = document.getElementById('editDuracion');
            if (duracionInput) {
                duracionInput.addEventListener('input', function() {
                    const value = parseInt(this.value);
                    if (value < 1) {
                        this.setCustomValidity('La duración debe ser de al menos 1 mes');
                    } else if (value > 12) {
                        this.setCustomValidity('La duración no puede ser mayor a 12 meses');
                    } else {
                        this.setCustomValidity('');
                    }
                });
            }
        });

        // Auto-cerrar alertas
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert-dismissible');
            alerts.forEach(alert => {
                if (alert.classList.contains('show')) {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                }
            });
        }, 5000);
    </script>
</body>
</html>