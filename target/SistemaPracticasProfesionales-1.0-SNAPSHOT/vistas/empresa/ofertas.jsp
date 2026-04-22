<%-- 
    Document   : ofertas
    Created on : 23 jun. 2025, 2:49:22 p. m.
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Empresa" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis Ofertas - Sistema de Prácticas</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body class="bg-light">
    <%
        Empresa empresa = (Empresa) request.getAttribute("empresa");
        String mensaje = (String) request.getAttribute("mensaje");
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
                <a class="nav-link text-white" href="<%= request.getContextPath() %>/logout">
                    <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-briefcase text-primary"></i> Mis Ofertas</h2>
                    <a href="<%= request.getContextPath() %>/empresa/dashboard" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Volver al Dashboard
                    </a>
                </div>

                <!-- Mensajes -->
                <% if (mensaje != null) { %>
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle"></i> <%= mensaje %>
                    </div>
                <% } %>
                
                <% if (error != null) { %>
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-triangle"></i> <%= error %>
                    </div>
                <% } %>

                <!-- Contenido principal -->
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-briefcase"></i> Gestión de Ofertas de Práctica
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="text-center py-5">
                            <i class="fas fa-briefcase fa-5x text-muted mb-4"></i>
                            <h4>Módulo de Ofertas</h4>
                            <p class="text-muted">Aquí podrás crear, editar y gestionar todas tus ofertas de práctica.</p>
                            
                            <div class="row mt-4">
                                <div class="col-md-4">
                                    <div class="card border-primary">
                                        <div class="card-body text-center">
                                            <i class="fas fa-plus fa-2x text-primary mb-2"></i>
                                            <h6>Crear Oferta</h6>
                                            <p class="small text-muted">Publica nuevas oportunidades</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="card border-success">
                                        <div class="card-body text-center">
                                            <i class="fas fa-edit fa-2x text-success mb-2"></i>
                                            <h6>Editar Ofertas</h6>
                                            <p class="small text-muted">Modifica ofertas existentes</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="card border-info">
                                        <div class="card-body text-center">
                                            <i class="fas fa-chart-bar fa-2x text-info mb-2"></i>
                                            <h6>Estadísticas</h6>
                                            <p class="small text-muted">Ve el rendimiento</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mt-4">
                                <p class="text-muted">
                                    <i class="fas fa-code"></i> 
                                    <strong>En desarrollo:</strong> Esta funcionalidad se está desarrollando.
                                </p>
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
</body>
</html>