<%-- 
    Document   : index
    Created on : 22 may. 2025, 11:18:33?a. m.
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema de Prácticas Profesionales</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/recursos/css/styles.css">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="<%= request.getContextPath() %>/">
                <i class="fas fa-graduation-cap"></i> Sistema de Prácticas FINESI
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <div class="ml-auto">
                    <% if (session.getAttribute("usuario") == null) { %>
                        <a href="<%= request.getContextPath() %>/login" class="btn btn-outline-light mr-2">
                            <i class="fas fa-sign-in-alt"></i> Iniciar Sesión
                        </a>
                        <div class="btn-group">
                            <button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown">
                                <i class="fas fa-user-plus"></i> Registrarse
                            </button>
                            <div class="dropdown-menu">
                                <a class="dropdown-item" href="<%= request.getContextPath() %>/registro/estudiante">
                                    <i class="fas fa-user-graduate"></i> Como Estudiante
                                </a>
                                <a class="dropdown-item" href="<%= request.getContextPath() %>/registro/empresa">
                                    <i class="fas fa-building"></i> Como Empresa
                                </a>
                            </div>
                        </div>
                    <% } else { %>
                        <a href="<%= request.getContextPath() %>/logout" class="btn btn-outline-light">
                            <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
                        </a>
                    <% } %>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section text-white py-5">
        <div class="container text-center">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h1 class="display-4 font-weight-bold mb-4">Sistema de Prácticas Profesionales</h1>
                    <p class="lead mb-2">Facultad de Ingeniería Estadística e Informática</p>
                    <p class="mb-4">Conectamos estudiantes con oportunidades profesionales en empresas líderes del mercado</p>
                    <div class="cta-buttons">
                        <% if (session.getAttribute("usuario") == null) { %>
                            <a href="<%= request.getContextPath() %>/login" class="btn btn-light btn-lg mr-3">
                                <i class="fas fa-sign-in-alt"></i> Iniciar Sesión
                            </a>
                            <a href="#registro" class="btn btn-outline-light btn-lg">
                                <i class="fas fa-user-plus"></i> Registrarse
                            </a>
                        <% } else { %>
                            <a href="<%= request.getContextPath() %>/estudiante/dashboard" class="btn btn-light btn-lg mr-3">
                                <i class="fas fa-tachometer-alt"></i> Mi Dashboard
                            </a>
                            <a href="<%= request.getContextPath() %>/estudiante/ofertas" class="btn btn-outline-light btn-lg">
                                <i class="fas fa-briefcase"></i> Ver Ofertas
                            </a>
                        <% } %>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="text-center">
                        <i class="fas fa-graduation-cap fa-8x text-white-50"></i>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Estadísticas -->
    <section class="stats-section py-5">
        <div class="container">
            <div class="row text-center mb-5">
                <div class="col-12">
                    <h2 class="section-title">Nuestro Impacto</h2>
                    <p class="text-muted lead">Cifras que demuestran nuestro compromiso</p>
                </div>
            </div>
            <div class="row text-center">
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="stats-card">
                        <div class="stats-icon">
                            <i class="fas fa-user-graduate fa-3x"></i>
                        </div>
                        <h3 class="stats-number">6</h3>
                        <p class="stats-label">Estudiantes Registrados</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="stats-card">
                        <div class="stats-icon">
                            <i class="fas fa-building fa-3x"></i>
                        </div>
                        <h3 class="stats-number">2</h3>
                        <p class="stats-label">Empresas Aliadas</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="stats-card">
                        <div class="stats-icon">
                            <i class="fas fa-briefcase fa-3x"></i>
                        </div>
                        <h3 class="stats-number">0</h3>
                        <p class="stats-label">Prácticas Completadas</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="stats-card">
                        <div class="stats-icon">
                            <i class="fas fa-handshake fa-3x"></i>
                        </div>
                        <h3 class="stats-number">50%</h3>
                        <p class="stats-label">Tasa de Satisfacción</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Servicios -->
    <section class="services-section bg-light py-5">
        <div class="container">
            <div class="row">
                <div class="col-12 text-center mb-5">
                    <h2 class="section-title">¿Cómo Funciona?</h2>
                    <p class="text-muted lead">Proceso simple y efectivo para conectar talento con oportunidades</p>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 mb-4">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-user-plus fa-4x"></i>
                        </div>
                        <h4 class="service-title">1. Regístrate</h4>
                        <p class="service-description">
                            Crea tu perfil como estudiante o empresa. Completa tu información profesional y académica.
                        </p>
                    </div>
                </div>
                <div class="col-lg-4 mb-4">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-search fa-4x"></i>
                        </div>
                        <h4 class="service-title">2. Busca o Publica</h4>
                        <p class="service-description">
                            Estudiantes buscan ofertas ideales. Empresas publican oportunidades de prácticas profesionales.
                        </p>
                    </div>
                </div>
                <div class="col-lg-4 mb-4">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-handshake fa-4x"></i>
                        </div>
                        <h4 class="service-title">3. Conecta</h4>
                        <p class="service-description">
                            Postula a ofertas interesantes y comienza tu experiencia profesional con nuestro seguimiento.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Registro Section -->
    <% if (session.getAttribute("usuario") == null) { %>
    <section class="registration-section py-5" id="registro">
        <div class="container">
            <div class="row">
                <div class="col-12 text-center mb-5">
                    <h2 class="section-title text-white">¡Únete a Nuestra Comunidad!</h2>
                    <p class="text-white lead">Elige el tipo de registro que mejor se adapte a ti</p>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-lg-5 mb-4">
                    <div class="registration-card">
                        <div class="card-header-custom">
                            <h4><i class="fas fa-user-graduate"></i> Para Estudiantes</h4>
                        </div>
                        <div class="card-body text-center p-4">
                            <ul class="benefits-list">
                                <li><i class="fas fa-check"></i> Acceso a ofertas exclusivas</li>
                                <li><i class="fas fa-check"></i> Seguimiento de postulaciones</li>
                                <li><i class="fas fa-check"></i> Gestión de prácticas</li>
                                <li><i class="fas fa-check"></i> Supervisión académica</li>
                            </ul>
                            <a href="<%= request.getContextPath() %>/registro/estudiante" class="btn btn-primary btn-lg btn-block">
                                <i class="fas fa-user-plus"></i> Registrarse como Estudiante
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-5 mb-4">
                    <div class="registration-card">
                        <div class="card-header-custom-alt">
                            <h4><i class="fas fa-building"></i> Para Empresas</h4>
                        </div>
                        <div class="card-body text-center p-4">
                            <ul class="benefits-list">
                                <li><i class="fas fa-check"></i> Publicación de ofertas</li>
                                <li><i class="fas fa-check"></i> Gestión de postulaciones</li>
                                <li><i class="fas fa-check"></i> Acceso a talento calificado</li>
                                <li><i class="fas fa-check"></i> Panel de control completo</li>
                            </ul>
                            <a href="<%= request.getContextPath() %>/registro/empresa" class="btn btn-info btn-lg btn-block">
                                <i class="fas fa-building"></i> Registrarse como Empresa
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <% } %>

    <!-- Footer -->
    <footer class="footer-section">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5>Sistema de Prácticas Profesionales</h5>
                    <p>Facultad de Ingeniería Estadística e Informática</p>
                </div>
                <div class="col-md-6 text-md-right">
                    <p>&copy; 2025 Todos los derechos reservados.</p>
                    <p>Esta plataforma ha sido diseñada con el propósito de fortalecer los vínculos entre el ámbito académico y el sector empresarial, facilitando una interacción directa y efectiva entre estudiantes y empresas. Su objetivo principal es brindar a los estudiantes oportunidades reales de aprendizaje práctico, pasantías, empleos y desarrollo profesional, mientras que las empresas pueden identificar y atraer talento joven con formación actualizada y motivación por integrarse al mercado laboral</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Smooth scrolling para enlaces internos
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });
    </script>
</body>
</html>