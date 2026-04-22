<%-- 
    Document   : reportes
    Created on : 9 jul. 2025, 11:27:13 a. m.
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Empresa" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reportes - Sistema de Prácticas</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        /* Paleta de colores suaves */
        :root {
            --color-primary: #6b7280;
            --color-secondary: #9ca3af;
            --color-light: #f9fafb;
            --color-border: #e5e7eb;
            --color-text: #374151;
            --color-text-light: #6b7280;
        }

        body {
            background-color: #fafafa;
            color: var(--color-text);
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        }

        .report-card {
            background: white;
            border: 1px solid var(--color-border);
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            transition: all 0.2s ease;
        }
        
        .report-card:hover {
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            transform: translateY(-1px);
        }

        .stat-box {
            background: white;
            border: 1px solid var(--color-border);
            border-radius: 8px;
            padding: 24px;
            text-align: center;
            transition: all 0.2s ease;
        }
        
        .stat-box:hover {
            border-color: var(--color-secondary);
        }

        .stat-box h3 {
            color: var(--color-text);
            font-size: 2rem;
            font-weight: 600;
            margin: 8px 0;
        }

        .stat-box p {
            color: var(--color-text-light);
            font-size: 0.875rem;
            margin: 0;
        }

        .stat-box i {
            color: var(--color-secondary);
        }

        /* Colores específicos para cada icono de estadística */
        .stat-box .fa-briefcase {
            color: #3b82f6; /* Azul */
        }

        .stat-box .fa-users {
            color: #10b981; /* Verde */
        }

        .stat-box .fa-clock {
            color: #f59e0b; /* Amarillo/Naranja */
        }

        .stat-box .fa-check-circle {
            color: #6b7280; /* Gris */
        }

        .navbar.bg-primary {
            background-color: #007bff !important;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .navbar-brand {
            color: white !important;
        }

        .nav-link {
            color: rgba(255,255,255,0.8) !important;
        }

        .nav-link:hover {
            color: white !important;
        }

        .card-header {
            background-color: #f8f9fa !important;
            border-bottom: 1px solid var(--color-border) !important;
            color: var(--color-text) !important;
        }

        .btn-generar {
            background-color: var(--color-primary);
            border: 1px solid var(--color-primary);
            color: white;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 0.875rem;
            transition: all 0.2s ease;
        }

        .btn-generar:hover {
            background-color: var(--color-text);
            border-color: var(--color-text);
            color: white;
            transform: translateY(-1px);
        }

        .btn-filtro {
            background-color: white;
            border: 1px solid var(--color-border);
            color: var(--color-text);
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 0.875rem;
        }

        .btn-filtro:hover {
            background-color: var(--color-light);
            border-color: var(--color-secondary);
            color: var(--color-text);
        }

        .form-control {
            border: 1px solid var(--color-border);
            border-radius: 6px;
            font-size: 0.875rem;
        }

        .form-control:focus {
            border-color: var(--color-secondary);
            box-shadow: 0 0 0 3px rgba(156, 163, 175, 0.1);
        }

        .alert {
            border: 1px solid var(--color-border);
            border-radius: 6px;
        }

        .alert-success {
            background-color: #f0fdf4;
            border-color: #bbf7d0;
            color: #166534;
        }

        .alert-danger {
            background-color: #fef2f2;
            border-color: #fecaca;
            color: #991b1b;
        }

        .reporte-item {
            background: white;
            border: 1px solid var(--color-border);
            border-radius: 6px;
            padding: 16px;
            margin-bottom: 12px;
            transition: all 0.2s ease;
        }

        .reporte-item:hover {
            border-color: var(--color-secondary);
        }

        .reporte-item h6 {
            color: var(--color-text);
            margin-bottom: 8px;
        }

        /* Colores específicos para iconos de reportes */
        .reporte-item .fa-briefcase {
            color: #3b82f6; /* Azul */
        }

        .reporte-item .fa-users {
            color: #10b981; /* Verde */
        }

        .reporte-item .fa-chart-line {
            color: #f59e0b; /* Amarillo/Naranja */
        }

        .reporte-item .fa-cog {
            color: #6b7280; /* Gris */
        }

        .reporte-item p {
            color: var(--color-text-light);
            font-size: 0.875rem;
            margin-bottom: 12px;
        }

        .modal-content {
            border: 1px solid var(--color-border);
            border-radius: 8px;
        }

        .modal-header {
            background-color: var(--color-light);
            border-bottom: 1px solid var(--color-border);
        }

        .text-muted {
            color: var(--color-text-light) !important;
        }

        h2, h5, h6 {
            color: var(--color-text);
        }
    </style>
