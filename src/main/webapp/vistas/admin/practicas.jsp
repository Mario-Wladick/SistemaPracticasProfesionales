<%-- 
    Document   : practicas
    Created on : 9 jul. 2025, 3:08:33 p. m.
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Practica" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Prácticas - Panel Administrativo</title>
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

        .practice-card {
            background: var(--white);
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            border: 1px solid #e2e8f0;
            transition: all 0.2s ease;
            border-left: 4px solid var(--info);
        }

        .practice-card:hover {
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transform: translateY(-1px);
        }

        .practice-card.en_curso {
            border-left-color: var(--info);
        }

        .practice-card.completada {
            border-left-color: var(--success);
        }

        .practice-card.cancelada {
            border-left-color: var(--danger);
        }

        .practice-icon {
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

        .status-en_curso {
            background-color: #cce8f4;
            color: #0c5460;
        }

        .status-completada {
            background-color: #dcfce7;
            color: #166534;
        }

        .status-cancelada {
            background-color: #fee2e2;
            color: #dc2626;
        }

        .practice-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--text-color);
            margin-bottom: 0.5rem;
        }

        .practice-detail {
            font-size: 0.85rem;
            color: var(--gray-medium);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 0.25rem;
        }

        .progress-bar {
            height: 8px;
            border-radius: 4px;
            background-color: #e9ecef;
            overflow: hidden;
            margin: 0.5rem 0;
        }

        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, #4facfe 0%, #00f2fe 100%);
            transition: width 0.3s ease;
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

        .btn-complete {
            background-color: var(--success);
            color: var(--white);
            border: none;
            border-radius: 6px;
            padding: 0.25rem 0.5rem;
            font-size: 0.8rem;
        }

        .btn-cancel {
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

        .alert-admin {
            border-radius: 8px;
            border: none;
        }

        .grade-circle {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            margin-left: auto;
        }

        .grade-excellent {
            background-color: #dcfce7;
            color: #166534;
        }

        .grade-good {
            background-color: #fef3c7;
            color: #92400e;
        }

        .grade-regular {
            background-color: #fee2e2;
            color: #dc2626;
        }

        .supervisor-info {
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
                        <li><a href="<%= request.getContextPath() %>/admin/empresas"><i class="fas fa-building"></i> Empresas</a></li>
                        <li><a href="<%= request.getContextPath() %>/admin/ofertas"><i class="fas fa-briefcase"></i> Ofertas</a></li>
                        <li><a href="<%= request.getContextPath() %>/admin/practicas" class="active"><i class="fas fa-clipboard-list"></i> Prácticas</a></li>
                        <li><a href="<%= request.getContextPath() %>/admin/reportes"><i class="fas fa-chart-bar"></i> Reportes</a></li>
                    </ul>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-10">
                <div class="main-content">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h2><i class="fas fa-clipboard-list"></i> Gestión de Prácticas</h2>
                        <div>
                            <button class="btn btn-admin me-2">
                                <i class="fas fa-download"></i> Exportar Excel
                            </button>
                            <button class="btn btn-admin">
                                <i class="fas fa-chart-line"></i> Ver Reportes
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
                                <div class="stat-number"><%= request.getAttribute("totalPracticas") %></div>
                                <div class="stat-label">Total Prácticas</div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="stats-card">
                                <div class="stat-number"><%= request.getAttribute("practicasEnCurso") %></div>
                                <div class="stat-label">En Curso</div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="stats-card">
                                <div class="stat-number"><%= request.getAttribute("practicasCompletadas") %></div>
                                <div class="stat-label">Completadas</div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="stats-card">
                                <div class="stat-number"><%= request.getAttribute("practicasCanceladas") %></div>
                                <div class="stat-label">Canceladas</div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="stats-card">
                                <div class="stat-number"><%= request.getAttribute("promedioHoras") %></div>
                                <div class="stat-label">Promedio Horas</div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="stats-card">
                                <div class="stat-number"><%= request.getAttribute("promedioCalificaciones") %></div>
                                <div class="stat-label">Promedio Calif.</div>
                            </div>
                        </div>
                    </div>

                    <!-- Filtros -->
                    <div class="filter-section">
                        <form method="GET" action="<%= request.getContextPath() %>/admin/practicas">
                            <div class="row">
                                <div class="col-md-4">
                                    <label class="form-label"><strong>Buscar:</strong></label>
                                    <input type="text" class="form-control" name="busqueda" 
                                           value="<%= request.getAttribute("busqueda") != null ? request.getAttribute("busqueda") : "" %>"
                                           placeholder="ID de práctica o postulación...">
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label"><strong>Estado:</strong></label>
                                    <select class="form-control" name="estado">
                                        <option value="todas">Todos los estados</option>
                                        <option value="en_curso" <%= "en_curso".equals(request.getAttribute("filtroEstado")) ? "selected" : "" %>>En Curso</option>
                                        <option value="completada" <%= "completada".equals(request.getAttribute("filtroEstado")) ? "selected" : "" %>>Completada</option>
                                        <option value="cancelada" <%= "cancelada".equals(request.getAttribute("filtroEstado")) ? "selected" : "" %>>Cancelada</option>
                                    </select>
                                </div>
                                <div class="col-md-5 d-flex align-items-end">
                                    <button type="submit" class="btn btn-admin me-2">
                                        <i class="fas fa-search"></i> Filtrar
                                    </button>
                                    <a href="<%= request.getContextPath() %>/admin/practicas" class="btn btn-outline-secondary">
                                        <i class="fas fa-times"></i> Limpiar
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>

                    <!-- Lista de Prácticas -->
                    <div class="content-card">
                        <%
                            List<Practica> practicas = (List<Practica>) request.getAttribute("practicas");
                            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                            
                            if (practicas != null && !practicas.isEmpty()) {
                                for (Practica practica : practicas) {
                                    String statusClass = "status-" + (practica.getEstado() != null ? practica.getEstado() : "en_curso");
                                    String cardClass = "practice-card " + (practica.getEstado() != null ? practica.getEstado() : "en_curso");
                                    
                                    // Calcular progreso de horas
                                    double progreso = 0;
                                    if (practica.getHorasRequeridas() > 0) {
                                        progreso = (double) practica.getHorasCompletadas() / practica.getHorasRequeridas() * 100;
                                    }
                                    
                                    // Determinar clase de calificación
                                    String gradeClass = "";
                                    if (practica.getCalificacionFinal() >= 16) {
                                        gradeClass = "grade-excellent";
                                    } else {
                                        gradeClass = "grade-regular";
                                    }
                        %>
                        <div class="<%= cardClass %>">
                            <div class="row align-items-center">
                                <div class="col-md-1">
                                    <div class="practice-icon">
                                        <i class="fas fa-clipboard-list"></i>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="practice-title">Práctica #<%= practica.getId() %></div>
                                    <div class="practice-detail">
                                        <i class="fas fa-user-graduate"></i>
                                        <span>Postulación ID: <%= practica.getPostulacionId() %></span>
                                    </div>
                                    <div class="practice-detail">
                                        <i class="fas fa-user-tie"></i>
                                        <span>Supervisor ID: <%= practica.getSupervisorId() > 0 ? practica.getSupervisorId() : "No asignado" %></span>
                                    </div>
                                    <div class="d-flex gap-2 align-items-center mt-2">
                                        <span class="status-badge <%= statusClass %>">
                                            <%= practica.getEstado() != null ? practica.getEstado().replace("_", " ").toUpperCase() : "EN CURSO" %>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="practice-detail">
                                        <i class="fas fa-calendar-start"></i>
                                        <span>Inicio: <%= practica.getFechaInicio() != null ? sdf.format(practica.getFechaInicio()) : "N/A" %></span>
                                    </div>
                                    <div class="practice-detail">
                                        <i class="fas fa-calendar-end"></i>
                                        <span>Fin: <%= practica.getFechaFin() != null ? sdf.format(practica.getFechaFin()) : "N/A" %></span>
                                    </div>
                                    <div class="progress-bar">
                                        <div class="progress-fill" style="width: <%= progreso %>%"></div>
                                    </div>
                                    <div class="practice-detail">
                                        <i class="fas fa-clock"></i>
                                        <span><%= practica.getHorasCompletadas() %>/<%= practica.getHorasRequeridas() %> horas (<%= String.format("%.0f", progreso) %>%)</span>
                                    </div>
                                </div>
                                <div class="col-md-2 text-center">
                                    <% if (practica.getCalificacionFinal() > 0) { %>
                                    <div class="grade-circle <%= gradeClass %>">
                                        <%= String.format("%.1f", practica.getCalificacionFinal()) %>
                                    </div>
                                    <small class="text-muted">Calificación</small>
                                    <% } else { %>
                                    <div class="text-muted">
                                        <i class="fas fa-hourglass-half fa-2x"></i><br>
                                        <small>Sin calificar</small>
                                    </div>
                                    <% } %>
                                </div>
                                <div class="col-md-2 text-end">
                                    <button class="btn btn-view me-1" 
                                            onclick="verDetalles(<%= practica.getId() %>)">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <% if ("en_curso".equals(practica.getEstado())) { %>
                                    <button class="btn btn-edit me-1" 
                                            onclick="editarHoras(<%= practica.getId() %>, <%= practica.getHorasCompletadas() %>, <%= practica.getHorasRequeridas() %>)">
                                        <i class="fas fa-clock"></i>
                                    </button>
                                    <br class="my-1">
                                    <button class="btn btn-complete me-1" 
                                            onclick="finalizarPractica(<%= practica.getId() %>)">
                                        <i class="fas fa-check"></i>
                                    </button>
                                    <button class="btn btn-cancel" 
                                            onclick="cancelarPractica(<%= practica.getId() %>)">
                                        <i class="fas fa-times"></i>
                                    </button>
                                    <% } else if ("completada".equals(practica.getEstado())) { %>
                                    <div class="text-success text-center">
                                        <i class="fas fa-medal fa-2x"></i><br>
                                        <small>Completada</small>
                                    </div>
                                    <% } else if ("cancelada".equals(practica.getEstado())) { %>
                                    <div class="text-danger text-center">
                                        <i class="fas fa-ban fa-2x"></i><br>
                                        <small>Cancelada</small>
                                    </div>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                        <%
                                }
                            } else {
                        %>
                        <div class="text-center py-5">
                            <i class="fas fa-clipboard-list fa-5x text-muted mb-3"></i>
                            <h4 class="text-muted">No se encontraron prácticas</h4>
                            <p class="text-muted">No hay prácticas que coincidan con los filtros seleccionados.</p>
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
                    <h5 class="modal-title">Detalles de la Práctica</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <h6>Información General</h6>
                            <p><strong>ID Práctica:</strong> <span id="detId"></span></p>
                            <p><strong>Estado:</strong> <span id="detEstado"></span></p>
                            <p><strong>ID Postulación:</strong> <span id="detPostulacion"></span></p>
                            <p><strong>Supervisor:</strong> <span id="detSupervisor"></span></p>
                        </div>
                        <div class="col-md-6">
                            <h6>Fechas y Progreso</h6>
                            <p><strong>Fecha Inicio:</strong> <span id="detFechaInicio"></span></p>
                            <p><strong>Fecha Fin:</strong> <span id="detFechaFin"></span></p>
                            <p><strong>Horas Completadas:</strong> <span id="detHoras"></span></p>
                            <p><strong>Calificación:</strong> <span id="detCalificacion"></span></p>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-md-12">
                            <h6>Historial de Actividades</h6>
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

    <!-- Modal Editar Horas -->
    <div class="modal fade" id="modalEditarHoras" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Actualizar Horas de Práctica</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form method="POST" action="<%= request.getContextPath() %>/admin/practicas">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="actualizar_horas">
                        <input type="hidden" name="idPractica" id="editIdPractica">
                        
                        <div class="mb-3">
                            <label class="form-label">Horas Completadas:</label>
                            <input type="number" class="form-control" name="horasCompletadas" id="editHorasCompletadas" min="0" required>
                            <div class="form-text">
                                Máximo: <span id="maxHoras"></span> horas
                            </div>
                        </div>
                        
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle"></i>
                            Si las horas completadas alcanzan el total requerido, la práctica se marcará automáticamente como completada.
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-admin">Actualizar Horas</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal Finalizar Práctica -->
    <div class="modal fade" id="modalFinalizar" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Finalizar Práctica</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form method="POST" action="<%= request.getContextPath() %>/admin/practicas">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="finalizar">
                        <input type="hidden" name="idPractica" id="finalizarIdPractica">
                        
                        <div class="alert alert-warning">
                            <i class="fas fa-exclamation-triangle"></i>
                            <strong>¿Finalizar práctica?</strong><br>
                            Esta acción marcará la práctica como completada.
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Calificación Final (0-20):</label>
                            <input type="number" class="form-control" name="calificacion" step="0.1" min="0" max="20" required>
                            <div class="form-text">
                                Ingresa la calificación final de la práctica.
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-success">Finalizar Práctica</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function verDetalles(id) {
            // Aquí cargarías los detalles de la práctica por AJAX
            const modal = new bootstrap.Modal(document.getElementById('modalDetalles'));
            modal.show();
        }

        function editarHoras(id, horasActuales, horasRequeridas) {
            document.getElementById('editIdPractica').value = id;
            document.getElementById('editHorasCompletadas').value = horasActuales;
            document.getElementById('editHorasCompletadas').max = horasRequeridas;
            document.getElementById('maxHoras').textContent = horasRequeridas;
            
            const modal = new bootstrap.Modal(document.getElementById('modalEditarHoras'));
            modal.show();
        }

        function finalizarPractica(id) {
            document.getElementById('finalizarIdPractica').value = id;
            const modal = new bootstrap.Modal(document.getElementById('modalFinalizar'));
            modal.show();
        }

        function cancelarPractica(id) {
            if (confirm('¿Estás seguro de que deseas cancelar esta práctica?\n\nEsta acción no se puede deshacer.')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '<%= request.getContextPath() %>/admin/practicas';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'cambiar_estado';
                
                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'idPractica';
                idInput.value = id;
                
                const estadoInput = document.createElement('input');
                estadoInput.type = 'hidden';
                estadoInput.name = 'estado';
                estadoInput.value = 'cancelada';
                
                form.appendChild(actionInput);
                form.appendChild(idInput);
                form.appendChild(estadoInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        // Validación en tiempo real
        document.addEventListener('DOMContentLoaded', function() {
            const horasInput = document.getElementById('editHorasCompletadas');
            if (horasInput) {
                horasInput.addEventListener('input', function() {
                    const valor = parseInt(this.value);
                    const maximo = parseInt(this.max);
                    
                    if (valor > maximo) {
                        this.setCustomValidity('Las horas no pueden exceder el máximo requerido');
                    } else if (valor < 0) {
                        this.setCustomValidity('Las horas no pueden ser negativas');
                    } else {
                        this.setCustomValidity('');
                    }
                });
            }

            const calificacionInput = document.querySelector('input[name="calificacion"]');
            if (calificacionInput) {
                calificacionInput.addEventListener('input', function() {
                    const valor = parseFloat(this.value);
                    
                    if (valor > 20) {
                        this.setCustomValidity('La calificación no puede ser mayor a 20');
                    } else if (valor < 0) {
                        this.setCustomValidity('La calificación no puede ser negativa');
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