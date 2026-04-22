<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Empresa" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Empresa - Sistema de Prácticas</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
    .dashboard-card {
        transition: transform 0.2s;
        border: none;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.2);
    }
    .dashboard-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(0,0,0,0.12);
    }
    
    /* Tarjetas de estadísticas transparentes */
    .stat-card {
        background: rgba(255, 255, 255, 0.9);
        color: #374151;
        border-radius: 15px;
        border: 1px solid rgba(59, 130, 246, 0.2);
        backdrop-filter: blur(10px);
        transition: all 0.3s ease;
    }
    .stat-card:hover {
        background: rgba(255, 255, 255, 0.95);
        border-color: rgba(59, 130, 246, 0.4);
        transform: translateY(-3px);
        box-shadow: 0 10px 30px rgba(59, 130, 246, 0.15);
    }
    
    /* Iconos con colores específicos */
    .stat-card .fa-briefcase {
        color: #3b82f6; /* Azul */
    }
    .stat-card .fa-eye {
        color: #10b981; /* Verde */
    }
    .stat-card .fa-users {
        color: #f59e0b; /* Amarillo/Naranja */
    }
    .stat-card .fa-clock {
        color: #06b6d4; /* Celeste */
    }
    
    /* Diferentes estilos para cada tarjeta */
    .stat-card.ofertas {
        border-left: 4px solid #3b82f6;
    }
    .stat-card.success {
        border-left: 4px solid #10b981;
    }
    .stat-card.warning {
        border-left: 4px solid #f59e0b;
    }
    .stat-card.info {
        border-left: 4px solid #06b6d4;
    }
    
    /* Fondo general más suave */
    body.bg-light {
        background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
        min-height: 100vh;
    }
    
    /* Navbar con transparencia */
    .navbar.bg-primary {
        background: rgba(37, 99, 235, 0.95) !important;
        backdrop-filter: blur(10px);
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }
    
    /* Cards del menú lateral */
    .card-header.bg-primary {
        background: rgba(37, 99, 235, 0.9) !important;
        border-bottom: 1px solid rgba(255, 255, 255, 0.2);
    }
    
    .card-header.bg-success {
        background: rgba(16, 185, 129, 0.9) !important;
        border-bottom: 1px solid rgba(255, 255, 255, 0.2);
    }
    
    .card-header.bg-info {
        background: rgba(6, 182, 212, 0.9) !important;
        border-bottom: 1px solid rgba(255, 255, 255, 0.2);
    }
    
    /* Alertas transparentes */
    .alert {
        background: rgba(255, 255, 255, 0.9);
        border: 1px solid rgba(0, 0, 0, 0.1);
        backdrop-filter: blur(5px);
        border-radius: 10px;
    }
    
    .alert-success {
        background: rgba(219, 234, 254, 0.8);
        border-color: rgba(16, 185, 129, 0.3);
        color: #065f46;
    }
    
    .alert-warning {
        background: rgba(254, 243, 199, 0.8);
        border-color: rgba(245, 158, 11, 0.3);
        color: #92400e;
    }
    
    .alert-danger {
        background: rgba(254, 226, 226, 0.8);
        border-color: rgba(239, 68, 68, 0.3);
        color: #991b1b;
    }
    
    /* Botones de acciones rápidas más suaves */
    .btn-primary {
        background: rgba(59, 130, 246, 0.9);
        border-color: rgba(59, 130, 246, 0.9);
    }
    
    .btn-info {
        background: rgba(6, 182, 212, 0.9);
        border-color: rgba(6, 182, 212, 0.9);
    }
    
    .btn-warning {
        background: rgba(245, 158, 11, 0.9);
        border-color: rgba(245, 158, 11, 0.9);
    }
    
    .btn-success {
        background: rgba(16, 185, 129, 0.9);
        border-color: rgba(16, 185, 129, 0.9);
    }
