<%-- 
    Document   : nueva-oferta
    Created on : 9 jul. 2025, 11:19:02 a. m.
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Empresa" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nueva Oferta - Sistema de Prácticas</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        .form-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
        }
        body.bg-light {
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            min-height: 100vh;
        }
        .btn-crear {
            background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 10px;
            font-weight: 600;
        }
        .btn-crear:hover {
            background: linear-gradient(135deg, #2563eb 0%, #1e40af 100%);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(59, 130, 246, 0.3);
        }
    </style>
</head>
<body class="bg-light">
    <%
        Empresa empresa = (Empresa) session.getAttribute("empresa");
        String error = (String) request.getAttribute("error");
        String mensaje = (String) request.getAttribute("mensaje");
    %>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="<%= request.getContextPath() %>/empresa/dashboard">
                <i class="fas fa-building"></i> Panel Empresa
            </a>
            <div class="navbar-nav ml-auto">
                <a class="nav-link text-white" href="<%= request.getContextPath() %>/empresa/dashboard">
                    <i class="fas fa-arrow-left"></i> Volver al Dashboard
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card form-card">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">
                            <i class="fas fa-plus-circle"></i> Crear Nueva Oferta de Práctica
                        </h4>
                    </div>
                    <div class="card-body">
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

                        <!-- Formulario -->
                        <form method="post" action="<%= request.getContextPath() %>/empresa/nueva-oferta">
                            <div class="row">
                                <!-- Información básica -->
                                <div class="col-md-12 mb-3">
                                    <h5 class="text-primary">
                                        <i class="fas fa-info-circle"></i> Información Básica
                                    </h5>
                                    <hr>
                                </div>

                                <div class="col-md-12 mb-3">
                                    <label for="titulo" class="form-label">
                                        <i class="fas fa-heading"></i> Título de la Oferta *
                                    </label>
                                    <input type="text" class="form-control" id="titulo" name="titulo" required
                                           placeholder="Ej: Desarrollador Junior Java">
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label for="area" class="form-label">
                                        <i class="fas fa-tags"></i> Área *
                                    </label>
                                    <select class="form-control" id="area" name="area" required>
                                        <option value="">Seleccionar área</option>
                                        <option value="Desarrollo">Desarrollo</option>
                                        <option value="Análisis">Análisis de Datos</option>
                                        <option value="Base de Datos">Base de Datos</option>
                                        <option value="Redes">Redes y Sistemas</option>
                                        <option value="Ciberseguridad">Ciberseguridad</option>
                                        <option value="IA">Inteligencia Artificial</option>
                                        <option value="QA">Testing y QA</option>
                                        <option value="DevOps">DevOps</option>
                                    </select>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label for="modalidad" class="form-label">
                                        <i class="fas fa-laptop-house"></i> Modalidad *
                                    </label>
                                    <select class="form-control" id="modalidad" name="modalidad" required>
                                        <option value="">Seleccionar modalidad</option>
                                        <option value="Presencial">Presencial</option>
                                        <option value="Remoto">Remoto</option>
                                        <option value="Híbrido">Híbrido</option>
                                    </select>
                                </div>

                                <!-- Descripción -->
                                <div class="col-md-12 mb-3">
                                    <label for="descripcion" class="form-label">
                                        <i class="fas fa-align-left"></i> Descripción de la Práctica *
                                    </label>
                                    <textarea class="form-control" id="descripcion" name="descripcion" rows="4" required
                                              placeholder="Describe las actividades que realizará el practicante..."></textarea>
                                </div>

                                <!-- Requisitos -->
                                <div class="col-md-12 mb-3">
                                    <label for="requisitos" class="form-label">
                                        <i class="fas fa-list-check"></i> Requisitos *
                                    </label>
                                    <textarea class="form-control" id="requisitos" name="requisitos" rows="4" required
                                              placeholder="Conocimientos técnicos, habilidades, experiencia requerida..."></textarea>
                                </div>

                                <!-- Detalles -->
                                <div class="col-md-12 mb-3">
                                    <h5 class="text-primary">
                                        <i class="fas fa-cog"></i> Detalles de la Práctica
                                    </h5>
                                    <hr>
                                </div>

                                <div class="col-md-4 mb-3">
                                    <label for="duracion" class="form-label">
                                        <i class="fas fa-calendar-alt"></i> Duración (meses) *
                                    </label>
                                    <select class="form-control" id="duracion" name="duracion" required>
                                        <option value="">Seleccionar</option>
                                        <option value="3">3 meses</option>
                                        <option value="4">4 meses</option>
                                        <option value="5">5 meses</option>
                                        <option value="6">6 meses</option>
                                        <option value="12">12 meses</option>
                                    </select>
                                </div>

                                <div class="col-md-4 mb-3">
                                    <label for="vacantes" class="form-label">
                                        <i class="fas fa-users"></i> Número de Vacantes *
                                    </label>
                                    <input type="number" class="form-control" id="vacantes" name="vacantes" 
                                           min="1" max="20" required placeholder="1">
                                </div>

                                <div class="col-md-4 mb-3">
                                    <label for="fechaLimite" class="form-label">
                                        <i class="fas fa-calendar-times"></i> Fecha Límite *
                                    </label>
                                    <input type="date" class="form-control" id="fechaLimite" name="fechaLimite" required>
                                </div>

                                <!-- Información adicional -->
                                <div class="col-md-12 mb-4">
                                    <label for="beneficios" class="form-label">
                                        <i class="fas fa-star"></i> Beneficios Adicionales
                                    </label>
                                    <textarea class="form-control" id="beneficios" name="beneficios" rows="2"
                                              placeholder="Estipendio, capacitaciones, certificaciones, etc. (opcional)"></textarea>
                                </div>
                            </div>

                            <!-- Botones -->
                            <div class="row">
                                <div class="col-md-12 text-center">
                                    <button type="submit" class="btn btn-crear btn-lg mr-3">
                                        <i class="fas fa-save"></i> Crear Oferta
                                    </button>
                                    <a href="<%= request.getContextPath() %>/empresa/dashboard" class="btn btn-secondary btn-lg">
                                        <i class="fas fa-times"></i> Cancelar
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Establecer fecha mínima (hoy)
        document.getElementById('fechaLimite').min = new Date().toISOString().split('T')[0];
        
        // Auto-ocultar alertas
        setTimeout(function() {
            $('.alert').fadeOut('slow');
        }, 5000);
    </script>
</body>
</html>