<%-- 
    Document   : dashboard
    Created on : 22 may. 2025, 11:15:57?a. m.
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Estudiante" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Estudiante - Sistema de Prácticas</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
    
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
        color: #3b82f6;
    }
    .stat-card .fa-paper-plane {
        color: #10b981;
    }
    .stat-card .fa-star {
        color: #f59e0b;
    }
    .stat-card .fa-clock {
        color: #06b6d4;
    }
    
    /* Diferentes estilos para cada tarjeta */
    .stat-card.ofertas {
        border-left: 4px solid #3b82f6;
    }
    .stat-card.postulaciones {
        border-left: 4px solid #10b981;
    }
    .stat-card.recomendadas {
        border-left: 4px solid #f59e0b;
    }
    .stat-card.pendientes {
        border-left: 4px solid #06b6d4;
    }
    /* Tarjetas de ofertas destacadas */
    .oferta-card {
        border: 1px solid rgba(59, 130, 246, 0.15);
        border-radius: 15px;
        transition: all 0.3s;
        background: rgba(255, 255, 255, 0.8);
        backdrop-filter: blur(5px);
    }
    .oferta-card:hover {
        border-color: rgba(59, 130, 246, 0.3);
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(59, 130, 246, 0.1);
        background: rgba(255, 255, 255, 0.95);
    }
    /* Área cards (Desarrollo, Análisis, Base de Datos) */
    .area-card {
        background: rgba(255, 255, 255, 0.7);
        border: 1px solid rgba(0, 0, 0, 0.1);
        border-radius: 12px;
        transition: all 0.3s ease;
        backdrop-filter: blur(5px);
    }
    .area-card:hover {
        background: rgba(255, 255, 255, 0.9);
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body class="bg-light">
    <%
        Estudiante estudiante = (Estudiante) request.getAttribute("estudiante");
        Integer totalOfertas = (Integer) request.getAttribute("totalOfertas");
        Integer totalPostulaciones = (Integer) request.getAttribute("totalPostulaciones");
        Integer postulacionesPendientes = (Integer) request.getAttribute("postulacionesPendientes");
        Integer postulacionesAceptadas = (Integer) request.getAttribute("postulacionesAceptadas");
        Integer postulacionesRechazadas = (Integer) request.getAttribute("postulacionesRechazadas");
        Integer ofertasRecomendadas = (Integer) request.getAttribute("ofertasRecomendadas");
        Boolean necesitaAtencion = (Boolean) request.getAttribute("necesitaAtencion");
        String error = (String) request.getAttribute("error");
        String mensaje = (String) request.getAttribute("mensaje");
    %>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="<%= request.getContextPath() %>/estudiante/dashboard">
                <i class="fas fa-graduation-cap"></i> 
                <% if (estudiante != null) { %>
                    <%= estudiante.getNombres() != null ? estudiante.getNombres() : "Estudiante" %>
                <% } else { %>
                    Panel de Estudiante
                <% } %>
            </a>
            
            <div class="navbar-nav ml-auto">
                <div class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-white" href="#" role="button" data-toggle="dropdown">
                        <i class="fas fa-user-graduate"></i> Estudiante
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
                        <h6 class="mb-0"><i class="fas fa-list"></i> Menú Estudiante</h6>
                    </div>
                    <div class="list-group list-group-flush">
                        <a href="<%= request.getContextPath() %>/estudiante/ofertas" class="list-group-item list-group-item-action">
    <i class="fas fa-briefcase"></i> Ofertas Disponibles
</a>
<a href="<%= request.getContextPath() %>/estudiante/postulaciones" class="list-group-item list-group-item-action">
    <i class="fas fa-paper-plane"></i> Mis Postulaciones
</a>
<a href="<%= request.getContextPath() %>/estudiante/perfil" class="list-group-item list-group-item-action">
    <i class="fas fa-user"></i> Mi Perfil
</a>
<a href="<%= request.getContextPath() %>/estudiante/practicas" class="list-group-item list-group-item-action">
    <i class="fas fa-clipboard-list"></i> Mis Prácticas
</a>
                    </div>
                </div>
            </div>

            <!-- Contenido Principal -->
            <div class="col-md-9 col-lg-10">
                <!-- Título -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-graduation-cap text-primary"></i> Dashboard de Estudiante</h2>
                    <div class="text-muted">
                        <i class="fas fa-calendar"></i> 
                        <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(new java.util.Date()) %>
                    </div>
                </div>

                <!-- Mensaje de bienvenida -->
                <% if (estudiante != null) { %>
                    <div class="alert alert-info">
                        <i class="fas fa-graduation-cap"></i> 
                        ¡Hola <strong><%= estudiante.getNombres() != null ? estudiante.getNombres() : "Estudiante" %></strong>!
                    </div>
                <% } %>

                <!-- Mensajes -->
                <% if (mensaje != null) { %>
                    <div class="alert alert-success alert-dismissible fade show">
                        <i class="fas fa-check-circle"></i> <%= mensaje %>
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                    </div>
                <% } %>
                
                <% if (error != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show">
                        <i class="fas fa-exclamation-triangle"></i> <%= error %>
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                    </div>
                <% } %>

                <% if (necesitaAtencion != null && necesitaAtencion) { %>
                    <div class="alert alert-warning alert-dismissible fade show">
                        <i class="fas fa-bell"></i> 
                        <strong>¡Atención!</strong> Tienes <%= postulacionesPendientes != null ? postulacionesPendientes : 0 %> postulaciones pendientes.
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                    </div>
                <% } %>

                <!-- Tarjetas de estadísticas -->
                <div class="row mb-4">
                    <div class="col-xl-3 col-md-6 mb-3">
                        <div class="card dashboard-card stat-card">
                            <div class="card-body text-center">
                                <i class="fas fa-briefcase fa-2x mb-2"></i>
                                <h3 class="mb-0"><%= totalOfertas != null ? totalOfertas : 0 %></h3>
                                <p class="mb-0">Ofertas Disponibles</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-xl-3 col-md-6 mb-3">
                        <div class="card dashboard-card stat-card success">
                            <div class="card-body text-center">
                                <i class="fas fa-paper-plane fa-2x mb-2"></i>
                                <h3 class="mb-0"><%= totalPostulaciones != null ? totalPostulaciones : 0 %></h3>
                                <p class="mb-0">Mis Postulaciones</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-xl-3 col-md-6 mb-3">
                        <div class="card dashboard-card stat-card warning">
                            <div class="card-body text-center">
                                <i class="fas fa-star fa-2x mb-2"></i>
                                <h3 class="mb-0"><%= ofertasRecomendadas != null ? ofertasRecomendadas : 0 %></h3>
                                <p class="mb-0">Recomendadas</p>
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
                    <!-- Ofertas Destacadas -->
                    <div class="col-lg-8 mb-4">
                        <div class="card dashboard-card">
                            <div class="card-header bg-primary text-white">
                                <h5 class="mb-0">
                                    <i class="fas fa-fire"></i> Ofertas Destacadas para Ti
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="text-center py-4">
                                    <i class="fas fa-briefcase fa-3x text-muted mb-3"></i>
                                    <h5>Oportunidades de Práctica</h5>
                                    <p class="text-muted">Encuentra las mejores ofertas de práctica profesional.</p>
                                    
                                    <div class="row mt-4">
                                        <div class="col-md-4">
                                            <div class="card border-primary">
                                                <div class="card-body text-center">
                                                    <i class="fas fa-code fa-2x text-primary mb-2"></i>
                                                    <h6>Desarrollo</h6>
                                                    <p class="small text-muted">Programación y sistemas</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="card border-success">
                                                <div class="card-body text-center">
                                                    <i class="fas fa-chart-bar fa-2x text-success mb-2"></i>
                                                    <h6>Análisis</h6>
                                                    <p class="small text-muted">Datos y estadísticas</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="card border-info">
                                                <div class="card-body text-center">
                                                    <i class="fas fa-database fa-2x text-info mb-2"></i>
                                                    <h6>Base de Datos</h6>
                                                    <p class="small text-muted">Administración BD</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="mt-4">
                                        <p class="text-muted">
                                            <i class="fas fa-code"></i> 
                                            <strong>En desarrollo:</strong> Pronto podrás ver todas las ofertas disponibles.
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Panel lateral -->
                    <div class="col-lg-4 mb-4">
                        <!-- Mi Perfil -->
                        <% if (estudiante != null) { %>
                            <div class="card dashboard-card perfil-card mb-3">
                                <div class="card-body text-center">
                                    <i class="fas fa-user-circle fa-3x mb-3"></i>
                                    <h6>
                                        <%= estudiante.getNombres() != null ? estudiante.getNombres() : "Estudiante" %>
                                        <%= estudiante.getApellidos() != null ? estudiante.getApellidos() : "" %>
                                    </h6>
                                    <p class="mb-2">
                                        <i class="fas fa-id-card"></i> 
                                        Código: <%= estudiante.getCodigoUniversitario() != null ? estudiante.getCodigoUniversitario() : "N/A" %>
                                    </p>
                                    <p class="mb-3">
                                        <i class="fas fa-envelope"></i> 
                                        <%= estudiante.getEmail() != null ? estudiante.getEmail() : "Sin email" %>
                                    </p>
                                    <button class="btn btn-light btn-sm">
                                        <i class="fas fa-edit"></i> Editar Perfil
                                    </button>
                                </div>
                            </div>
                        <% } %>

                        <!-- Estado de Postulaciones -->
                        <div class="card dashboard-card mb-3">
                            <div class="card-header bg-info text-white">
                                <h6 class="mb-0"><i class="fas fa-chart-pie"></i> Estado de Postulaciones</h6>
                            </div>
                            <div class="card-body">
                                <div class="mb-2">
                                    <div class="d-flex justify-content-between">
                                        <span>Pendientes</span>
                                        <span class="font-weight-bold"><%= postulacionesPendientes != null ? postulacionesPendientes : 0 %></span>
                                    </div>
                                    <div class="progress" style="height: 6px;">
                                        <div class="progress-bar bg-warning" style="width: 40%"></div>
                                    </div>
                                </div>
                                <div class="mb-2">
                                    <div class="d-flex justify-content-between">
                                        <span>Aceptadas</span>
                                        <span class="font-weight-bold"><%= postulacionesAceptadas != null ? postulacionesAceptadas : 0 %></span>
                                    </div>
                                    <div class="progress" style="height: 6px;">
                                        <div class="progress-bar bg-success" style="width: 25%"></div>
                                    </div>
                                </div>
                                <div>
                                    <div class="d-flex justify-content-between">
                                        <span>Rechazadas</span>
                                        <span class="font-weight-bold"><%= postulacionesRechazadas != null ? postulacionesRechazadas : 0 %></span>
                                    </div>
                                    <div class="progress" style="height: 6px;">
                                        <div class="progress-bar bg-danger" style="width: 35%"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Acciones Rápidas -->
                        <div class="card dashboard-card">
                            <div class="card-header bg-success text-white">
                                <h6 class="mb-0"><i class="fas fa-bolt"></i> Acciones Rápidas "EN DESARROLLO"</h6>
                            </div>
                            <div class="card-body">
                                <div class="d-grid gap-2">
                                    <button class="btn btn-primary btn-block mb-2">
                                        <i class="fas fa-search"></i> Buscar Ofertas
                                    </button>
                                    <button class="btn btn-info btn-block mb-2">
                                        <i class="fas fa-paper-plane"></i> Mis Postulaciones
                                    </button>
                                    <button class="btn btn-warning btn-block mb-2">
                                        <i class="fas fa-user"></i> Actualizar Perfil
                                    </button>
                                    <button class="btn btn-success btn-block">
                                        <i class="fas fa-clipboard-list"></i> Mis Prácticas
                                    </button>
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
    
    <script>
        // Auto-ocultar alertas después de 5 segundos
        setTimeout(function() {
            $('.alert').fadeOut('slow');
        }, 5000);
    </script>
    <!-- Sección de Firma Digital - Agregar antes del cierre del container principal -->
<div class="row mt-4">
    <div class="col-12">
        <div class="card dashboard-card">
            <div class="card-header" style="background: linear-gradient(135deg, #10b981 0%, #059669 100%); color: white;">
                <h5 class="mb-0">
                    <i class="fas fa-file-signature"></i> Mis Ofertas Aceptadas - Listos para Firmar
                </h5>
            </div>
            <div class="card-body">
                <div class="alert alert-info mb-3">
                    <i class="fas fa-info-circle"></i> 
                    <strong>Firma Digital:</strong> Aquí podrás firmar digitalmente los contratos de las ofertas que han sido aceptadas por las empresas.
                </div>

                <!-- Estadísticas de Firma -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="card text-center" style="border-left: 4px solid #10b981;">
                            <div class="card-body">
                                <i class="fas fa-file-contract fa-2x mb-2" style="color: #10b981;"></i>
                                <h4 class="mb-0">2</h4>
                                <small>Pendientes de Firmar</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-center" style="border-left: 4px solid #3b82f6;">
                            <div class="card-body">
                                <i class="fas fa-signature fa-2x mb-2" style="color: #3b82f6;"></i>
                                <h4 class="mb-0">1</h4>
                                <small>Ya Firmados</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-center" style="border-left: 4px solid #f59e0b;">
                            <div class="card-body">
                                <i class="fas fa-clock fa-2x mb-2" style="color: #f59e0b;"></i>
                                <h4 class="mb-0">1</h4>
                                <small>Esperando Empresa</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-center" style="border-left: 4px solid #6b7280;">
                            <div class="card-body">
                                <i class="fas fa-check-circle fa-2x mb-2" style="color: #6b7280;"></i>
                                <h4 class="mb-0">3</h4>
                                <small>Completados</small>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Funcionalidades disponibles -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <h6><i class="fas fa-check text-success"></i> Funcionalidades disponibles:</h6>
                        <ul class="list-unstyled">
                            <li><i class="fas fa-check-circle text-success"></i> Ver contratos aceptados</li>
                            <li><i class="fas fa-check-circle text-success"></i> Firmar digitalmente con Tocapu</li>
                            <li><i class="fas fa-check-circle text-success"></i> Descargar documentos firmados</li>
                        </ul>
                    </div>
                    <div class="col-md-6">
                        <h6><i class="fas fa-cog text-primary"></i> Próximamente:</h6>
                        <ul class="list-unstyled">
                            <li><i class="fas fa-clock text-warning"></i> Notificaciones automáticas</li>
                            <li><i class="fas fa-clock text-warning"></i> Historial completo de firmas</li>
                            <li><i class="fas fa-clock text-warning"></i> Verificación de documentos</li>
                        </ul>
                    </div>
                </div>

                <!-- Tabla de ofertas para firmar -->
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead style="background-color: #f8f9fa;">
                            <tr>
                                <th>Empresa</th>
                                <th>Oferta</th>
                                <th>Fecha Aceptación</th>
                                <th>Estado Firma</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <strong>Empresa Tecnológica SAC</strong><br>
                                    <small class="text-muted">Sector: Desarrollo de Software</small>
                                </td>
                                <td>
                                    <strong>Desarrollador Web</strong><br>
                                    <small class="text-muted">Modalidad: Remoto</small>
                                </td>
                                <td>08/07/2025</td>
                                <td>
                                    <span class="badge bg-warning">
                                        <i class="fas fa-clock"></i> Sin Firmar
                                    </span>
                                </td>
                                <td>
                                    <button class="btn btn-success btn-sm" onclick="firmarContrato('Empresa Tecnológica SAC', 'Desarrollador Web')">
    <i class="fas fa-file-signature"></i> Firmar Contrato
</button>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <strong>Innovación Digital EIRL</strong><br>
                                    <small class="text-muted">Sector: Análisis de Datos</small>
                                </td>
                                <td>
                                    <strong>Analista de Datos</strong><br>
                                    <small class="text-muted">Modalidad: Presencial</small>
                                </td>
                                <td>05/07/2025</td>
                                <td>
                                    <span class="badge bg-success">
                                        <i class="fas fa-check"></i> Firmado
                                    </span>
                                </td>
                                <td>
                                    <button class="btn btn-outline-primary btn-sm">
                                        <i class="fas fa-download"></i> Descargar
                                    </button>
                                    <button class="btn btn-outline-info btn-sm">
                                        <i class="fas fa-eye"></i> Ver
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Botones de acción -->
                <div class="d-flex justify-content-between mt-3">
                    <div>
                        <button class="btn btn-outline-secondary">
                            <i class="fas fa-history"></i> Ver Historial Completo
                        </button>
                    </div>
                    <div>
                        <button class="btn btn-success btn-sm" onclick="firmarDocumento('Empresa Tecnológica SAC', 'Desarrollador Web')">
                            <i class="fas fa-file-export"></i> Exportar Documentos
                        </button>
                    </div>
                </div>

                <!-- Nota informativa -->
                <div class="alert alert-light mt-3">
                    <small>
                        <i class="fas fa-info-circle"></i>
                        <strong>Nota:</strong> La firma digital utiliza la plataforma Tocapu para garantizar la validez legal de los documentos. 
                        Una vez firmado por ambas partes, el contrato tendrá validez legal completa.
                    </small>
                </div>
            </div>
        </div>
    </div>
</div>
    <script>
function firmarDocumento(empresa, oferta) {
    // Mostrar mensaje de procesamiento
    Swal.fire({
        title: 'Preparando Firma Digital',
        text: 'Conectando con la plataforma Tocapu...',
        allowOutsideClick: false,
        showConfirmButton: false,
        didOpen: () => {
            Swal.showLoading();
        }
    });
    
    // Simular proceso de preparación
    setTimeout(() => {
        Swal.fire({
            title: '🔐 Firma Digital con Tocapu',
            html: `
                <div class="text-start">
                    <h6><i class="fas fa-file-contract text-success"></i> Documento a Firmar:</h6>
                    <div class="bg-light p-3 rounded mb-3">
                        <strong>Empresa:</strong> ${empresa}<br>
                        <strong>Oferta:</strong> ${oferta}<br>
                        <strong>Tipo:</strong> Contrato de Prácticas Profesionales<br>
                        <strong>Estudiante:</strong> Anyelo Marcelo Zamora Valencia
                    </div>
                    
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle"></i>
                        <strong>Proceso de Firma Digital:</strong><br>
                        1. Se abrirá la plataforma Tocapu<br>
                        2. Debes autenticarte con tu DNI<br>
                        3. Revisar el documento completo<br>
                        4. Confirmar la firma digital
                    </div>
                    
                    <div class="alert alert-warning">
                        <i class="fas fa-exclamation-triangle"></i>
                        <strong>Importante:</strong> Una vez firmado, el contrato tendrá validez legal.
                    </div>
                </div>
            `,
            icon: 'question',
            showCancelButton: true,
            confirmButtonText: '<i class="fas fa-signature"></i> Proceder a Firmar',
            cancelButtonText: '<i class="fas fa-times"></i> Cancelar',
            confirmButtonColor: '#10b981',
            cancelButtonColor: '#6c757d',
            buttonsStyling: true,
            customClass: {
                popup: 'swal2-popup-large'
            }
        }).then((result) => {
            if (result.isConfirmed) {
                procesarFirmaDigital(empresa, oferta);
            }
        });
    }, 1500);
}

function procesarFirmaDigital(empresa, oferta) {
    // Mostrar progreso de firma
    Swal.fire({
        title: 'Iniciando Proceso de Firma',
        html: `
            <div class="d-flex justify-content-center mb-3">
                <div class="spinner-border text-success" role="status">
                    <span class="visually-hidden">Cargando...</span>
                </div>
            </div>
            <p>Conectando con Tocapu...</p>
            <div class="progress mt-3">
                <div class="progress-bar bg-success" role="progressbar" style="width: 25%"></div>
            </div>
        `,
        allowOutsideClick: false,
        showConfirmButton: false
    });
    
    // Simular proceso de conexión con Tocapu
    let progress = 25;
    const interval = setInterval(() => {
        progress += 25;
        document.querySelector('.progress-bar').style.width = progress + '%';
        
        if (progress === 50) {
            Swal.update({
                html: `
                    <div class="d-flex justify-content-center mb-3">
                        <div class="spinner-border text-primary" role="status">
                            <span class="visually-hidden">Cargando...</span>
                        </div>
                    </div>
                    <p>Preparando documento...</p>
                    <div class="progress mt-3">
                        <div class="progress-bar bg-primary" role="progressbar" style="width: 50%"></div>
                    </div>
                `
            });
        } else if (progress === 75) {
            Swal.update({
                html: `
                    <div class="d-flex justify-content-center mb-3">
                        <div class="spinner-border text-warning" role="status">
                            <span class="visually-hidden">Cargando...</span>
                        </div>
                    </div>
                    <p>Abriendo Tocapu...</p>
                    <div class="progress mt-3">
                        <div class="progress-bar bg-warning" role="progressbar" style="width: 75%"></div>
                    </div>
                `
            });
        } else if (progress >= 100) {
            clearInterval(interval);
            abrirTocapu(empresa, oferta);
        }
    }, 800);
}

function abrirTocapu(empresa, oferta) {
    // Abrir Tocapu en nueva ventana
    const tocapuWindow = window.open(
        '${pageContext.request.contextPath}/app/subir', 
        'tocapu_firma', 
        'width=800,height=600,scrollbars=yes,resizable=yes'
    );
    
    // Mostrar mensaje de éxito
    Swal.fire({
        title: '✅ Tocapu Abierto',
        html: `
            <div class="alert alert-success">
                <h6><i class="fas fa-check-circle"></i> Plataforma Tocapu iniciada correctamente</h6>
                <p class="mb-0">Se ha abierto una nueva ventana con la plataforma de firma digital.</p>
            </div>
            
            <div class="alert alert-info">
                <h6><i class="fas fa-info-circle"></i> Instrucciones:</h6>
                <ol class="text-start mb-0">
                    <li>Completa el proceso de firma en la ventana de Tocapu</li>
                    <li>Una vez firmado, regresa a esta página</li>
                    <li>El estado se actualizará automáticamente</li>
                </ol>
            </div>
            
            <div class="mt-3">
                <small class="text-muted">
                    <i class="fas fa-shield-alt"></i>
                    Proceso protegido con certificados digitales
                </small>
            </div>
        `,
        icon: 'success',
        confirmButtonText: '<i class="fas fa-check"></i> Entendido',
        confirmButtonColor: '#10b981'
    }).then(() => {
        // Opcional: Actualizar el estado en la tabla
        actualizarEstadoFirma();
    });
}

function actualizarEstadoFirma() {
    // Simular actualización del estado
    setTimeout(() => {
        Swal.fire({
            toast: true,
            position: 'top-end',
            icon: 'info',
            title: 'Verificando estado de firma...',
            showConfirmButton: false,
            timer: 2000
        });
        
        // Aquí podrías hacer una llamada AJAX para verificar el estado real
        setTimeout(() => {
            Swal.fire({
                toast: true,
                position: 'top-end',
                icon: 'success',
                title: 'Estado actualizado correctamente',
                showConfirmButton: false,
                timer: 3000
            });
        }, 2000);
    }, 3000);
}

// Estilos adicionales para SweetAlert2
const style = document.createElement('style');
style.textContent = `
    .swal2-popup-large {
        width: 600px !important;
        max-width: 90% !important;
    }
    
    .swal2-html-container {
        max-height: 400px;
        overflow-y: auto;
    }
`;
document.head.appendChild(style);
</script>
<script>
function abrirTocapuDirecto() {
    // Abrir Tocapu directamente en nueva ventana
    const tocapuWindow = window.open(
        '${pageContext.request.contextPath}/app/subir', 
        'tocapu_firma', 
        'width=1000,height=700,scrollbars=yes,resizable=yes,menubar=no,toolbar=no'
    );
    
    // Verificar si se abrió correctamente
    if (tocapuWindow) {
        console.log('Tocapu abierto correctamente');
    } else {
        alert('Por favor permite ventanas emergentes para usar Tocapu');
    }
}
</script>
<script>
console.log("🔧 Cargando Tocapu para estudiante...");

// Función signTocapu adaptada para estudiante
function signTocapu(tipoUsuario, idPostulacion, contexto = {}) {
    console.log("🔥 Activando Tocapu (estudiante):", tipoUsuario, idPostulacion);
    
    const timestamp = new Date().getTime();
    const fileName = `contrato_estudiante_${idPostulacion}_${timestamp}.pdf`;
    
    // URL para Tocapu (SIN -1.0-SNAPSHOT)
    const tocapuUrl = `tocapusign:?environment=demo&from=http://localhost:8080/SistemaPracticasProfesionales/documentos_firmados/articulo_convex___no_convex.pdf&to=http://localhost:8080/SistemaPracticasProfesionales/app/subir?name=${fileName}`;
    
    console.log("🔗 URL Tocapu:", tocapuUrl);
    
    try {
        // Crear enlace invisible
        const link = document.createElement('a');
        link.href = tocapuUrl;
        link.style.display = 'none';
        document.body.appendChild(link);
        
        // Activar enlace
        link.click();
        
        // Limpiar
        document.body.removeChild(link);
        
        alert("✅ Tocapu activado! Complete la firma en la aplicación.");
        
    } catch (error) {
        console.error("❌ Error al activar Tocapu:", error);
        alert("❌ Error al activar Tocapu: " + error.message);
    }
}

// Función para firmar contrato como estudiante
function firmarContrato(empresa, oferta, idPostulacion = 1) {
    console.log("🖊️ Estudiante iniciando firma para:", empresa, oferta);
    
    const contexto = {
        empresa: empresa,
        oferta: oferta,
        estudiante: "Anyelo Marcelo Zamora Valencia"
    };
    
    if (confirm(`¿Deseas firmar digitalmente el contrato con ${empresa} para la oferta de ${oferta}?`)) {
        signTocapu("estudiante", idPostulacion, contexto);
    }
}

console.log("✅ Funciones Tocapu para estudiante cargadas");
</script>
</body>
</html>