</style>
</head>
<body class="bg-light">
    <%
        Empresa empresa = (Empresa) request.getAttribute("empresa");
        Integer totalOfertas = (Integer) request.getAttribute("totalOfertas");
        Integer ofertasActivas = (Integer) request.getAttribute("ofertasActivas");
        Integer totalPostulaciones = (Integer) request.getAttribute("totalPostulaciones");
        Integer postulacionesPendientes = (Integer) request.getAttribute("postulacionesPendientes");
        Integer postulacionesAceptadas = (Integer) request.getAttribute("postulacionesAceptadas");
        Integer postulacionesRechazadas = (Integer) request.getAttribute("postulacionesRechazadas");
        Boolean necesitaAtencion = (Boolean) request.getAttribute("necesitaAtencion");
        String error = (String) request.getAttribute("error");
    %>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="<%= request.getContextPath() %>/empresa/dashboard">
                <i class="fas fa-building"></i> 
                <% if (empresa != null) { %>
                    <%= empresa.getRazonSocial() %>
                <% } else { %>
                    Panel de Empresa
                <% } %>
            </a>
            
            <div class="navbar-nav ml-auto">
                <div class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-white" href="#" role="button" data-toggle="dropdown">
                        <i class="fas fa-user-tie"></i> Empresa
                    </a>
                    <div class="dropdown-menu dropdown-menu-right">
                        <a class="dropdown-item" href="<%= request.getContextPath() %>/">
                            <i class="fas fa-home"></i> Inicio
                        </a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="<%= request.getContextPath() %>/logout">
                            <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <div class="container-fluid mt-4">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 mb-4">
                <div class="card dashboard-card">
                    <div class="card-header bg-primary text-white">
                        <h6 class="mb-0"><i class="fas fa-list"></i> Menú Empresa</h6>
                    </div>
                    <div class="list-group list-group-flush">
                        <a href="<%= request.getContextPath() %>/empresa/dashboard" class="list-group-item list-group-item-action active">
                            <i class="fas fa-tachometer-alt"></i> Dashboard
                        </a>
                        <a href="<%= request.getContextPath() %>/empresa/ofertas" class="list-group-item list-group-item-action">
                            <i class="fas fa-briefcase"></i> Mis Ofertas
                        </a>
                        <a href="<%= request.getContextPath() %>/empresa/postulantes" class="list-group-item list-group-item-action">
                            <i class="fas fa-users"></i> Postulantes
                        </a>
                        <a href="<%= request.getContextPath() %>/empresa/nueva-oferta" class="list-group-item list-group-item-action">
                            <i class="fas fa-plus"></i> Nueva Oferta
                        </a>
                        <a href="<%= request.getContextPath() %>/empresa/reportes" class="list-group-item list-group-item-action">
                            <i class="fas fa-chart-bar"></i> Reportes
                        </a>
                    </div>
                </div>
            </div>

            <!-- Contenido Principal -->
            <div class="col-md-9 col-lg-10">
                <!-- Título -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-building text-primary"></i> Dashboard de Empresa</h2>
                    <div class="text-muted">
                        <i class="fas fa-calendar"></i> 
                        <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(new java.util.Date()) %>
                    </div>
                </div>

                <!-- Mensaje de bienvenida -->
                <% if (empresa != null) { %>
                    <div class="alert alert-success">
                        <i class="fas fa-building"></i> 
                        ¡Bienvenido <strong><%= empresa.getRazonSocial() %></strong>!
                    </div>
                <% } %>

                <!-- Alertas de error -->
                <% if (error != null) { %>
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-triangle"></i> <%= error %>
                    </div>
                <% } %>

                <!-- Alerta de atención -->
                <% if (necesitaAtencion != null && necesitaAtencion) { %>
                    <div class="alert alert-warning">
                        <i class="fas fa-bell"></i> 
                        <strong>¡Atención!</strong> Tienes <%= postulacionesPendientes != null ? postulacionesPendientes : 0 %> postulaciones pendientes de revisión.
                    </div>
                <% } %>

                <!-- Tarjetas de estadísticas -->
                <div class="row mb-4">
                    <div class="col-xl-3 col-md-6 mb-3">
                        <div class="card dashboard-card stat-card">
                            <div class="card-body text-center">
                                <i class="fas fa-briefcase fa-2x mb-2"></i>
                                <h3 class="mb-0"><%= totalOfertas != null ? totalOfertas : 0 %></h3>
                                <p class="mb-0">Ofertas Totales</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-xl-3 col-md-6 mb-3">
                        <div class="card dashboard-card stat-card success">
                            <div class="card-body text-center">
                                <i class="fas fa-eye fa-2x mb-2"></i>
                                <h3 class="mb-0"><%= ofertasActivas != null ? ofertasActivas : 0 %></h3>
                                <p class="mb-0">Ofertas Activas</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-xl-3 col-md-6 mb-3">
                        <div class="card dashboard-card stat-card warning">
                            <div class="card-body text-center">
                                <i class="fas fa-users fa-2x mb-2"></i>
                                <h3 class="mb-0"><%= totalPostulaciones != null ? totalPostulaciones : 0 %></h3>
                                <p class="mb-0">Total Postulaciones</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-xl-3 col-md-6 mb-3">
                        <div class="card dashboard-card stat-card info">
                            <div class="card-body text-center">
                                <i class="fas fa-clock fa-2x mb-2"></i>
                                <h3 class="mb-0"><%= postulacionesPendientes != null ? postulacionesPendientes : 0 %></h3>
                                <p class="mb-0">Pendientes</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Contenido principal -->
                <div class="row">
                    <div class="col-lg-8 mb-4">
                        <div class="card dashboard-card">
                            <div class="card-header bg-primary text-white">
                                <h5 class="mb-0">
                                    <i class="fas fa-user-graduate"></i> Gestión de Postulantes
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="text-center py-4">
                                    <i class="fas fa-users fa-3x text-muted mb-3"></i>
                                    <h5>Panel de Postulantes</h5>
                                    <p class="text-muted">Aquí podrás ver y gestionar todas las postulaciones a tus ofertas.</p>
                                    <div class="row text-center">
                                        <div class="col-4">
                                            <div class="border rounded p-3">
                                                <h4 class="text-warning"><%= postulacionesPendientes != null ? postulacionesPendientes : 0 %></h4>
                                                <small>Pendientes</small>
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div class="border rounded p-3">
                                                <h4 class="text-success"><%= postulacionesAceptadas != null ? postulacionesAceptadas : 0 %></h4>
                                                <small>Aceptadas</small>
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div class="border rounded p-3">
                                                <h4 class="text-danger"><%= postulacionesRechazadas != null ? postulacionesRechazadas : 0 %></h4>
                                                <small>Rechazadas</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Acciones Rápidas -->
                    <div class="col-lg-4 mb-4">
                        <div class="card dashboard-card">
                            <div class="card-header bg-success text-white">
                                <h6 class="mb-0"><i class="fas fa-bolt"></i> Acciones Rápidas</h6>
                            </div>
                            <div class="card-body">
                                <div class="d-grid gap-2">
                                    <a href="<%= request.getContextPath() %>/empresa/nueva-oferta" class="btn btn-primary btn-block mb-2">
                                        <i class="fas fa-plus"></i> Nueva Oferta
                                    </a>
                                    <a href="<%= request.getContextPath() %>/empresa/postulantes" class="btn btn-info btn-block mb-2">
                                        <i class="fas fa-users"></i> Ver Postulantes
                                    </a>
                                    <a href="<%= request.getContextPath() %>/empresa/ofertas" class="btn btn-warning btn-block mb-2">
                                        <i class="fas fa-briefcase"></i> Gestionar Ofertas
                                    </a>
                                    <a href="<%= request.getContextPath() %>/empresa/reportes" class="btn btn-success btn-block">
                                        <i class="fas fa-chart-bar"></i> Ver Reportes
                                    </a>
                                </div>
                            </div>
                        </div>

                        <!-- Info de la empresa -->
                        <% if (empresa != null) { %>
                            <div class="card dashboard-card mt-3">
                                <div class="card-header bg-info text-white">
                                    <h6 class="mb-0"><i class="fas fa-info-circle"></i> Mi Empresa</h6>
                                </div>
                                <div class="card-body">
                                    <p><strong>Razón Social:</strong><br><%= empresa.getRazonSocial() %></p>
                                    <p><strong>RUC:</strong><br><%= empresa.getRuc() %></p>
                                    <% if (empresa.getDescripcion() != null && !empresa.getDescripcion().isEmpty()) { %>
                                        <p><strong>Descripción:</strong><br><%= empresa.getDescripcion() %></p>
                                    <% } %>
                                </div>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>>