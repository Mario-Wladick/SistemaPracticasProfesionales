<%-- 
    Document   : login
    Created on : 21 may. 2025, 2:55:51 p. m.
    Author     : LENOVO
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Sistema de Prácticas Profesionales</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/recursos/css/styles.css">
    <style>
        .login-container {
            min-height: 100vh;
            background: linear-gradient(135deg, #1e3a8a 0%, #3b82f6 50%, #0ea5e9 100%);
            display: flex;
            align-items: center;
        }
        .login-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .login-header {
            background: linear-gradient(135deg, #1e3a8a, #3b82f6);
            color: white;
            padding: 2rem;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6 col-lg-5">
                    <div class="login-card">
                        <div class="login-header">
                            <h3 class="mb-0">
                                <i class="fas fa-graduation-cap"></i> 
                                Sistema de Prácticas
                            </h3>
                            <p class="mb-0 mt-2">Ingeniería Estadística e Informática</p>
                        </div>
                        <div class="card-body p-4">
                            <!-- Mostrar mensajes de error -->
                            <% if (request.getParameter("logout") != null) { %>
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <i class="fas fa-check-circle"></i> Has cerrado sesión correctamente.
                                    <button type="button" class="close" data-dismiss="alert">
                                        <span>&times;</span>
                                    </button>
                                </div>
                            <% } %>
                            
                            <% if (request.getAttribute("error") != null) { %>
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="fas fa-exclamation-triangle"></i> <%= request.getAttribute("error") %>
                                    <button type="button" class="close" data-dismiss="alert">
                                        <span>&times;</span>
                                    </button>
                                </div>
                            <% } %>
                            
                            <!-- Formulario de login CORREGIDO -->
                             <form action="<%= request.getContextPath() %>/login" method="post">
                             <div class="form-group">
                             <label for="usuario" class="font-weight-bold">
                                  <i class="fas fa-user"></i> Usuario:
                                  </label>
                             <input type="text" class="form-control form-control-lg" id="usuario" name="usuario" 
                                              placeholder="Ingresa tu usuario" required value="<%= request.getAttribute("usuario") != null ? request.getAttribute("usuario") : "" %>">
                                </div>
    
    <div class="form-group">
        <label for="contrasena" class="font-weight-bold">
            <i class="fas fa-lock"></i> Contraseña:
        </label>
        <div class="input-group">
            <input type="password" class="form-control form-control-lg" id="contrasena" name="contrasena" 
                   placeholder="Ingresa tu contraseña" required>
            <div class="input-group-append">
                <button class="btn btn-outline-secondary" type="button" onclick="togglePassword()">
                    <i class="fas fa-eye" id="toggleIcon"></i>
                </button>
            </div>
        </div>
    </div>
    
    <div class="form-group">
        <button type="submit" class="btn btn-primary btn-lg btn-block">
            <i class="fas fa-sign-in-alt"></i> Iniciar Sesión
        </button>
    </div>
</form>
                            <!-- Enlaces adicionales -->
                            <div class="text-center mt-4">
                                <div class="row">
                                    <div class="col-6">
                                        <a href="<%= request.getContextPath() %>/registro/estudiante" class="btn btn-outline-primary btn-sm btn-block">
                                            <i class="fas fa-user-plus"></i> Registrarse como Estudiante
                                        </a>
                                    </div>
                                    <div class="col-6">
                                        <a href="<%= request.getContextPath() %>/registro/empresa" class="btn btn-outline-info btn-sm btn-block">
                                            <i class="fas fa-building"></i> Registrarse como Empresa
                                        </a>
                                    </div>
                                </div>
                                <hr>
                                <div class="mt-3">
                                    <a href="<%= request.getContextPath() %>/" class="btn btn-link">
                                        <i class="fas fa-arrow-left"></i> Volver al Inicio
                                    </a>
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
       function togglePassword() {
    var passwordInput = document.getElementById("contrasena"); // Cambié de "password" a "contrasena"
    var toggleIcon = document.getElementById("toggleIcon");
    
    if (passwordInput.type === "password") {
        passwordInput.type = "text";
        toggleIcon.className = "fas fa-eye-slash";
    } else {
        passwordInput.type = "password";
        toggleIcon.className = "fas fa-eye";
    }
}
    </script>
</body>
</html>