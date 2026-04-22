<%-- 
    Document   : usuarios
    Created on : 9 jul. 2025, 2:18:08 p. m.
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Usuario" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Usuarios - Panel Administrativo</title>
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

        .user-card {
            background: var(--white);
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1rem;
            border: 1px solid #e2e8f0;
            transition: all 0.2s ease;
        }

        .user-card:hover {
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transform: translateY(-1px);
        }

        .user-avatar {
            width: 50px;
            height: 50px;
            background: var(--lighter-blue);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            color: var(--primary-blue);
            font-weight: bold;
        }

        .user-type-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .badge-admin {
            background-color: #fee2e2;
            color: #dc2626;
        }

        .badge-estudiante {
            background-color: #ecfdf5;
            color: #059669;
        }

        .badge-empresa {
            background-color: #fef3c7;
            color: #d97706;
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

        .table-responsive {
            border-radius: 8px;
            overflow: hidden;
        }

        .table {
            margin-bottom: 0;
        }

        .table th {
            background-color: var(--lighter-blue);
            color: var(--primary-blue);
            font-weight: 600;
            border: none;
        }

        .table td {
            border-color: #e2e8f0;
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
                        <li><a href="<%= request.getContextPath() %>/admin/usuarios" class="active"><i class="fas fa-users"></i> Usuarios</a></li>
                        <li><a href="<%= request.getContextPath() %>/admin/estudiantes"><i class="fas fa-user-graduate"></i> Estudiantes</a></li>
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
                        <h2><i class="fas fa-users"></i> Gestión de Usuarios</h2>
                        <button class="btn btn-admin" data-bs-toggle="modal" data-bs-target="#modalNuevoUsuario">
                            <i class="fas fa-plus"></i> Nuevo Usuario
                        </button>
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
                        <div class="col-md-3">
                            <div class="stats-card">
                                <div class="stat-number"><%= request.getAttribute("totalUsuarios") %></div>
                                <div class="stat-label">Total Usuarios</div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-card">
                                <div class="stat-number"><%= request.getAttribute("totalEstudiantes") %></div>
                                <div class="stat-label">Estudiantes</div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-card">
                                <div class="stat-number"><%= request.getAttribute("totalEmpresas") %></div>
                                <div class="stat-label">Empresas</div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-card">
                                <div class="stat-number"><%= request.getAttribute("totalAdmins") %></div>
                                <div class="stat-label">Administradores</div>
                            </div>
                        </div>
                    </div>

                    <!-- Filtros -->
                    <div class="filter-section">
                        <form method="GET" action="<%= request.getContextPath() %>/admin/usuarios">
                            <div class="row">
                                <div class="col-md-4">
                                    <label class="form-label"><strong>Buscar:</strong></label>
                                    <input type="text" class="form-control" name="busqueda" 
                                           value="<%= request.getAttribute("busqueda") != null ? request.getAttribute("busqueda") : "" %>"
                                           placeholder="Usuario o email...">
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label"><strong>Tipo de Usuario:</strong></label>
                                    <select class="form-control" name="tipo">
                                        <option value="todos">Todos los tipos</option>
                                        <option value="admin" <%= "admin".equals(request.getAttribute("filtroTipo")) ? "selected" : "" %>>Administradores</option>
                                        <option value="estudiante" <%= "estudiante".equals(request.getAttribute("filtroTipo")) ? "selected" : "" %>>Estudiantes</option>
                                        <option value="empresa" <%= "empresa".equals(request.getAttribute("filtroTipo")) ? "selected" : "" %>>Empresas</option>
                                    </select>
                                </div>
                                <div class="col-md-3 d-flex align-items-end">
                                    <button type="submit" class="btn btn-admin me-2">
                                        <i class="fas fa-search"></i> Filtrar
                                    </button>
                                    <a href="<%= request.getContextPath() %>/admin/usuarios" class="btn btn-outline-secondary">
                                        <i class="fas fa-times"></i> Limpiar
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>

                    <!-- Lista de Usuarios -->
                    <div class="content-card">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Usuario</th>
                                        <th>Email</th>
                                        <th>Tipo</th>
                                        <th>Fecha Registro</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        List<Usuario> usuarios = (List<Usuario>) request.getAttribute("usuarios");
                                        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                                        
                                        if (usuarios != null && !usuarios.isEmpty()) {
                                            for (Usuario user : usuarios) {
                                                String badgeClass = "";
                                                switch (user.getTipoUsuario().toLowerCase()) {
                                                    case "admin":
                                                        badgeClass = "badge-admin";
                                                        break;
                                                    case "estudiante":
                                                        badgeClass = "badge-estudiante";
                                                        break;
                                                    case "empresa":
                                                        badgeClass = "badge-empresa";
                                                        break;
                                                }
                                    %>
                                    <tr>
                                        <td><%= user.getIdUsuario() %></td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="user-avatar me-3">
                                                    <%= user.getUsername().substring(0, 1).toUpperCase() %>
                                                </div>
                                                <strong><%= user.getUsername() %></strong>
                                            </div>
                                        </td>
                                        <td><%= user.getEmail() %></td>
                                        <td>
                                            <span class="user-type-badge <%= badgeClass %>">
                                                <%= user.getTipoUsuario().substring(0, 1).toUpperCase() + user.getTipoUsuario().substring(1) %>
                                            </span>
                                        </td>
                                        <td><%= user.getFechaRegistro() != null ? sdf.format(user.getFechaRegistro()) : "N/A" %></td>
                                        <td>
                                            <button class="btn btn-edit me-1" 
                                                    onclick="editarUsuario(<%= user.getIdUsuario() %>, '<%= user.getEmail() %>', '<%= user.getTipoUsuario() %>')">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <% if (!"admin".equals(user.getTipoUsuario())) { %>
                                            <button class="btn btn-delete" 
                                                    onclick="eliminarUsuario(<%= user.getIdUsuario() %>, '<%= user.getUsername() %>')">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                            <% } %>
                                        </td>
                                    </tr>
                                    <%
                                            }
                                        } else {
                                    %>
                                    <tr>
                                        <td colspan="6" class="text-center text-muted">
                                            <i class="fas fa-users fa-3x mb-3"></i><br>
                                            No se encontraron usuarios
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Nuevo Usuario -->
    <div class="modal fade" id="modalNuevoUsuario" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Crear Nuevo Usuario</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form method="POST" action="<%= request.getContextPath() %>/admin/usuarios">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="editar">
                        <input type="hidden" name="idUsuario" id="editIdUsuario">
                        
                        <div class="mb-3">
                            <label class="form-label">Email:</label>
                            <input type="email" class="form-control" name="email" id="editEmail" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Tipo de Usuario:</label>
                            <select class="form-control" name="tipoUsuario" id="editTipoUsuario" required>
                                <option value="admin">Administrador</option>
                                <option value="estudiante">Estudiante</option>
                                <option value="empresa">Empresa</option>
                            </select>
                        </div>
                        
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle"></i>
                            <small>El nombre de usuario no se puede modificar por seguridad.</small>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-admin">Actualizar Usuario</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editarUsuario(id, email, tipo) {
            document.getElementById('editIdUsuario').value = id;
            document.getElementById('editEmail').value = email;
            document.getElementById('editTipoUsuario').value = tipo;
            
            const modal = new bootstrap.Modal(document.getElementById('modalEditarUsuario'));
            modal.show();
        }

        function eliminarUsuario(id, username) {
            if (confirm('¿Estás seguro de que deseas eliminar el usuario "' + username + '"?\n\nEsta acción no se puede deshacer.')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '<%= request.getContextPath() %>/admin/usuarios';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'eliminar';
                
                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'idUsuario';
                idInput.value = id;
                
                form.appendChild(actionInput);
                form.appendChild(idInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        // Validación en tiempo real del formulario
        document.addEventListener('DOMContentLoaded', function() {
            const usernameInput = document.querySelector('input[name="username"]');
            const emailInput = document.querySelector('input[name="email"]');
            
            if (usernameInput) {
                usernameInput.addEventListener('input', function() {
                    const value = this.value;
                    const regex = /^[a-zA-Z0-9._-]+$/;
                    
                    if (value && !regex.test(value)) {
                        this.setCustomValidity('Solo se permiten letras, números, puntos, guiones y guiones bajos');
                    } else if (value && value.length < 3) {
                        this.setCustomValidity('El nombre de usuario debe tener al menos 3 caracteres');
                    } else {
                        this.setCustomValidity('');
                    }
                });
            }
            
            if (emailInput) {
                emailInput.addEventListener('input', function() {
                    const value = this.value;
                    const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    
                    if (value && !regex.test(value)) {
                        this.setCustomValidity('Ingresa un email válido');
                    } else {
                        this.setCustomValidity('');
                    }
                });
            }
        });

        // Auto-cerrar alertas después de 5 segundos
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
    </script>
</body>
</html>>/admin/usuarios">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="crear">
                        
                        <div class="mb-3">
                            <label class="form-label">Nombre de Usuario:</label>
                            <input type="text" class="form-control" name="username" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Email:</label>
                            <input type="email" class="form-control" name="email" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Contraseña:</label>
                            <input type="password" class="form-control" name="password" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Tipo de Usuario:</label>
                            <select class="form-control" name="tipoUsuario" required>
                                <option value="">Seleccionar tipo</option>
                                <option value="admin">Administrador</option>
                                <option value="estudiante">Estudiante</option>
                                <option value="empresa">Empresa</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-admin">Crear Usuario</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    