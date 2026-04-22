<%-- 
    Document   : empresa
    Created on : 22 may. 2025, 4:54:30 p. m.
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Empresa - Sistema de Prácticas Profesionales</title>
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
            background: linear-gradient(135deg, #0ea5e9, #2563eb);
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
                                <i class="fas fa-building"></i> 
                                Registro de Empresa
                            </h3>
                            <p class="mb-0 mt-2">Únete como empresa y encuentra talento calificado</p>
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
                            <form action="<%= request.getContextPath() %>/registro/empresa" method="post">
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
                                    
                                    <!-- Información de la empresa -->
                                    <div class="col-md-6">
                                        <h5 class="text-primary mb-3"><i class="fas fa-building"></i> Información de la Empresa</h5>
                                        
                                        <div class="form-group">
                                            <label for="razonSocial" class="font-weight-bold">Razón Social *</label>
                                            <input type="text" class="form-control" id="razonSocial" name="razonSocial" required>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="ruc" class="font-weight-bold">RUC *</label>
                                            <input type="text" class="form-control" id="ruc" name="ruc" maxlength="11" required>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="descripcion" class="font-weight-bold">Descripción de la Empresa</label>
                                            <textarea class="form-control" id="descripcion" name="descripcion" rows="3" 
                                                    placeholder="Describe brevemente tu empresa..."></textarea>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <!-- Información de contacto -->
                                    <div class="col-md-6">
                                        <h5 class="text-primary mb-3"><i class="fas fa-address-book"></i> Información de Contacto</h5>
                                        
                                        <div class="form-group">
                                            <label for="emailContacto" class="font-weight-bold">Email de Contacto *</label>
                                            <input type="email" class="form-control" id="emailContacto" name="emailContacto" required>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="telefono" class="font-weight-bold">Teléfono</label>
                                            <input type="text" class="form-control" id="telefono" name="telefono">
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="direccion" class="font-weight-bold">Dirección</label>
                                            <input type="text" class="form-control" id="direccion" name="direccion">
                                        </div>
                                    </div>
                                    
                                    <!-- Información adicional -->
                                    <div class="col-md-6">
                                        <h5 class="text-primary mb-3"><i class="fas fa-globe"></i> Información Adicional</h5>
                                        
                                        <div class="form-group">
                                            <label for="sitioWeb" class="font-weight-bold">Sitio Web</label>
                                            <input type="url" class="form-control" id="sitioWeb" name="sitioWeb" 
                                                   placeholder="https://www.ejemplo.com">
                                        </div>
                                        
                                        <div class="alert alert-info">
                                            <i class="fas fa-info-circle"></i>
                                            <strong>Nota:</strong> Tu registro será revisado por nuestro equipo. 
                                            Recibirás una confirmación por email una vez aprobado.
                                        </div>
                                    </div>
                                </div>
                                
                                <hr>
                                
                                <div class="row">
                                    <div class="col-12">
                                        <div class="form-group text-center">
                                            <button type="submit" class="btn btn-info btn-lg mr-3">
                                                <i class="fas fa-building"></i> Registrar Empresa
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
        
        // Validación de RUC (11 dígitos)
        document.getElementById('ruc').addEventListener('input', function() {
            var ruc = this.value;
            if (ruc.length > 0 && (ruc.length !== 11 || !/^\d+$/.test(ruc))) {
                this.setCustomValidity('El RUC debe tener exactamente 11 dígitos');
            } else {
                this.setCustomValidity('');
            }
        });
    </script>
</body>
</html>