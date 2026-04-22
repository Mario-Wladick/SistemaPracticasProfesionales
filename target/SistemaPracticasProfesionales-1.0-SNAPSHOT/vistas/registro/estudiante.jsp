<%-- 
    Document   : estudiante
    Created on : 22 may. 2025, 4:51:40 p. m.
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Estudiante - Sistema de Prácticas Profesionales</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/recursos/css/styles.css">
    <style>
        .register-container {
            min-height: 100vh;
            background: linear-gradient(135deg, #1e3a8a 0%, #3b82f6 50%, #0ea5e9 100%);
            padding: 2rem 0;
        }
        .register-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .register-header {
            background: linear-gradient(135deg, #1e3a8a, #3b82f6);
            color: white;
            padding: 1.5rem;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="register-card">
                        <div class="register-header">
                            <h3 class="mb-0">
                                <i class="fas fa-user-graduate"></i> 
                                Registro de Estudiante
                            </h3>
                            <p class="mb-0 mt-2">Completa tus datos para unirte a la comunidad</p>
                        </div>
                        <div class="card-body p-4">
                            <!-- Mostrar mensajes de error -->
                            <% if (request.getAttribute("error") != null) { %>
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="fas fa-exclamation-triangle"></i> <%= request.getAttribute("error") %>
                                    <button type="button" class="close" data-dismiss="alert">
                                        <span>&times;</span>
                                    </button>
                                </div>
                            <% } %>
                            
                            <!-- Formulario de registro -->
                            <form action="<%= request.getContextPath() %>/registro/estudiante" method="post">
                                <div class="row">
                                    <!-- Información de acceso -->
                                    <div class="col-md-6">
                                        <h5 class="text-primary mb-3"><i class="fas fa-key"></i> Información de Acceso</h5>
                                        
                                        <div class="form-group">
                                            <label for="username" class="font-weight-bold">Usuario *</label>
                                            <input type="text" class="form-control" id="username" name="username" required>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="password" class="font-weight-bold">Contraseña *</label>
                                            <input type="password" class="form-control" id="password" name="password" required>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="confirmPassword" class="font-weight-bold">Confirmar Contraseña *</label>
                                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                                        </div>
                                    </div>
                                    
                                    <!-- Información personal -->
                                    <div class="col-md-6">
                                        <h5 class="text-primary mb-3"><i class="fas fa-user"></i> Información Personal</h5>
                                        
                                        <div class="form-group">
                                            <label for="codigoUniversitario" class="font-weight-bold">Código Universitario *</label>
                                            <input type="text" class="form-control" id="codigoUniversitario" name="codigoUniversitario" 
       minlength="6" maxlength="10" 
       pattern="[0-9]{6,10}" 
       title="El código debe tener entre 6 y 10 dígitos" 
       required>
<small class="form-text text-muted">Ingresa tu código universitario (6 a 10 dígitos)</small>

                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="nombres" class="font-weight-bold">Nombres *</label>
                                            <input type="text" class="form-control" id="nombres" name="nombres" required>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="apellidos" class="font-weight-bold">Apellidos *</label>
                                            <input type="text" class="form-control" id="apellidos" name="apellidos" required>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <!-- Información de contacto -->
                                    <div class="col-md-6">
                                        <h5 class="text-primary mb-3"><i class="fas fa-address-book"></i> Información de Contacto</h5>
                                        
                                        <div class="form-group">
                                            <label for="dni" class="font-weight-bold">DNI *</label>
                                            <input type="text" class="form-control" id="dni" name="dni" maxlength="8" required>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="email" class="font-weight-bold">Email *</label>
                                            <input type="email" class="form-control" id="email" name="email" required>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="telefono" class="font-weight-bold">Teléfono</label>
                                            <input type="text" class="form-control" id="telefono" name="telefono">
                                        </div>
                                    </div>
                                    
                                    <!-- Información académica -->
                                    <div class="col-md-6">
                                        <h5 class="text-primary mb-3"><i class="fas fa-graduation-cap"></i> Información Académica</h5>
                                        
                                        <div class="form-group">
                                            <label for="especialidad" class="font-weight-bold">Especialidad *</label>
                                            <select class="form-control" id="especialidad" name="especialidad" required>
                                                <option value="">Selecciona una especialidad</option>
                                                <option value="ESTADISTICA">Estadística</option>
                                                <option value="INFORMATICA">Informática</option>
                                                <option value="AMBAS">Ambas</option>
                                            </select>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="ciclo" class="font-weight-bold">Ciclo Actual</label>
                                            <select class="form-control" id="ciclo" name="ciclo">
                                                <option value="">Selecciona tu ciclo</option>
                                                <option value="1">1er Ciclo</option>
                                                <option value="2">2do Ciclo</option>
                                                <option value="3">3er Ciclo</option>
                                                <option value="4">4to Ciclo</option>
                                                <option value="5">5to Ciclo</option>
                                                <option value="6">6to Ciclo</option>
                                                <option value="7">7mo Ciclo</option>
                                                <option value="8">8vo Ciclo</option>
                                                <option value="9">9no Ciclo</option>
                                                <option value="10">10mo Ciclo</option>
                                            </select>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="promedio" class="font-weight-bold">Promedio Ponderado</label>
                                            <input type="number" class="form-control" id="promedio" name="promedio" 
                                                   min="0" max="20" step="0.01" placeholder="0.00">
                                        </div>
                                    </div>
                                </div>
                                
                                <hr>
                                
                                <div class="row">
                                    <div class="col-12">
                                        <div class="form-group text-center">
                                            <button type="submit" class="btn btn-primary btn-lg mr-3">
                                                <i class="fas fa-user-plus"></i> Registrarse
                                            </button>
                                            <a href="<%= request.getContextPath() %>/" class="btn btn-secondary btn-lg">
                                                <i class="fas fa-arrow-left"></i> Cancelar
                                            </a>
                                        </div>
                                        
                                        <div class="text-center">
                                            <p class="text-muted">¿Ya tienes una cuenta? 
                                                <a href="<%= request.getContextPath() %>/login">Iniciar Sesión</a>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </form>
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
        // Validación de confirmación de contraseña
        document.getElementById('confirmPassword').addEventListener('input', function() {
            var password = document.getElementById('password').value;
            var confirmPassword = this.value;
            
            if (password !== confirmPassword) {
                this.setCustomValidity('Las contraseñas no coinciden');
            } else {
                this.setCustomValidity('');
            }
        });
        // NUEVO: Validación del código universitario
document.getElementById('codigoUniversitario').addEventListener('input', function() {
    var codigo = this.value;
    
    // Solo permitir números
    this.value = codigo.replace(/[^0-9]/g, '');
    
    // Validar longitud
    if (this.value.length < 6) {
        this.setCustomValidity('El código debe tener al menos 6 dígitos');
    } else if (this.value.length > 10) {
        this.setCustomValidity('El código no puede tener más de 10 dígitos');
    } else {
        this.setCustomValidity('');
    }
});

// Validación al enviar el formulario
document.querySelector('form').addEventListener('submit', function(e) {
    var codigo = document.getElementById('codigoUniversitario').value;
    
    if (codigo.length < 6 || codigo.length > 10) {
        e.preventDefault();
        alert('El código universitario debe tener entre 6 y 10 dígitos');
        document.getElementById('codigoUniversitario').focus();
        return false;
    }
});
    </script>
</body>
</html>