<%-- 
    Document   : dashboard
    Created on : 22 may. 2025, 5:09:19 p. m.
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Admin - Sistema de Prácticas Profesionales</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/recursos/css/styles.css">
</head>
<body>
    <!-- Navbar Admin -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="<%= request.getContextPath() %>/admin/dashboard">
                <i class="fas fa-cogs"></i> Panel de Administración
            </a>
            
            <div class="navbar-nav ml-auto">
                <div class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-white" href="#" id="adminDropdown" role="button" data-toggle="dropdown">
                        <i class="fas fa-user-shield"></i> Administrador
                    </a>
                    <div class="dropdown-menu dropdown-menu-right">
                        <a class="dropdown-item" href="<%= request.getContextPath() %>/">
                            <i class="fas fa-home"></i> Ver Sitio
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
            <div class="col-md-3 col-lg-2">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h6 class="mb-0"><i class="fas fa-list"></i> Menú Admin</h6>
                    </div>
                    <div class="list-group list-group-flush">
                        <a href="<%= request.getContextPath() %>/admin/dashboard" class="list-group-item list-group-item-action active">
                            <i class="fas fa-tachometer-alt"></i> Dashboard
                        </a>
                        <a href="<%= request.getContextPath() %>/admin/usuarios" class="list-group-item list-group-item-action">
                            <i class="fas fa-users"></i> Usuarios
                        </a>
                        <a href="<%= request.getContextPath() %>/admin/estudiantes" class="list-group-item list-group-item-action">
                            <i class="fas fa-user-graduate"></i> Estudiantes
                        </a>
                        <a href="<%= request.getContextPath() %>/admin/empresas" class="list-group-item list-group-item-action">
                            <i class="fas fa-building"></i> Empresas
                        </a>
                        <a href="<%= request.getContextPath() %>/admin/ofertas" class="list-group-item list-group-item-action">
                            <i class="fas fa-briefcase"></i> Ofertas
                        </a>
                        <a href="<%= request.getContextPath() %>/admin/practicas" class="list-group-item list-group-item-action">
                            <i class="fas fa-clipboard-list"></i> Prácticas
                        </a>
                        <a href="<%= request.getContextPath() %>/admin/reportes" class="list-group-item list-group-item-action">
                            <i class="fas fa-chart-bar"></i> Reportes
                        </a>
                    </div>
                </div>
            </div>

            <!-- Contenido Principal -->
            <div class="col-md-9 col-lg-10">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-tachometer-alt text-primary"></i> Dashboard de Administración</h2>
                    <div class="text-muted">
                        <i class="fas fa-calendar"></i> <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(new java.util.Date()) %>
                    </div>
                </div>

                <!-- Tarjetas de estadísticas -->
                <div class="row mb-4">
                    <div class="col-xl-3 col-md-6">
                        <div class="card border-left-primary shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                            Total Usuarios
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%= request.getAttribute("totalUsuarios") %></div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-users fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6">
                        <div class="card border-left-success shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                            Estudiantes
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%= request.getAttribute("totalEstudiantes") %></div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-user-graduate fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6">
                        <div class="card border-left-info shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                            Empresas
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%= request.getAttribute("totalEmpresas") %></div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-building fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6">
                        <div class="card border-left-warning shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                            Ofertas Activas
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%= request.getAttribute("ofertasActivas") %></div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-briefcase fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Alertas y notificaciones -->
                <% if ((Integer)request.getAttribute("empresasPendientes") > 0) { %>
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="alert alert-warning alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-triangle"></i>
                            <strong>Atención:</strong> Hay <%= request.getAttribute("empresasPendientes") %> empresa(s) pendiente(s) de aprobación.
                            <a href="<%= request.getContextPath() %>/admin/empresas?estado=PENDIENTE" class="btn btn-warning btn-sm ml-2">
                                Ver empresas pendientes
                            </a>
                            <button type="button" class="close" data-dismiss="alert">
                                <span>&times;</span>
                            </button>
                        </div>
                    </div>
                </div>
                <% } %>

                <!-- Acciones rápidas -->
                <div class="row">
                    <div class="col-12">
                        <div class="card shadow">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">
                                    <i class="fas fa-bolt"></i> Acciones Rápidas
                                </h6>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-4 mb-3">
                                        <a href="<%= request.getContextPath() %>/admin/empresas?estado=PENDIENTE" class="btn btn-warning btn-block">
                                            <i class="fas fa-clock"></i> Aprobar Empresas
                                        </a>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <a href="<%= request.getContextPath() %>/admin/usuarios" class="btn btn-info btn-block">
                                            <i class="fas fa-users"></i> Gestionar Usuarios
                                        </a>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <a href="<%= request.getContextPath() %>/admin/reportes" class="btn btn-success btn-block">
                                            <i class="fas fa-chart-bar"></i> Ver Reportes
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <style>
        .text-xs {
            font-size: 0.7rem;
        }
        .text-gray-800 {
            color: #5a5c69 !important;
        }
        .text-gray-300 {
            color: #dddfeb !important;
        }
        .border-left-primary {
            border-left: 0.25rem solid #4e73df !important;
        }
        .border-left-success {
            border-left: 0.25rem solid #1cc88a !important;
        }
        .border-left-info {
            border-left: 0.25rem solid #36b9cc !important;
        }
        .border-left-warning {
            border-left: 0.25rem solid #f6c23e !important;
        }
    </style>
</body>
</html>