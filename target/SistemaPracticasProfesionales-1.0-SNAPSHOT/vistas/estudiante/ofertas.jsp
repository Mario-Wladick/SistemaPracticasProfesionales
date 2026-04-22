<%-- 
    Document   : ofertas
    Created on : 9 jul. 2025, 1:03:03 p. m.
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Estudiante" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ofertas Disponibles - Sistema de Prácticas Profesionales</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #e8f4f8;
            --secondary-color: #f8f9fa;
            --accent-color: #b8dce8;
            --text-color: #2c3e50;
            --success-color: #d4edda;
            --warning-color: #fff3cd;
            --info-color: #cce8f4;
        }

        body {
            background-color: var(--secondary-color);
            color: var(--text-color);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .navbar {
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .main-content {
            padding: 2rem 0;
        }

        .content-card {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border: 1px solid var(--accent-color);
        }

        .search-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border: 1px solid var(--accent-color);
        }

        .offer-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border: 1px solid var(--accent-color);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .offer-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }

        .company-logo {
            width: 60px;
            height: 60px;
            background: var(--primary-color);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: var(--text-color);
        }

        .offer-title {
            color: var(--text-color);
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .company-name {
            color: #6c757d;
            font-size: 0.95rem;
            margin-bottom: 1rem;
        }

        .offer-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }

        .tag {
            background: var(--info-color);
            color: #0c5460;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .tag.modalidad {
            background: var(--warning-color);
            color: #856404;
        }

        .tag.duracion {
            background: var(--success-color);
            color: #0f5132;
        }

        .btn-soft {
            padding: 0.5rem 1rem;
            border-radius: 8px;
            border: none;
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .btn-soft-primary {
            background-color: var(--primary-color);
            color: var(--text-color);
        }

        .btn-soft-primary:hover {
            background-color: var(--accent-color);
            color: var(--text-color);
        }

        .stats-row {
            background: var(--primary-color);
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-item {
            text-align: center;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: var(--text-color);
        }

        .stat-label {
            color: #6c757d;
            font-size: 0.9rem;
        }

        .filter-section {
            background: var(--info-color);
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1rem;
        }

        .form-control {
            border-radius: 8px;
            border: 1px solid var(--accent-color);
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(184, 220, 232, 0.25);
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #6c757d;
        }

        .empty-state i {
            font-size: 4rem;
            margin-bottom: 1rem;
            color: var(--accent-color);
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="<%= request.getContextPath() %>/estudiante/dashboard">
                <i class="fas fa-graduation-cap"></i> Sistema de Prácticas
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="<%= request.getContextPath() %>/estudiante/dashboard">
                    <i class="fas fa-home"></i> Dashboard
                </a>
                <a class="nav-link" href="<%= request.getContextPath() %>/logout">
                    <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
                </a>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container main-content">
        <!-- Estadísticas -->
        <div class="stats-row">
            <div class="row">
                <div class="col-md-3">
                    <div class="stat-item">
                        <div class="stat-number">3</div>
                        <div class="stat-label">Ofertas Disponibles</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-item">
                        <div class="stat-number">3</div>
                        <div class="stat-label">Para mi Especialidad</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-item">
                        <div class="stat-number">0</div>
                        <div class="stat-label">Nuevas Esta Semana</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-item">
                        <div class="stat-number">0</div>
                        <div class="stat-label">Próximas a Vencer</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-3">
                <!-- Filtros -->
                <div class="search-card">
                    <h5><i class="fas fa-filter"></i> Filtros</h5>
                    <hr>
                    
                    <div class="filter-section">
                        <label class="form-label"><strong>Búsqueda</strong></label>
                        <input type="text" class="form-control" placeholder="Buscar ofertas...">
                    </div>

                    <div class="filter-section">
                        <label class="form-label"><strong>Especialidad</strong></label>
                        <select class="form-control">
                            <option>Todas las especialidades</option>
                            <option>Ingenieria Estadística e Informática</option>
                            <option>Ingeniería de Sistemas</option>
                            <option>Ingeniería Industrial</option>
                            <option>Ingeniería Civil</option>
                            <option>Administración</option>
                        </select>
                    </div>

                    <div class="filter-section">
                        <label class="form-label"><strong>Modalidad</strong></label>
                        <select class="form-control">
                            <option>Todas las modalidades</option>
                            <option>Presencial</option>
                            <option>Remoto</option>
                            <option>Híbrido</option>
                        </select>
                    </div>

                    <div class="filter-section">
                        <label class="form-label"><strong>Ubicación</strong></label>
                        <select class="form-control">
                            <option>Todas las ubicaciones</option>
                            <option>Lima</option>
                            <option>Arequipa</option>
                            <option>Trujillo</option>
                            <option>Cusco</option>
                            <option>Puno</option>
                        </select>
                    </div>

                    <button class="btn btn-soft btn-soft-primary w-100 mt-3">
                        <i class="fas fa-search"></i> Aplicar Filtros
                    </button>
                </div>
            </div>

            <div class="col-md-9">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4><i class="fas fa-briefcase"></i> Ofertas Disponibles</h4>
                    <div class="d-flex gap-2">
                        <button class="btn btn-outline-secondary btn-sm">
                            <i class="fas fa-th"></i>
                        </button>
                        <button class="btn btn-outline-secondary btn-sm">
                            <i class="fas fa-list"></i>
                        </button>
                    </div>
                </div>

                <!-- Lista de Ofertas -->
                <div class="offer-card">
                    <div class="row">
                        <div class="col-md-2">
                            <div class="company-logo">
                                <i class="fas fa-building"></i>
                            </div>
                        </div>
                        <div class="col-md-7">
                            <h5 class="offer-title">Desarrollador Frontend Junior</h5>
                            <p class="company-name"><i class="fas fa-building"></i> TechSolutions SAC - Lima, Perú</p>
                            <div class="offer-tags">
                                <span class="tag">Sistemas</span>
                                <span class="tag modalidad">Presencial</span>
                                <span class="tag duracion">6 meses</span>
                            </div>
                            <p class="text-muted mb-2">Buscamos estudiante de últimos ciclos para desarrollo web con React y JavaScript...</p>
                            <small class="text-muted"><i class="fas fa-clock"></i> Publicado hace 2 días</small>
                        </div>
                        <div class="col-md-3 text-end">
                            <button class="btn btn-soft btn-soft-primary mb-2">
                                <i class="fas fa-eye"></i> Ver Detalles
                            </button>
                            <br>
                            <button class="btn btn-primary">
                                <i class="fas fa-paper-plane"></i> Postular
                            </button>
                        </div>
                    </div>
                </div>

                <div class="offer-card">
                    <div class="row">
                        <div class="col-md-2">
                            <div class="company-logo">
                                <i class="fas fa-industry"></i>
                            </div>
                        </div>
                        <div class="col-md-7">
                            <h5 class="offer-title">Analista de Procesos</h5>
                            <p class="company-name"><i class="fas fa-building"></i> Corporación Industrial - Arequipa, Perú</p>
                            <div class="offer-tags">
                                <span class="tag">Industrial</span>
                                <span class="tag modalidad">Híbrido</span>
                                <span class="tag duracion">4 meses</span>
                            </div>
                            <p class="text-muted mb-2">Oportunidad para estudiante de Ingeniería Industrial en mejora de procesos...</p>
                            <small class="text-muted"><i class="fas fa-clock"></i> Publicado hace 1 semana</small>
                        </div>
                        <div class="col-md-3 text-end">
                            <button class="btn btn-soft btn-soft-primary mb-2">
                                <i class="fas fa-eye"></i> Ver Detalles
                            </button>
                            <br>
                            <button class="btn btn-primary">
                                <i class="fas fa-paper-plane"></i> Postular
                            </button>
                        </div>
                    </div>
                </div>

                <div class="offer-card">
                    <div class="row">
                        <div class="col-md-2">
                            <div class="company-logo">
                                <i class="fas fa-chart-line"></i>
                            </div>
                        </div>
                        <div class="col-md-7">
                            <h5 class="offer-title">Asistente de Marketing Digital</h5>
                            <p class="company-name"><i class="fas fa-building"></i> Digital Marketing Pro - Lima, Perú</p>
                            <div class="offer-tags">
                                <span class="tag">Administración</span>
                                <span class="tag modalidad">Remoto</span>
                                <span class="tag duracion">5 meses</span>
                            </div>
                            <p class="text-muted mb-2">Únete a nuestro equipo de marketing digital y aprende sobre campañas...</p>
                            <small class="text-muted"><i class="fas fa-clock"></i> Publicado hace 3 días</small>
                        </div>
                        <div class="col-md-3 text-end">
                            <button class="btn btn-soft btn-soft-primary mb-2">
                                <i class="fas fa-eye"></i> Ver Detalles
                            </button>
                            <br>
                            <button class="btn btn-primary">
                                <i class="fas fa-paper-plane"></i> Postular
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Paginación -->
                <nav class="mt-4">
                    <ul class="pagination justify-content-center">
                        <li class="page-item disabled">
                            <a class="page-link" href="#"><i class="fas fa-chevron-left"></i></a>
                        </li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#"><i class="fas fa-chevron-right"></i></a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>>