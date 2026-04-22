<%-- 
    Document   : estudiantes
    Created on : 9 jul. 2025, 2:24:43 p. m.
    Author     : LENOVO
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Estudiante" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Estudiantes - Panel Administrativo</title>
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

        .student-card {
            background: var(--white);
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            border: 1px solid #e2e8f0;
            transition: all 0.2s ease;
        }

        .student-card:hover {
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transform: translateY(-1px);
        }

        .student-avatar {
            width: 60px;
            height: 60px;
            background: var(--lighter-blue);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: var(--primary-blue);
            font-weight: bold;
        }

        .specialty-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .badge-sistemas {
            background-color: #dbeafe;
            color: #1d4ed8;
        }

        .badge-industrial {
            background-color: #fef3c7;
            color: #d97706;
        }

        .badge-civil {
            background-color: #ecfdf5;
            color: #059669;
        }

        .badge-administracion {
            background-color: #fce7f3;
            color: #be185d;
        }

        .cycle-indicator {
            width: 40px;
            height: 40px;
            background: var(--info);
            color: var(--white);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 0.9rem;
        }

        .grade-bar {
            width: 100%;
            height: 8px;
            background-color: #e5e7eb;
            border-radius: 4px;
            overflow: hidden;
        }

        .grade-fill {
            height: 100%;
            transition: width 0.3s ease;
        }

        .grade-excellent { background-color: var(--success); }
        .grade-good { background-color: var(--warning); }
        .grade-regular { background-color: var(--danger); }

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

        .progress-circle {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 0.8rem;
            margin-left: auto;
        }

        .alert-admin {
            border-radius: 8px;
            border: none;
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
                        <li><a href="<%= request.getContextPath() %>/admin/estudiantes" class="active"><i class="fas fa-user-graduate"></i> Estudiantes</a></li>
                        <li><a href="<%= request.getContextPath() %>/admin/empresas"><i class="fas fa-building"></i> Empresas</a></li>
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
                        <h2><i class="fas fa-user-graduate"></i> Gestión de Estudiantes</h2>
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
                                <div class="stat-number"><%= request.getAttribute("totalEstudiantes") %></div>
                                <div class="stat-label">Total Estudiantes</div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="stats-card">
                                <div class="stat-number"><%= request.getAttribute("estudiantesActivos") %></div>
                                <div class="stat-label">Activos (8vo+)</div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="stats-card">
                                <div class="stat-number"><%= request.getAttribute("sistemas") %></div>
                                <div class="stat-label">Sistemas</div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="stats-card">
                                <div class="stat-number"><%= request.getAttribute("industrial") %></div>
                                <div class="stat-label">Industrial</div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="stats-card">
                                <div class="stat-number"><%= request.getAttribute("civil") %></div>
                                <div class="stat-label">Civil</div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="stats-card">
                                <div class="stat-number"><%= request.getAttribute("promedioGeneral") %></div>
                                <div class="stat-label">Promedio General</div>
                            </div>
                        </div>
                    </div>

                    <!-- Filtros -->
                    <div class="filter-section">
                        <form method="GET" action="<%= request.getContextPath() %>/admin/estudiantes">
                            <div class="row">
                                <div class="col-md-3">
                                    <label class="form-label"><strong>Buscar:</strong></label>
                                    <input type="text" class="form-control" name="busqueda" 
                                           value="<%= request.getAttribute("busqueda") != null ? request.getAttribute("busqueda") : "" %>"
                                           placeholder="Nombre, código o email...">
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label"><strong>Especialidad:</strong></label>
                                    <select class="form-control" name="especialidad">
                                        <option value="todas">Todas las especialidades</option>
                                        <option value="Ingeniería de Sistemas" <%= "Ingeniería de Sistemas".equals(request.getAttribute("filtroEspecialidad")) ? "selected" : "" %>>Ingeniería de Sistemas</option>
                                        <option value="Ingeniería Industrial" <%= "Ingeniería Industrial".equals(request.getAttribute("filtroEspecialidad")) ? "selected" : "" %>>Ingeniería Industrial</option>
                                        <option value="Ingeniería Civil" <%= "Ingeniería Civil".equals(request.getAttribute("filtroEspecialidad")) ? "selected" : "" %>>Ingeniería Civil</option>
                                        <option value="Administración" <%= "Administración".equals(request.getAttribute("filtroEspecialidad")) ? "selected" : "" %>>Administración</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label"><strong>Ciclo:</strong></label>
                                    <select class="form-control" name="ciclo">
                                        <option value="todos">Todos los ciclos</option>
                                        <% for (int i = 1; i <= 10; i++) { %>
                                            <option value="<%= i %>" <%= String.valueOf(i).equals(request.getAttribute("filtroCiclo")) ? "selected" : "" %>><%= i %>° Ciclo</option>
                                        <% } %>
                                    </select>
                                </div>
                                <div class="col-md-4 d-flex align-items-end">
                                    <button type="submit" class="btn btn-admin me-2">
                                        <i class="fas fa-search"></i> Filtrar
                                    </button>
                                    <a href="<%= request.getContextPath() %>/admin/estudiantes" class="btn btn-outline-secondary">
                                        <i class="fas fa-times"></i> Limpiar
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>

                    <!-- Lista de Estudiantes -->
                    <div class="content-card">
                        <%
                            List<Estudiante> estudiantes = (List<Estudiante>) request.getAttribute("estudiantes");
                            
                            if (estudiantes != null && !estudiantes.isEmpty()) {
                                for (Estudiante estudiante : estudiantes) {
                                    String badgeClass = "";
                                    switch (estudiante.getEspecialidad()) {
                                        case "Ingeniería de Sistemas":
                                            badgeClass = "badge-sistemas";
                                            break;
                                        case "Ingeniería Industrial":
                                            badgeClass = "badge-industrial";
                                            break;
                                        case "Ingeniería Civil":
                                            badgeClass = "badge-civil";
                                            break;
                                        case "Administración":
                                            badgeClass = "badge-administracion";
                                            break;
                                    }
                                    
                                    double promedio = estudiante.getPromedioPonderado();
                                    String gradeClass = "";
                                    String gradeText = "";
                                    if (promedio >= 16) {
                                        gradeClass = "grade-excellent";
                                        gradeText = "Excelente";
                                    } else if (promedio >= 11) {
                                        gradeClass = "grade-regular";
                                        gradeText = "Regular";
                                    } else {
                                        gradeClass = "grade-regular";
                                        gradeText = "Bajo";
                                    }
                                    
                                    int promedioPercentage = (int) ((promedio / 20.0) * 100);
                        %>
                        <div class="student-card">
                            <div class="row align-items-center">
                                <div class="col-md-1">
                                    <div class="student-avatar">
                                        <%= (estudiante.getNombres() != null ? estudiante.getNombres().substring(0, 1) : "?") + 
                                            (estudiante.getApellidos() != null ? estudiante.getApellidos().substring(0, 1) : "?") %>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <h6 class="mb-1"><%= estudiante.getNombres() %> <%= estudiante.getApellidos() %></h6>
                                    <small class="text-muted">
                                        <i class="fas fa-id-card"></i> <%= estudiante.getCodigoUniversitario() != null ? estudiante.getCodigoUniversitario() : "N/A" %>
                                    </small><br>
                                    <small class="text-muted">
                                        <i class="fas fa-envelope"></i> <%= estudiante.getEmail() != null ? estudiante.getEmail() : "N/A" %>
                                    </small>
                                </div>
                                <div class="col-md-2">
                                    <span class="specialty-badge <%= badgeClass %>">
                                        <%= estudiante.getEspecialidad() != null ? estudiante.getEspecialidad().replace("Ingeniería de ", "") : "N/A" %>
                                    </span>
                                </div>
                                <div class="col-md-1 text-center">
                                    <div class="cycle-indicator">
                                        <%= estudiante.getCiclo() %>°
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <small class="text-muted">Promedio: <strong><%= String.format("%.1f", promedio) %></strong></small>
                                    <div class="grade-bar">
                                        <div class="grade-fill <%= gradeClass %>" style="width: <%= promedioPercentage %>%"></div>
                                    </div>
                                    <small class="text-muted"><%= gradeText %></small>
                                </div>
                                <div class="col-md-1">
                                    <% if (estudiante.getTelefono() != null && !estudiante.getTelefono().isEmpty()) { %>
                                        <i class="fas fa-phone text-success" title="Tiene teléfono"></i>
                                    <% } else { %>
                                        <i class="fas fa-phone text-muted" title="Sin teléfono"></i>
                                    <% } %>
                                    <% if (estudiante.getDni() != null && !estudiante.getDni().isEmpty()) { %>
                                        <i class="fas fa-id-card text-success ms-1" title="Tiene DNI"></i>
                                    <% } else { %>
                                        <i class="fas fa-id-card text-muted ms-1" title="Sin DNI"></i>
                                    <% } %>
                                </div>
                                <div class="col-md-2 text-end">
                                    <button class="btn btn-view me-1" 
                                            onclick="verDetalles(<%= estudiante.getIdEstudiante() %>)">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button class="btn btn-edit me-1" 
                                            onclick="editarEstudiante(<%= estudiante.getIdEstudiante() %>, '<%= estudiante.getNombres() %>', '<%= estudiante.getApellidos() %>', '<%= estudiante.getEmail() != null ? estudiante.getEmail() : "" %>', '<%= estudiante.getTelefono() != null ? estudiante.getTelefono() : "" %>', '<%= estudiante.getEspecialidad() %>', <%= estudiante.getCiclo() %>, <%= estudiante.getPromedioPonderado() %>, '<%= estudiante.getDni() != null ? estudiante.getDni() : "" %>', '<%= estudiante.getCodigoUniversitario() != null ? estudiante.getCodigoUniversitario() : "" %>')">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-delete" 
                                            onclick="eliminarEstudiante(<%= estudiante.getIdEstudiante() %>, '<%= estudiante.getNombres() %> <%= estudiante.getApellidos() %>')">
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
                            <i class="fas fa-user-graduate fa-5x text-muted mb-3"></i>
                            <h4 class="text-muted">No se encontraron estudiantes</h4>
                            <p class="text-muted">No hay estudiantes que coincidan con los filtros seleccionados.</p>
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
                    <h5 class="modal-title">Detalles del Estudiante</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <h6>Información Personal</h6>
                            <p><strong>Nombres:</strong> <span id="detNombres"></span></p>
                            <p><strong>Apellidos:</strong> <span id="detApellidos"></span></p>
                            <p><strong>DNI:</strong> <span id="detDni"></span></p>
                            <p><strong>Teléfono:</strong> <span id="detTelefono"></span></p>
                            <p><strong>Email:</strong> <span id="detEmail"></span></p>
                        </div>
                        <div class="col-md-6">
                            <h6>Información Académica</h6>
                            <p><strong>Código Universitario:</strong> <span id="detCodigo"></span></p>
                            <p><strong>Especialidad:</strong> <span id="detEspecialidad"></span></p>
                            <p><strong>Ciclo Actual:</strong> <span id="detCiclo"></span></p>
                            <p><strong>Promedio Ponderado:</strong> <span id="detPromedio"></span></p>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-md-12">
                            <h6>Historial de Prácticas</h6>
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

    <!-- Modal Editar Estudiante -->
    <div class="modal fade" id="modalEditarEstudiante" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Editar Estudiante</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form method="POST" action="<%= request.getContextPath() %>/admin/estudiantes">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="editar">
                        <input type="hidden" name="idEstudiante" id="editIdEstudiante">
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Nombres:</label>
                                    <input type="text" class="form-control" name="nombres" id="editNombres" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Apellidos:</label>
                                    <input type="text" class="form-control" name="apellidos" id="editApellidos" required>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Email:</label>
                                    <input type="email" class="form-control" name="email" id="editEmail" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Teléfono:</label>
                                    <input type="text" class="form-control" name="telefono" id="editTelefono">
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">DNI:</label>
                                    <input type="text" class="form-control" name="dni" id="editDni">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Código Universitario:</label>
                                    <input type="text" class="form-control" name="codigoUniversitario" id="editCodigoUniversitario">
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label">Especialidad:</label>
                                    <select class="form-control" name="especialidad" id="editEspecialidad" required>
                                        <option value="Ingeniería de Sistemas">Ingeniería de Sistemas</option>
                                        <option value="Ingeniería Industrial">Ingeniería Industrial</option>
                                        <option value="Ingeniería Civil">Ingeniería Civil</option>
                                        <option value="Administración">Administración</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label">Ciclo:</label>
                                    <select class="form-control" name="ciclo" id="editCiclo" required>
                                        <% for (int i = 1; i <= 10; i++) { %>
                                            <option value="<%= i %>"><%= i %>° Ciclo</option>
                                        <% } %>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label">Promedio:</label>
                                    <input type="number" class="form-control" name="promedio" id="editPromedio" step="0.1" min="0" max="20">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-admin">Actualizar Estudiante</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function verDetalles(id) {
            // Aquí cargarías los detalles del estudiante por AJAX
            // Por ahora solo muestro el modal
            const modal = new bootstrap.Modal(document.getElementById('modalDetalles'));
            modal.show();
        }

        function editarEstudiante(id, nombres, apellidos, email, telefono, especialidad, ciclo, promedio, dni, codigo) {
            document.getElementById('editIdEstudiante').value = id;
            document.getElementById('editNombres').value = nombres;
            document.getElementById('editApellidos').value = apellidos;
            document.getElementById('editEmail').value = email;
            document.getElementById('editTelefono').value = telefono;
            document.getElementById('editEspecialidad').value = especialidad;
            document.getElementById('editCiclo').value = ciclo;
            document.getElementById('editPromedio').value = promedio;
            document.getElementById('editDni').value = dni;
            document.getElementById('editCodigoUniversitario').value = codigo;
            
            const modal = new bootstrap.Modal(document.getElementById('modalEditarEstudiante'));
            modal.show();
        }

        function eliminarEstudiante(id, nombre) {
            if (confirm('¿Estás seguro de que deseas eliminar al estudiante "' + nombre + '"?\n\nEsta acción no se puede deshacer y eliminará también:\n- Su usuario del sistema\n- Su historial de postulaciones\n- Sus prácticas registradas')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '<%= request.getContextPath() %>/admin/estudiantes';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'eliminar';
                
                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'idEstudiante';
                idInput.value = id;
                
                form.appendChild(actionInput);
                form.appendChild(idInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        // Validación en tiempo real
        document.addEventListener('DOMContentLoaded', function() {
            const promedioInput = document.getElementById('editPromedio');
            if (promedioInput) {
                promedioInput.addEventListener('input', function() {
                    const value = parseFloat(this.value);
                    if (value > 20) {
                        this.setCustomValidity('El promedio no puede ser mayor a 20');
                    } else if (value < 0) {
                        this.setCustomValidity('El promedio no puede ser negativo');
                    } else {
                        this.setCustomValidity('');
                    }
                });
            }

            const dniInput = document.getElementById('editDni');
            if (dniInput) {
                dniInput.addEventListener('input', function() {
                    const value = this.value;
                    if (value && value.length !== 8) {
                        this.setCustomValidity('El DNI debe tener 8 dígitos');
                    } else if (value && !/^\d+$/.test(value)) {
                        this.setCustomValidity('El DNI solo debe contener números');
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