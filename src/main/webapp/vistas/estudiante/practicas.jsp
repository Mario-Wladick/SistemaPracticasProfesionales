<%-- 
    Document   : practicas
    Created on : 9 jul. 2025, 12:12:03 p. m.
    Author     : LENOVO
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Estudiante" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis Prácticas - Sistema de Prácticas Profesionales</title>
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
            --danger-color: #f8d7da;
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

        .stats-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border: 1px solid var(--accent-color);
            text-align: center;
            transition: transform 0.2s ease;
        }

        .stats-card:hover {
            transform: translateY(-2px);
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            color: var(--text-color);
        }

        .stat-label {
            color: #6c757d;
            font-size: 0.95rem;
        }

        .practica-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border: 1px solid var(--accent-color);
            transition: transform 0.2s ease;
        }

        .practica-card:hover {
            transform: translateY(-2px);
        }

        .status-badge {
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .status-en-curso {
            background-color: var(--info-color);
            color: #0c5460;
        }

        .status-completada {
            background-color: var(--success-color);
            color: #0f5132;
        }

        .status-por-iniciar {
            background-color: var(--warning-color);
            color: #856404;
        }

        .progress-bar {
            height: 8px;
            border-radius: 4px;
            background-color: #e9ecef;
            overflow: hidden;
            margin: 1rem 0;
        }

        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, #4facfe 0%, #00f2fe 100%);
            transition: width 0.3s ease;
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

        .btn-soft {
            padding: 0.5rem 1rem;
            border-radius: 8px;
            border: none;
            font-weight: 500;
            transition: all 0.2s ease;
            margin-right: 0.5rem;
        }

        .btn-soft-primary {
            background-color: var(--primary-color);
            color: var(--text-color);
        }

        .btn-soft-primary:hover {
            background-color: var(--accent-color);
            color: var(--text-color);
        }

        .btn-soft-success {
            background-color: var(--success-color);
            color: #0f5132;
        }

        .btn-soft-warning {
            background-color: var(--warning-color);
            color: #856404;
        }

        .calendar-widget {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border: 1px solid var(--accent-color);
        }

        .timeline {
            position: relative;
            padding-left: 2rem;
        }

        .timeline::before {
            content: '';
            position: absolute;
            left: 0.5rem;
            top: 0;
            bottom: 0;
            width: 2px;
            background: var(--accent-color);
        }

        .timeline-item {
            position: relative;
            padding-bottom: 1.5rem;
        }

        .timeline-item::before {
            content: '';
            position: absolute;
            left: -0.75rem;
            top: 0.25rem;
            width: 0.75rem;
            height: 0.75rem;
            border-radius: 50%;
            background: var(--accent-color);
        }

        .timeline-item.completed::before {
            background: #28a745;
        }

        .timeline-item.current::before {
            background: #007bff;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(0, 123, 255, 0.7); }
            70% { box-shadow: 0 0 0 10px rgba(0, 123, 255, 0); }
            100% { box-shadow: 0 0 0 0 rgba(0, 123, 255, 0); }
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

        .upcoming-task {
            background: var(--info-color);
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1rem;
            border-left: 4px solid #0066cc;
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
        <div class="row">
            <div class="col-md-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-clipboard-list"></i> Mis Prácticas</h2>
                    <a href="<%= request.getContextPath() %>/estudiante/ofertas" class="btn btn-primary">
                        <i class="fas fa-search"></i> Buscar Más Ofertas
                    </a>
                </div>

                <!-- Estadísticas -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="stats-card">
                            <div class="stat-number">2</div>
                            <div class="stat-label">Prácticas Activas</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stats-card">
                            <div class="stat-number">1</div>
                            <div class="stat-label">Por Iniciar</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stats-card">
                            <div class="stat-number">320</div>
                            <div class="stat-label">Horas Completadas</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stats-card">
                            <div class="stat-number">85%</div>
                            <div class="stat-label">Promedio General</div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-8">
                        <!-- Práctica En Curso -->
                        <div class="practica-card">
                            <div class="row">
                                <div class="col-md-2">
                                    <div class="company-logo">
                                        <i class="fas fa-building"></i>
                                    </div>
                                </div>
                                <div class="col-md-7">
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <div>
                                            <h5 class="mb-1">Desarrollador Frontend Junior</h5>
                                            <p class="text-muted mb-1">TechSolutions SAC - Lima, Perú</p>
                                            <span class="status-badge status-en-curso">En Curso</span>
                                        </div>
                                    </div>
                                    
                                    <div class="row mb-2">
                                        <div class="col-md-6">
                                            <small class="text-muted">Fecha Inicio:</small><br>
                                            <strong>15 Jun 2025</strong>
                                        </div>
                                        <div class="col-md-6">
                                            <small class="text-muted">Fecha Fin:</small><br>
                                            <strong>15 Dic 2025</strong>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <div class="d-flex justify-content-between">
                                            <small class="text-muted">Progreso de Horas:</small>
                                            <small><strong>180/240 horas (75%)</strong></small>
                                        </div>
                                        <div class="progress-bar">
                                            <div class="progress-fill" style="width: 75%"></div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <small class="text-muted">Supervisor:</small><br>
                                            <strong>Ing. Carlos Mendoza</strong>
                                        </div>
                                        <div class="col-md-6">
                                            <small class="text-muted">Calificación Actual:</small><br>
                                            <strong class="text-success">8.5/10</strong>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 text-end">
                                    <button class="btn btn-soft btn-soft-primary mb-2">
                                        <i class="fas fa-eye"></i> Ver Detalles
                                    </button>
                                    <br>
                                    <button class="btn btn-soft btn-soft-success">
                                        <i class="fas fa-clock"></i> Registrar Horas
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Práctica Por Iniciar -->
                        <div class="practica-card">
                            <div class="row">
                                <div class="col-md-2">
                                    <div class="company-logo">
                                        <i class="fas fa-industry"></i>
                                    </div>
                                </div>
                                <div class="col-md-7">
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <div>
                                            <h5 class="mb-1">Analista de Procesos</h5>
                                            <p class="text-muted mb-1">Corporación Industrial - Arequipa, Perú</p>
                                            <span class="status-badge status-por-iniciar">Por Iniciar</span>
                                        </div>
                                    </div>
                                    
                                    <div class="row mb-2">
                                        <div class="col-md-6">
                                            <small class="text-muted">Fecha Inicio:</small><br>
                                            <strong>01 Ago 2025</strong>
                                        </div>
                                        <div class="col-md-6">
                                            <small class="text-muted">Fecha Fin:</small><br>
                                            <strong>31 Dic 2025</strong>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <div class="d-flex justify-content-between">
                                            <small class="text-muted">Duración:</small>
                                            <small><strong>5 meses (200 horas)</strong></small>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <small class="text-muted">Modalidad:</small><br>
                                            <strong>Híbrido</strong>
                                        </div>
                                        <div class="col-md-6">
                                            <small class="text-muted">Estado:</small><br>
                                            <strong class="text-warning">Pendiente de inicio</strong>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 text-end">
                                    <button class="btn btn-soft btn-soft-primary mb-2">
                                        <i class="fas fa-eye"></i> Ver Detalles
                                    </button>
                                    <br>
                                    <button class="btn btn-soft btn-soft-warning">
                                        <i class="fas fa-calendar"></i> Preparar Inicio
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Práctica Completada -->
                        <div class="practica-card">
                            <div class="row">
                                <div class="col-md-2">
                                    <div class="company-logo">
                                        <i class="fas fa-hospital"></i>
                                    </div>
                                </div>
                                <div class="col-md-7">
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <div>
                                            <h5 class="mb-1">Asistente Administrativo</h5>
                                            <p class="text-muted mb-1">Hospital Nacional - Cusco, Perú</p>
                                            <span class="status-badge status-completada">Completada</span>
                                        </div>
                                    </div>
                                    
                                    <div class="row mb-2">
                                        <div class="col-md-6">
                                            <small class="text-muted">Período:</small><br>
                                            <strong>Ene - May 2025</strong>
                                        </div>
                                        <div class="col-md-6">
                                            <small class="text-muted">Calificación Final:</small><br>
                                            <strong class="text-success">9.2/10</strong>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <div class="d-flex justify-content-between">
                                            <small class="text-muted">Horas Completadas:</small>
                                            <small><strong>240/240 horas (100%)</strong></small>
                                        </div>
                                        <div class="progress-bar">
                                            <div class="progress-fill" style="width: 100%"></div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <small class="text-muted">Certificado:</small><br>
                                            <strong class="text-success">Disponible para descarga</strong>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 text-end">
                                    <button class="btn btn-soft btn-soft-primary mb-2">
                                        <i class="fas fa-eye"></i> Ver Detalles
                                    </button>
                                    <br>
                                    <button class="btn btn-success">
                                        <i class="fas fa-download"></i> Certificado
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <!-- Calendario de Actividades -->
                        <div class="calendar-widget mb-4">
                            <h5><i class="fas fa-calendar-alt"></i> Próximas Actividades</h5>
                            <hr>
                            
                            <div class="upcoming-task">
                                <div class="d-flex justify-content-between">
                                    <strong>Entrega de Informe</strong>
                                    <small class="text-muted">15 Jul</small>
                                </div>
                                <small class="text-muted">TechSolutions SAC</small>
                            </div>

                            <div class="upcoming-task">
                                <div class="d-flex justify-content-between">
                                    <strong>Reunión Supervisor</strong>
                                    <small class="text-muted">18 Jul</small>
                                </div>
                                <small class="text-muted">Evaluación mensual</small>
                            </div>

                            <div class="upcoming-task">
                                <div class="d-flex justify-content-between">
                                    <strong>Inicio Nueva Práctica</strong>
                                    <small class="text-muted">01 Ago</small>
                                </div>
                                <small class="text-muted">Corporación Industrial</small>
                            </div>
                        </div>

                        <!-- Timeline de Progreso -->
                        <div class="calendar-widget">
                            <h5><i class="fas fa-chart-line"></i> Progreso Académico</h5>
                            <hr>
                            
                            <div class="timeline">
                                <div class="timeline-item completed">
                                    <div>
                                        <strong>Práctica I</strong>
                                        <small class="text-muted d-block">Hospital Nacional - Completada</small>
                                        <small class="text-success">Calificación: 9.2</small>
                                    </div>
                                </div>
                                
                                <div class="timeline-item current">
                                    <div>
                                        <strong>Práctica II</strong>
                                        <small class="text-muted d-block">TechSolutions SAC - En Curso</small>
                                        <small class="text-info">Progreso: 75%</small>
                                    </div>
                                </div>
                                
                                <div class="timeline-item">
                                    <div>
                                        <strong>Práctica III</strong>
                                        <small class="text-muted d-block">Corporación Industrial - Por Iniciar</small>
                                        <small class="text-warning">Inicio: 01 Ago</small>
                                    </div>
                                </div>
                                
                                <div class="timeline-item">
                                    <div>
                                        <strong>Graduación</strong>
                                        <small class="text-muted d-block">Culminación de estudios</small>
                                        <small class="text-muted">Proyectado: Dic 2025</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal para Registro de Horas -->
    <div class="modal fade" id="modalHoras" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Registrar Horas de Práctica</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="mb-3">
                            <label class="form-label">Fecha:</label>
                            <input type="date" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Horas Trabajadas:</label>
                            <input type="number" class="form-control" min="1" max="8" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Actividades Realizadas:</label>
                            <textarea class="form-control" rows="3" placeholder="Describe las actividades realizadas durante estas horas..." required></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Supervisor que Validó:</label>
                            <select class="form-control" required>
                                <option value="">Seleccionar supervisor</option>
                                <option value="1">Ing. Carlos Mendoza</option>
                                <option value="2">Lic. Ana García</option>
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary">Registrar Horas</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Función para abrir modal de registro de horas
        function registrarHoras() {
            const modal = new bootstrap.Modal(document.getElementById('modalHoras'));
            modal.show();
        }

        // Agregar event listeners a los botones
        document.addEventListener('DOMContentLoaded', function() {
            // Botón de registrar horas
            document.querySelectorAll('.btn-soft-success').forEach(btn => {
                if (btn.textContent.includes('Registrar Horas')) {
                    btn.addEventListener('click', registrarHoras);
                }
            });

            // Simular funcionalidad de descarga de certificado
            document.querySelectorAll('.btn-success').forEach(btn => {
                if (btn.textContent.includes('Certificado')) {
                    btn.addEventListener('click', function() {
                        alert('Descargando certificado de práctica...');
                    });
                }
            });

            // Funcionalidad para preparar inicio
            document.querySelectorAll('.btn-soft-warning').forEach(btn => {
                if (btn.textContent.includes('Preparar Inicio')) {
                    btn.addEventListener('click', function() {
                        alert('Redirigiendo a preparación de inicio de práctica...');
                    });
                }
            });
        });

        // Función para mostrar detalles de práctica
        function verDetalles(practicaId) {
            alert('Mostrando detalles de la práctica ID: ' + practicaId);
        }

        // Actualizar progreso en tiempo real (simulado)
        setInterval(function() {
            const now = new Date();
            const seconds = now.getSeconds();
            
            // Simular pequeños cambios en el progreso
            if (seconds % 30 === 0) {
                const progressBars = document.querySelectorAll('.progress-fill');
                progressBars.forEach(bar => {
                    const currentWidth = parseInt(bar.style.width);
                    if (currentWidth < 100) {
                        // Incremento aleatorio pequeño
                        const increment = Math.random() * 2;
                        const newWidth = Math.min(100, currentWidth + increment);
                        bar.style.width = newWidth + '%';
                    }
                });
            }
        }, 1000);
    </script>
</body>
</html>