<%-- 
    Document   : perfil
    Created on : 9 jul. 2025, 11:47:16 a. m.
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Estudiante" %>
<%@ page import="modelo.Usuario" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi Perfil - Sistema de Prácticas</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        .profile-card {
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
        
        .progress-card {
            background: rgba(255, 255, 255, 0.9);
            color: #374151;
            border: 1px solid rgba(59, 130, 246, 0.2);
            border-left: 4px solid #3b82f6;
            border-radius: 15px;
            padding: 20px;
            backdrop-filter: blur(10px);
        }
        
        .btn-actualizar {
            background: rgba(255, 255, 255, 0.9);
            border: 1px solid rgba(59, 130, 246, 0.3);
            color: #374151;
            padding: 12px 30px;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-actualizar:hover {
            background: rgba(255, 255, 255, 1);
            border-color: rgba(59, 130, 246, 0.5);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(59, 130, 246, 0.15);
            color: #374151;
        }
        
        .form-control {
            border: 1px solid rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.9);
        }
        
        .form-control:focus {
            border-color: rgba(59, 130, 246, 0.3);
            box-shadow: 0 0 0 0.2rem rgba(59, 130, 246, 0.1);
            background: rgba(255, 255, 255, 1);
        }
        
        .section-title {
            color: #374151;
            border-bottom: 2px solid #e5e7eb;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        
        .alert {
            background: rgba(255, 255, 255, 0.9);
            border: 1px solid rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(5px);
            border-radius: 10px;
        }
        
        .alert-success {
            background: rgba(240, 253, 244, 0.8);
            border-color: rgba(16, 185, 129, 0.3);
            color: #065f46;
        }
        
        .alert-danger {
            background: rgba(254, 242, 242, 0.8);
            border-color: rgba(239, 68, 68, 0.3);
            color: #991b1b;
        }
        
        .alert-warning {
            background: rgba(254, 243, 199, 0.8);
            border-color: rgba(245, 158, 11, 0.3);
            color: #92400e;
        }
        
        .alert-light {
            background: rgba(248, 250, 252, 0.9);
            border-color: rgba(203, 213, 225, 0.5);
            color: #374151;
        }
        
        .card-header.bg-light {
            background: rgba(248, 250, 252, 0.9) !important;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            color: #374151;
        }
        
        .progress {
            background: rgba(0, 0, 0, 0.1);
        }
        
        .progress-bar.bg-light {
            background: #3b82f6 !important;
        }
        
        .btn-secondary {
            background: rgba(255, 255, 255, 0.9);
            border: 1px solid rgba(0, 0, 0, 0.1);
            color: #374151;
        }
        
        .btn-secondary:hover {
            background: rgba(248, 250, 252, 1);
            border-color: rgba(0, 0, 0, 0.2);
            color: #374151;
        }
    </style>
</head>
<body class="bg-light">
    <%
        Estudiante estudiante = (Estudiante) request.getAttribute("estudiante");
        Usuario usuario = (Usuario) request.getAttribute("usuario");
        Integer completitudPerfil = (Integer) request.getAttribute("completitudPerfil");
        Boolean perfilCompleto = (Boolean) request.getAttribute("perfilCompleto");
        String error = (String) request.getAttribute("error");
        String mensaje = (String) request.getAttribute("mensaje");
    %>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="<%= request.getContextPath() %>/estudiante/dashboard">
                <i class="fas fa-graduation-cap"></i> Mi Perfil
            </a>
            <div class="navbar-nav ml-auto">
                <a class="nav-link text-white" href="<%= request.getContextPath() %>/estudiante/dashboard">
                    <i class="fas fa-arrow-left"></i> Volver al Dashboard
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
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
            <!-- Información del perfil -->
            <div class="col-lg-4 mb-4">
                <!-- Progreso del perfil -->
                <div class="progress-card mb-4">
                    <div class="text-center">
                        <i class="fas fa-user-circle fa-3x mb-3"></i>
                        <h5>
                            <% if (estudiante != null) { %>
                                <%= estudiante.getNombres() != null ? estudiante.getNombres() : "Estudiante" %>
                                <%= estudiante.getApellidos() != null ? estudiante.getApellidos() : "" %>
                            <% } else { %>
                                Estudiante
                            <% } %>
                        </h5>
                        <p class="mb-3">
                            Código: <%= estudiante != null && estudiante.getCodigoUniversitario() != null ? 
                                      estudiante.getCodigoUniversitario() : "N/A" %>
                        </p>
                        
                        <div class="mb-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <span>Completitud del perfil</span>
                                <span class="font-weight-bold"><%= completitudPerfil != null ? completitudPerfil : 0 %>%</span>
                            </div>
                            <div class="progress" style="height: 8px; background: rgba(255,255,255,0.3);">
                                <div class="progress-bar bg-light" 
                                     style="width: <%= completitudPerfil != null ? completitudPerfil : 0 %>%"></div>
                            </div>
                        </div>
                        
                        <% if (perfilCompleto != null && perfilCompleto) { %>
                            <div class="alert alert-light mb-0">
                                <i class="fas fa-check-circle"></i> ¡Perfil completo!
                            </div>
                        <% } else { %>
                            <div class="alert alert-warning mb-0">
                                <i class="fas fa-exclamation-triangle"></i> Completa tu perfil para mejores oportunidades
                            </div>
                        <% } %>
                    </div>
                </div>

                <!-- Información rápida -->
                <div class="card profile-card">
                    <div class="card-header bg-light">
                        <h6 class="mb-0">
                            <i class="fas fa-info-circle"></i> Información Rápida
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="mb-2">
                            <small class="text-muted">Email:</small>
                            <div class="font-weight-bold">
                                <%= estudiante != null && estudiante.getEmail() != null ? 
                                    estudiante.getEmail() : "No especificado" %>
                            </div>
                        </div>
                        <div class="mb-2">
                            <small class="text-muted">Especialidad:</small>
                            <div class="font-weight-bold">
                                <%= estudiante != null && estudiante.getEspecialidad() != null ? 
                                    estudiante.getEspecialidad() : "No especificada" %>
                            </div>
                        </div>
                        <div class="mb-2">
                            <small class="text-muted">Ciclo:</small>
                            <div class="font-weight-bold">
                                <%= estudiante != null && estudiante.getCiclo() > 0 ? 
                                    estudiante.getCiclo() + "° Ciclo" : "No especificado" %>
                            </div>
                        </div>
                        <div class="mb-2">
                            <small class="text-muted">Promedio:</small>
                            <div class="font-weight-bold">
                                <%= estudiante != null && estudiante.getPromedioPonderado() > 0 ? 
                                    String.format("%.2f", estudiante.getPromedioPonderado()) : "No especificado" %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Formulario de edición -->
            <div class="col-lg-8">
                <div class="card profile-card">
                    <div class="card-header bg-light">
                        <h5 class="mb-0">
                            <i class="fas fa-edit"></i> Editar Mi Perfil
                        </h5>
                    </div>
                    <div class="card-body">
                        <form method="post">
                            <!-- Información Personal -->
                            <h5 class="section-title">
                                <i class="fas fa-user"></i> Información Personal
                            </h5>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="nombres" class="form-label">Nombres *</label>
                                    <input type="text" class="form-control" id="nombres" name="nombres" required
                                           value="<%= estudiante != null && estudiante.getNombres() != null ? estudiante.getNombres() : "" %>">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="apellidos" class="form-label">Apellidos *</label>
                                    <input type="text" class="form-control" id="apellidos" name="apellidos" required
                                           value="<%= estudiante != null && estudiante.getApellidos() != null ? estudiante.getApellidos() : "" %>">
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="dni" class="form-label">DNI</label>
                                    <input type="text" class="form-control" id="dni" name="dni" maxlength="8"
                                           value="<%= estudiante != null && estudiante.getDni() != null ? estudiante.getDni() : "" %>">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="telefono" class="form-label">Teléfono</label>
                                    <input type="tel" class="form-control" id="telefono" name="telefono"
                                           value="<%= estudiante != null && estudiante.getTelefono() != null ? estudiante.getTelefono() : "" %>">
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="email" class="form-label">Email *</label>
                                <input type="email" class="form-control" id="email" name="email" required
                                       value="<%= estudiante != null && estudiante.getEmail() != null ? estudiante.getEmail() : "" %>">
                            </div>

                            <!-- Información Académica -->
                            <h5 class="section-title">
                                <i class="fas fa-graduation-cap"></i> Información Académica
                            </h5>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="especialidad" class="form-label">Especialidad *</label>
                                    <select class="form-control" id="especialidad" name="especialidad" required>
                                        <option value="">Seleccionar especialidad</option>
                                        <option value="Ingeniería de Sistemas" 
                                                <%= (estudiante != null && "Ingeniería de Sistemas".equals(estudiante.getEspecialidad())) ? "selected" : "" %>>
                                            Ingeniería de Sistemas
                                        </option>
                                        <option value="Ingeniería de Software" 
                                                <%= (estudiante != null && "Ingeniería de Software".equals(estudiante.getEspecialidad())) ? "selected" : "" %>>
                                            Ingeniería de Software
                                        </option>
                                        <option value="Ciencias de la Computación" 
                                                <%= (estudiante != null && "Ciencias de la Computación".equals(estudiante.getEspecialidad())) ? "selected" : "" %>>
                                            Ciencias de la Computación
                                        </option>
                                        <option value="Ingeniería Informática" 
                                                <%= (estudiante != null && "Ingeniería Informática".equals(estudiante.getEspecialidad())) ? "selected" : "" %>>
                                            Ingeniería Informática
                                        </option>
                                        <option value="Estadística e Informática" 
                                                <%= (estudiante != null && "Estadística e Informática".equals(estudiante.getEspecialidad())) ? "selected" : "" %>>
                                            Estadística e Informática
                                        </option>
                                    </select>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="ciclo" class="form-label">Ciclo *</label>
                                    <select class="form-control" id="ciclo" name="ciclo" required>
                                        <option value="">Seleccionar ciclo</option>
                                        <% for (int i = 1; i <= 10; i++) { %>
                                            <option value="<%= i %>" 
                                                    <%= (estudiante != null && estudiante.getCiclo() == i) ? "selected" : "" %>>
                                                <%= i %>° Ciclo
                                            </option>
                                        <% } %>
                                    </select>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label for="promedio" class="form-label">Promedio Ponderado</label>
                                <input type="number" class="form-control" id="promedio" name="promedio" 
                                       step="0.01" min="0" max="20"
                                       value="<%= estudiante != null && estudiante.getPromedioPonderado() > 0 ? 
                                                 String.format("%.2f", estudiante.getPromedioPonderado()) : "" %>"
                                       placeholder="Ej: 16.50">
                                <small class="form-text text-muted">Ingresa tu promedio ponderado actual (0.00 - 20.00)</small>
                            </div>

                            <!-- Información adicional solo lectura -->
                            <h5 class="section-title">
                                <i class="fas fa-info-circle"></i> Información del Sistema
                            </h5>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Código Universitario</label>
                                    <input type="text" class="form-control" readonly
                                           value="<%= estudiante != null && estudiante.getCodigoUniversitario() != null ? 
                                                     estudiante.getCodigoUniversitario() : "No asignado" %>">
                                    <small class="form-text text-muted">Este campo lo asigna el sistema</small>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">ID de Usuario</label>
                                    <input type="text" class="form-control" readonly
                                           value="<%= estudiante != null ? String.valueOf(estudiante.getIdUsuario()) : "N/A" %>">
                                    <small class="form-text text-muted">Identificador interno del sistema</small>
                                </div>
                            </div>

                            <!-- Botones -->
                            <div class="text-center">
                                <button type="submit" class="btn btn-actualizar btn-lg mr-3">
                                    <i class="fas fa-save"></i> Actualizar Perfil
                                </button>
                                <a href="<%= request.getContextPath() %>/estudiante/dashboard" class="btn btn-secondary btn-lg">
                                    <i class="fas fa-times"></i> Cancelar
                                </a>
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
        // Auto-ocultar alertas
        setTimeout(function() {
            $('.alert').fadeOut('slow');
        }, 5000);
    </script>
</body>
</html>