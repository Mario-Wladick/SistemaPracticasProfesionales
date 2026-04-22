<%-- 
    Document   : empresa
    Created on : 9 jul. 2025, 2:38:50 p. m.
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Empresa" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Empresas - Panel Administrativo</title>
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

        .company-card {
            background: var(--white);
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            border: 1px solid #e2e8f0;
            transition: all 0.2s ease;
        }

        .company-card:hover {
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transform: translateY(-1px);
        }

        .company-logo {
            width: 80px;
            height: 80px;
            background: var(--lighter-blue);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: var(--primary-blue);
            font-weight: bold;
        }

        .sector-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .badge-tecnologia {
            background-color: #dbeafe;
            color: #1d4ed8;
        }

        .badge-manufactura {
            background-color: #fef3c7;
            color: #d97706;
        }

        .badge-servicios {
            background-color: #ecfdf5;
            color: #059669;
        }

        .badge-construccion {
            background-color: #fed7d7;
            color: #c53030;
        }

        .badge-salud {
            background-color: #e0e7ff;
            color: #5b21b6;
        }

        .badge-otros {
            background-color: #f3f4f6;
            color: #374151;
        }

        .verification-badge {
            display: inline-flex;
            align-items: center;
            padding: 0.25rem 0.5rem;
            border-radius: 15px;
            font-size: 0.75rem;
            font-weight: 500;
        }

        .verified {
            background-color: #dcfce7;
            color: #166534;
        }

        .unverified {
            background-color: #fef3c7;
            color: #92400e;
        }

        .company-info {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .company-name {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--text-color);
            margin-bottom: 0.5rem;
        }

        .company-detail {
            font-size: 0.9rem;
            color: var(--gray-medium);
            display: flex;
            align-items: center;
            gap: 0.5rem;
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

        .btn-verify {
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

        .offers-indicator {
            background: var(--info);
            color: var(--white);
            border-radius: 50%;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
            font-weight: bold;
        }

        .contact-info {
            background: var(--lighter-blue);
            border-radius: 6px;
            padding: 0.75rem;
            margin-top: 0.5rem;
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
                        <li><a href="<%= request.getContextPath() %>/admin/empresas" class="active"><i class="fas fa-building"></i> Empresas</a></li>
                        <li><a href="<%= request.getContextPath() %>/admin/ofertas"><i class="fas fa-briefcase"></i> Ofertas</a></li>
                        <li><a href="<%= request.getContextPath() %>/admin/practicas"><i class="fas fa-clipboard-list"></i> Prácticas</a></li>
                        <li><a href="<%= request.getContextPath() %>/admin/reportes"><i class="fas fa-chart-bar"></i> Reportes</a></li>
                    </ul>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-10">
                <div class="main-content">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h2><i class="fas fa-building"></i> Gestión de Empresas</h2>
                        <div>
                            <button class="btn btn-admin me-2">
                                <i class="fas fa-download"></i> Exportar Excel
                            </button>
                            <button class="btn btn-admin">
                                <i class="fas fa-chart-pie"></i> Ver Estadísticas
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
                                <div class="stat-number"><%= request.getAttribute("totalEmpresas") %></div>
                                <div class="stat-label">Total Empresas</div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="stats-card">
                                <div class="stat-number"><%= request.getAttribute("empresasActivas") %></div>
                                <div class="stat-label">Empresas Activas</div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="stats-card">
                                <div class="stat-number"><%= request.getAttribute("tecnologia") %></div>
                                <div class="stat-label">Tecnología</div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="stats-card">
                                <div class="stat-number"><%= request.getAttribute("servicios") %></div>
                                <div class="stat-label">Servicios</div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="stats-card">
                                <div class="stat-number"><%= request.getAttribute("manufactura") %></div>
                                <div class="stat-label">Manufactura</div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="stats-card">
                                <div class="stat-number"><%= request.getAttribute("construccion") %></div>
                                <div class="stat-label">Construcción</div>
                            </div>
                        </div>
                    </div>

                    <!-- Filtros -->
                    <div class="filter-section">
                        <form method="GET" action="<%= request.getContextPath() %>/admin/empresas">
                            <div class="row">
                                <div class="col-md-3">
                                    <label class="form-label"><strong>Buscar:</strong></label>
                                    <input type="text" class="form-control" name="busqueda" 
                                           value="<%= request.getAttribute("busqueda") != null ? request.getAttribute("busqueda") : "" %>"
                                           placeholder="Nombre, RUC o email...">
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label"><strong>Sector:</strong></label>
                                    <select class="form-control" name="sector">
                                        <option value="todos">Todos los sectores</option>
                                        <option value="Tecnología" <%= "Tecnología".equals(request.getAttribute("filtroSector")) ? "selected" : "" %>>Tecnología</option>
                                        <option value="Manufactura" <%= "Manufactura".equals(request.getAttribute("filtroSector")) ? "selected" : "" %>>Manufactura</option>
                                        <option value="Servicios" <%= "Servicios".equals(request.getAttribute("filtroSector")) ? "selected" : "" %>>Servicios</option>
                                        <option value="Construcción" <%= "Construcción".equals(request.getAttribute("filtroSector")) ? "selected" : "" %>>Construcción</option>
                                        <option value="Salud" <%= "Salud".equals(request.getAttribute("filtroSector")) ? "selected" : "" %>>Salud</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label"><strong>Ubicación:</strong></label>
                                    <input type="text" class="form-control" name="ubicacion" 
                                           value="<%= request.getAttribute("filtroUbicacion") != null ? request.getAttribute("filtroUbicacion") : "" %>"
                                           placeholder="Ciudad...">
                                </div>
                                <div class="col-md-4 d-flex align-items-end">
                                    <button type="submit" class="btn btn-admin me-2">
                                        <i class="fas fa-search"></i> Filtrar
                                    </button>
                                    <a href="<%= request.getContextPath() %>/admin/empresas" class="btn btn-outline-secondary">
                                        <i class="fas fa-times"></i> Limpiar
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>

                    <!-- Lista de Empresas -->
                    <div class="content-card">
                        <%
                            List<Empresa> empresas = (List<Empresa>) request.getAttribute("empresas");
                            
                            if (empresas != null && !empresas.isEmpty()) {
                                for (Empresa empresa : empresas) {
                                    String badgeClass = "";
                                    switch (empresa.getSector() != null ? empresa.getSector() : "Otros") {
                                        case "Tecnología":
                                            badgeClass = "badge-tecnologia";
                                            break;
                                        case "Manufactura":
                                            badgeClass = "badge-manufactura";
                                            break;
                                        case "Servicios":
                                            badgeClass = "badge-servicios";
                                            break;
                                        case "Salud":
                                            badgeClass = "badge-salud";
                                            break;
                                        default:
                                            badgeClass = "badge-otros";
                                            break;
                                    }
                                    
                                    // Simulamos la verificación de empresa
                                    boolean esVerificada = empresa.getEmailContacto() != null && !empresa.getEmailContacto().isEmpty();
                        %>
                        <div class="company-card">
                            <div class="row align-items-center">
                                <div class="col-md-1">
                                    <div class="company-logo">
                                        <%= empresa.getRazonSocial().substring(0, Math.min(2, empresa.getRazonSocial().length())).toUpperCase() %>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="company-name"><%= empresa.getRazonSocial() %></div>
                                    <div class="company-detail">
                                        <i class="fas fa-id-card"></i>
                                        <span>RUC: <%= empresa.getRuc() != null ? empresa.getRuc() : "No registrado" %></span>
                                    </div>
                                    <div class="company-detail">
                                        <i class="fas fa-map-marker-alt"></i>
                                        <span><%= empresa.getDireccion() != null ? empresa.getDireccion() : "No especificada" %></span>
                                    </div>
                                    <% if (empresa.getSitioWeb() != null && !empresa.getSitioWeb().isEmpty()) { %>
                                    <div class="company-detail">
                                        <i class="fas fa-globe"></i>
                                        <a href="<%= empresa.getSitioWeb() %>" target="_blank" class="text-decoration-none">
                                            <%= empresa.getSitioWeb() %>
                                        </a>
                                    </div>
                                    <% } %>
                                </div>
                                <div class="col-md-2">
                                    <span class="sector-badge <%= badgeClass %>">
                                        <%= empresa.getSector() != null ? empresa.getSector() : "Otros" %>
                                    </span>
                                    <div class="mt-2">
                                        <span class="verification-badge <%= esVerificada ? "verified" : "unverified" %>">
                                            <i class="fas fa-<%= esVerificada ? "check-circle" : "clock" %>"></i>
                                            <%= esVerificada ? "Verificada" : "Pendiente" %>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <% if (empresa.getEmailContacto() != null) { %>
                                    <div class="contact-info">
                                        <div class="company-detail">
                                            <i class="fas fa-envelope"></i>
                                            <span><%= empresa.getEmailContacto() %></span>
                                        </div>
                                        <% if (empresa.getTelefono() != null) { %>
                                        <div class="company-detail">
                                            <i class="fas fa-phone"></i>
                                            <span><%= empresa.getTelefono() %></span>
                                        </div>
                                        <% } %>
                                    </div>
                                    <% } else { %>
                                    <div class="text-muted text-center">
                                        <i class="fas fa-exclamation-triangle"></i><br>
                                        <small>Sin contacto</small>
                                    </div>
                                    <% } %>
                                </div>
                                <div class="col-md-1 text-center">
                                    <div class="offers-indicator" title="Ofertas activas">
                                        5
                                    </div>
                                    <small class="text-muted">Ofertas</small>
                                </div>
                                <div class="col-md-2 text-end">
                                    <button class="btn btn-view me-1" 
                                            onclick="verDetalles(<%= empresa.getIdEmpresa() %>)">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button class="btn btn-edit me-1" 
                                            onclick="editarEmpresa(<%= empresa.getIdEmpresa() %>, '<%= empresa.getRazonSocial() %>', '<%= empresa.getRuc() != null ? empresa.getRuc() : "" %>', '<%= empresa.getSector() != null ? empresa.getSector() : "" %>', '<%= empresa.getDireccion() != null ? empresa.getDireccion() : "" %>', '<%= empresa.getTelefono() != null ? empresa.getTelefono() : "" %>', '<%= empresa.getEmailContacto() != null ? empresa.getEmailContacto() : "" %>', '<%= empresa.getDescripcion() != null ? empresa.getDescripcion().replace("'", "\\'") : "" %>', '<%= empresa.getSitioWeb() != null ? empresa.getSitioWeb() : "" %>')">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <% if (!esVerificada) { %>
                                    <button class="btn btn-verify me-1" 
                                            onclick="validarEmpresa(<%= empresa.getIdEmpresa() %>, true)">
                                        <i class="fas fa-check"></i>
                                    </button>
                                    <% } %>
                                    <button class="btn btn-delete" 
                                            onclick="eliminarEmpresa(<%= empresa.getIdEmpresa() %>, '<%= empresa.getRazonSocial() %>')">
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
                            <i class="fas fa-building fa-5x text-muted mb-3"></i>
                            <h4 class="text-muted">No se encontraron empresas</h4>
                            <p class="text-muted">No hay empresas que coincidan con los filtros seleccionados.</p>
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
                    <h5 class="modal-title">Detalles de la Empresa</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <h6>Información General</h6>
                            <p><strong>Nombre:</strong> <span id="detNombre"></span></p>
                            <p><strong>RUC:</strong> <span id="detRuc"></span></p>
                            <p><strong>Sector:</strong> <span id="detSector"></span></p>
                            <p><strong>Ubicación:</strong> <span id="detUbicacion"></span></p>
                            <p><strong>Sitio Web:</strong> <span id="detSitioWeb"></span></p>
                        </div>
                        <div class="col-md-6">
                            <h6>Información de Contacto</h6>
                            <p><strong>Contacto:</strong> <span id="detContactoNombre"></span></p>
                            <p><strong>Email:</strong> <span id="detContactoEmail"></span></p>
                            <p><strong>Teléfono:</strong> <span id="detTelefono"></span></p>
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
                            <h6>Ofertas Publicadas</h6>
                            <div class="alert alert-info">
                                <i class="fas fa-info-circle"></i>
                                Esta funcionalidad estará disponible próximamente.
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Editar Empresa -->
    <div class="modal fade" id="modalEditarEmpresa" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Editar Empresa</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form method="POST" action="<%= request.getContextPath() %>/admin/empresas">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="editar">
                        <input type="hidden" name="idEmpresa" id="editIdEmpresa">
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Nombre de la Empresa:</label>
                                    <input type="text" class="form-control" name="nombre" id="editNombre" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">RUC:</label>
                                    <input type="text" class="form-control" name="ruc" id="editRuc">
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Sector:</label>
                                    <select class="form-control" name="sector" id="editSector" required>
                                        <option value="">Seleccionar sector</option>
                                        <option value="Tecnología">Tecnología</option>
                                        <option value="Manufactura">Manufactura</option>
                                        <option value="Servicios">Servicios</option>
                                        <option value="Construcción">Construcción</option>
                                        <option value="Salud">Salud</option>
                                        <option value="Educación">Educación</option>
                                        <option value="Financiero">Financiero</option>
                                        <option value="Otros">Otros</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Dirección:</label>
                                    <input type="text" class="form-control" name="ubicacion" id="editUbicacion">
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Teléfono:</label>
                                    <input type="text" class="form-control" name="telefono" id="editTelefono">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Sitio Web:</label>
                                    <input type="url" class="form-control" name="sitioWeb" id="editSitioWeb">
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-12">
                                <div class="mb-3">
                                    <label class="form-label">Email de Contacto:</label>
                                    <input type="email" class="form-control" name="contactoEmail" id="editContactoEmail">
                                </div>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Descripción:</label>
                            <textarea class="form-control" name="descripcion" id="editDescripcion" rows="3"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-admin">Actualizar Empresa</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function verDetalles(id) {
            // Aquí cargarías los detalles de la empresa por AJAX
            // Por ahora solo muestro el modal
            const modal = new bootstrap.Modal(document.getElementById('modalDetalles'));
            modal.show();
        }

        function editarEmpresa(id, nombre, ruc, sector, ubicacion, telefono, contactoEmail, descripcion, sitioWeb) {
            document.getElementById('editIdEmpresa').value = id;
            document.getElementById('editNombre').value = nombre;
            document.getElementById('editRuc').value = ruc;
            document.getElementById('editSector').value = sector;
            document.getElementById('editUbicacion').value = ubicacion;
            document.getElementById('editTelefono').value = telefono;
            document.getElementById('editContactoEmail').value = contactoEmail;
            document.getElementById('editDescripcion').value = descripcion;
            document.getElementById('editSitioWeb').value = sitioWeb;
            
            const modal = new bootstrap.Modal(document.getElementById('modalEditarEmpresa'));
            modal.show();
        }

        function eliminarEmpresa(id, nombre) {
            if (confirm('¿Estás seguro de que deseas eliminar la empresa "' + nombre + '"?\n\nEsta acción no se puede deshacer y eliminará también:\n- Todas sus ofertas publicadas\n- Sus postulaciones recibidas\n- Su usuario del sistema')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '<%= request.getContextPath() %>/admin/empresas';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'eliminar';
                
                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'idEmpresa';
                idInput.value = id;
                
                form.appendChild(actionInput);
                form.appendChild(idInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        function validarEmpresa(id, validada) {
            const mensaje = validada ? '¿Verificar esta empresa?' : '¿Remover verificación de esta empresa?';
            
            if (confirm(mensaje)) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '<%= request.getContextPath() %>/admin/empresas';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'validar';
                
                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'idEmpresa';
                idInput.value = id;
                
                const validadaInput = document.createElement('input');
                validadaInput.type = 'hidden';
                validadaInput.name = 'validada';
                validadaInput.value = validada;
                
                form.appendChild(actionInput);
                form.appendChild(idInput);
                form.appendChild(validadaInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        // Validación en tiempo real
        document.addEventListener('DOMContentLoaded', function() {
            const rucInput = document.getElementById('editRuc');
            if (rucInput) {
                rucInput.addEventListener('input', function() {
                    const value = this.value;
                    if (value && value.length !== 11) {
                        this.setCustomValidity('El RUC debe tener 11 dígitos');
                    } else if (value && !/^\d+$/.test(value)) {
                        this.setCustomValidity('El RUC solo debe contener números');
                    } else {
                        this.setCustomValidity('');
                    }
                });
            }

            const telefonoInput = document.getElementById('editTelefono');
            if (telefonoInput) {
                telefonoInput.addEventListener('input', function() {
                    const value = this.value;
                    if (value && (value.length < 7 || value.length > 15)) {
                        this.setCustomValidity('El teléfono debe tener entre 7 y 15 dígitos');
                    } else if (value && !/^[\d\s\-\+\(\)]+$/.test(value)) {
                        this.setCustomValidity('El teléfono contiene caracteres no válidos');
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