</head>
<body>
    <%
        Empresa empresa = (Empresa) session.getAttribute("empresa");
        Integer totalOfertas = (Integer) request.getAttribute("totalOfertas");
        Integer totalPostulaciones = (Integer) request.getAttribute("totalPostulaciones");
        Integer postulacionesPendientes = (Integer) request.getAttribute("postulacionesPendientes");
        Integer postulacionesAceptadas = (Integer) request.getAttribute("postulacionesAceptadas");
        String promedioPostulaciones = (String) request.getAttribute("promedioPostulaciones");
        Integer tasaRespuesta = (Integer) request.getAttribute("tasaRespuesta");
        String error = (String) request.getAttribute("error");
        String mensaje = (String) request.getAttribute("mensaje");
    %>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="<%= request.getContextPath() %>/empresa/dashboard">
                <i class="fas fa-building"></i> Panel Empresa
            </a>
            <div class="navbar-nav ml-auto">
                <a class="nav-link" href="<%= request.getContextPath() %>/empresa/dashboard">
                    <i class="fas fa-arrow-left"></i> Volver al Dashboard
                </a>
            </div>
        </div>
    </nav>

    <div class="container-fluid mt-4">
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

        <div class="row">
            <!-- Título -->
            <div class="col-12 mb-4">
                <h2><i class="fas fa-chart-bar mr-2"></i>Panel de Reportes</h2>
                <p class="text-muted">Analiza el rendimiento de tus ofertas de práctica y postulaciones</p>
            </div>

            <!-- Estadísticas rápidas -->
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="stat-box">
                    <i class="fas fa-briefcase fa-2x mb-2"></i>
                    <h3><%= totalOfertas != null ? totalOfertas : 0 %></h3>
                    <p>Ofertas Publicadas</p>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="stat-box">
                    <i class="fas fa-users fa-2x mb-2"></i>
                    <h3><%= totalPostulaciones != null ? totalPostulaciones : 0 %></h3>
                    <p>Total Postulaciones</p>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="stat-box">
                    <i class="fas fa-clock fa-2x mb-2"></i>
                    <h3><%= postulacionesPendientes != null ? postulacionesPendientes : 0 %></h3>
                    <p>Pendientes</p>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="stat-box">
                    <i class="fas fa-check-circle fa-2x mb-2"></i>
                    <h3><%= postulacionesAceptadas != null ? postulacionesAceptadas : 0 %></h3>
                    <p>Aceptados</p>
                </div>
            </div>
        </div>

        <div class="row">
            <!-- Reportes disponibles -->
            <div class="col-lg-8 mb-4">
                <div class="card report-card">
                    <div class="card-header">
                        <h5 class="mb-0">
                            <i class="fas fa-file-alt mr-2"></i>Reportes Disponibles
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <!-- Reporte de Ofertas -->
                            <div class="col-md-6 mb-3">
                                <div class="reporte-item">
                                    <h6>
                                        <i class="fas fa-briefcase mr-2"></i>Reporte de Ofertas
                                    </h6>
                                    <p>Listado completo de todas tus ofertas publicadas con estadísticas.</p>
                                    <form method="post" style="display: inline;">
                                        <input type="hidden" name="accion" value="generar">
                                        <input type="hidden" name="tipo" value="ofertas">
                                        <input type="hidden" name="formato" value="pdf">
                                        <button type="submit" class="btn btn-generar btn-sm">
                                            <i class="fas fa-download mr-1"></i>Generar PDF
                                        </button>
                                    </form>
                                </div>
                            </div>

                            <!-- Reporte de Postulaciones -->
                            <div class="col-md-6 mb-3">
                                <div class="reporte-item">
                                    <h6>
                                        <i class="fas fa-users mr-2"></i>Reporte de Postulaciones
                                    </h6>
                                    <p>Detalle de todos los candidatos que se han postulado.</p>
                                    <form method="post" style="display: inline;">
                                        <input type="hidden" name="accion" value="generar">
                                        <input type="hidden" name="tipo" value="postulaciones">
                                        <input type="hidden" name="formato" value="pdf">
                                        <button type="submit" class="btn btn-generar btn-sm">
                                            <i class="fas fa-download mr-1"></i>Generar PDF
                                        </button>
                                    </form>
                                </div>
                            </div>

                            <!-- Reporte de Rendimiento -->
                            <div class="col-md-6 mb-3">
                                <div class="reporte-item">
                                    <h6>
                                        <i class="fas fa-chart-line mr-2"></i>Rendimiento Mensual
                                    </h6>
                                    <p>Análisis del rendimiento de tus ofertas por mes.</p>
                                    <form method="post" style="display: inline;">
                                        <input type="hidden" name="accion" value="generar">
                                        <input type="hidden" name="tipo" value="rendimiento">
                                        <input type="hidden" name="formato" value="pdf">
                                        <button type="submit" class="btn btn-generar btn-sm">
                                            <i class="fas fa-download mr-1"></i>Generar PDF
                                        </button>
                                    </form>
                                </div>
                            </div>

                            <!-- Reporte Personalizado -->
                            <div class="col-md-6 mb-3">
                                <div class="reporte-item">
                                    <h6>
                                        <i class="fas fa-cog mr-2"></i>Reporte Personalizado
                                    </h6>
                                    <p>Crea un reporte con filtros específicos de fechas y categorías.</p>
                                    <button class="btn btn-generar btn-sm" data-toggle="modal" data-target="#modalPersonalizado">
                                        <i class="fas fa-edit mr-1"></i>Configurar
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Panel de filtros rápidos -->
            <div class="col-lg-4 mb-4">
                <div class="card report-card">
                    <div class="card-header">
                        <h6 class="mb-0">
                            <i class="fas fa-filter mr-2"></i>Filtros Rápidos
                        </h6>
                    </div>
                    <div class="card-body">
                        <form method="post">
                            <input type="hidden" name="accion" value="filtrar">
                            <div class="form-group">
                                <label for="fechaInicio">Fecha Inicio:</label>
                                <input type="date" class="form-control form-control-sm" id="fechaInicio" name="fechaInicio">
                            </div>
                            <div class="form-group">
                                <label for="fechaFin">Fecha Fin:</label>
                                <input type="date" class="form-control form-control-sm" id="fechaFin" name="fechaFin">
                            </div>
                            <div class="form-group">
                                <label for="estado">Estado:</label>
                                <select class="form-control form-control-sm" id="estado" name="estado">
                                    <option value="">Todos</option>
                                    <option value="activa">Activas</option>
                                    <option value="cerrada">Cerradas</option>
                                    <option value="pausada">Pausadas</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-filtro btn-block btn-sm">
                                <i class="fas fa-search mr-1"></i>Aplicar Filtros
                            </button>
                        </form>
                    </div>
                </div>

                <!-- Resumen rápido -->
                <div class="card report-card mt-3">
                    <div class="card-header">
                        <h6 class="mb-0">
                            <i class="fas fa-info-circle mr-2"></i>Resumen del Mes
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="mb-2">
                            <small class="text-muted">Promedio postulaciones:</small>
                            <div class="font-weight-bold"><%= promedioPostulaciones != null ? promedioPostulaciones : "0.0" %> por oferta</div>
                        </div>
                        <div class="mb-2">
                            <small class="text-muted">Tasa de respuesta:</small>
                            <div class="font-weight-bold"><%= tasaRespuesta != null ? tasaRespuesta : 0 %>%</div>
                        </div>
                        <div class="mb-2">
                            <small class="text-muted">Estado general:</small>
                            <div class="font-weight-bold">Bueno</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal para reporte personalizado -->
    <div class="modal fade" id="modalPersonalizado" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-cog mr-2"></i>Configurar Reporte Personalizado
                    </h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>
                <form method="post">
                    <div class="modal-body">
                        <input type="hidden" name="accion" value="generar">
                        <input type="hidden" name="tipo" value="personalizado">
                        
                        <div class="form-group">
                            <label>Incluir en el reporte:</label>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="incluirOfertas" checked>
                                <label class="form-check-label" for="incluirOfertas">
                                    Ofertas publicadas
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="incluirPostulaciones" checked>
                                <label class="form-check-label" for="incluirPostulaciones">
                                    Postulaciones recibidas
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="incluirEstadisticas">
                                <label class="form-check-label" for="incluirEstadisticas">
                                    Estadísticas detalladas
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="formatoReporte">Formato:</label>
                            <select class="form-control" id="formatoReporte" name="formato">
                                <option value="pdf">PDF</option>
                                <option value="excel">Excel</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-filtro" data-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-generar">
                            <i class="fas fa-download mr-1"></i>Generar Reporte
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Establecer fechas por defecto
        const hoy = new Date();
        const mesAnterior = new Date(hoy.getFullYear(), hoy.getMonth() - 1, hoy.getDate());
        
        document.getElementById('fechaInicio').value = mesAnterior.toISOString().split('T')[0];
        document.getElementById('fechaFin').value = hoy.toISOString().split('T')[0];

        // Auto-ocultar alertas
        setTimeout(function() {
            $('.alert').fadeOut('slow');
        }, 5000);
    </script>
</body>
</html>l>>