<%-- 
    Document   : postulaciones
    Created on : 9 jul. 2025, 1:03:45 p. m.
    Author     : LENOVO
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Estudiante" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis Postulaciones - Sistema de Prácticas Profesionales</title>
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

        .postulacion-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border: 1px solid var(--accent-color);
            transition: transform 0.2s ease;
        }

        .postulacion-card:hover {
            transform: translateY(-2px);
        }

        .status-badge {
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .status-pendiente {
            background-color: var(--warning-color);
            color: #856404;
        }

        .status-aceptada {
            background-color: var(--success-color);
            color: #0f5132;
        }

        .status-rechazada {
            background-color: var(--danger-color);
            color: #842029;
        }

        .status-en-revision {
            background-color: var(--info-color);
            color: #0c5460;
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
            padding-bottom: 1rem;
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

        .timeline-item.active::before {
            background: #28a745;
        }

        .company-logo {
            width: 50px;
            height: 50px;
            background: var(--primary-color);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            color: var(--text-color);
        }

        .btn-soft {
            padding: 0.4rem 0.8rem;
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

        .btn-soft-danger {
            background-color: var(--danger-color);
            color: #842029;
        }

        .progress-timeline {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 1rem 0;
            position: relative;
        }

        .progress-timeline::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 2px;
            background: #e9ecef;
            z-index: 1;
        }

        .progress-step {
            background: white;
            border: 2px solid #e9ecef;
            border-radius: 50%;
            width: 2rem;
            height: 2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
            position: relative;
            z-index: 2;
        }

        .progress-step.completed {
            border-color: #28a745;
            background: #28a745;
            color: white;
        }

        .progress-step.current {
            border-color: #007bff;
            background: #007bff;
            color: white;
        }

        .filter-tabs {
            background: white;
            border-radius: 12px;
            padding: 1rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border: 1px solid var(--accent-color);
        }

        .nav-pills .nav-link {
            border-radius: 8px;
            margin-right: 0.5rem;
        }

        .nav-pills .nav-link.active {
            background-color: var(--primary-color);
            color: var(--text-color);
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
        <div class="row">
            <div class="col-md-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-paper-plane"></i> Mis Postulaciones</h2>
                    <a href="<%= request.getContextPath() %>/estudiante/ofertas" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Nueva Postulación
                    </a>
                </div>

                <!-- Estadísticas -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="stats-card">
                            <div class="stat-number">0</div>
                            <div class="stat-label">Total Postulaciones</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stats-card">
                            <div class="stat-number">0</div>
                            <div class="stat-label">Pendientes</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stats-card">
                            <div class="stat-number">0</div>
                            <div class="stat-label">Aceptadas</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stats-card">
                            <div class="stat-number">0</div>
                            <div class="stat-label">Rechazadas</div>
                        </div>
                    </div>
                </div>

                <!-- Filtros -->
                <div class="filter-tabs">
                    <ul class="nav nav-pills" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" data-bs-toggle="pill" href="#todas">
                                <i class="fas fa-list"></i> Todas (8)
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-bs-toggle="pill" href="#pendientes">
                                <i class="fas fa-clock"></i> Pendientes (0)
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-bs-toggle="pill" href="#aceptadas">
                                <i class="fas fa-check"></i> Aceptadas (0)
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-bs-toggle="pill" href="#rechazadas">
                                <i class="fas fa-times"></i> Rechazadas (0)
                            </a>
                        </li>
                    </ul>
                </div>

                <!-- Lista de Postulaciones -->
                <div class="tab-content">
                    <div class="tab-pane fade show active" id="todas">
                        <!-- Postulación Aceptada -->
                        <div class="postulacion-card">
                            <div class="row">
                                <div class="col-md-1">
                                    <div class="company-logo">
                                        <i class="fas fa-building"></i>
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <div>
                                            <h5 class="mb-1">Desarrollador Frontend Junior</h5>
                                            <p class="text-muted mb-1">TechSolutions SAC - Lima, Perú</p>
                                            <span class="status-badge status-aceptada">Aceptada</span>
                                        </div>
                                        <small class="text-muted">Postulado: 15/06/2025</small>
                                    </div>
                                    
                                    <div class="progress-timeline">
                                        <div class="progress-step completed">1</div>
                                        <div class="progress-step completed">2</div>
                                        <div class="progress-step completed">3</div>
                                        <div class="progress-step current">4</div>
                                    </div>
                                    
                                    <div class="row text-center">
                                        <div class="col">
                                            <small class="text-muted">Postulado</small>
                                        </div>
                                        <div class="col">
                                            <small class="text-muted">En Revisión</small>
                                        </div>
                                        <div class="col">
                                            <small class="text-muted">Entrevista</small>
                                        </div>
                                        <div class="col">
                                            <small class="text-success">Aceptado</small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 text-end">
                                    <button class="btn btn-soft btn-soft-primary">
                                        <i class="