<%-- 
    Document   : header
    Created on : 22 may. 2025, 11:13:32 a. m.
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.titulo} - Sistema de Prácticas Profesionales</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/recursos/css/styles.css">
    
    <!-- Favicon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/recursos/img/favicon.ico" type="image/x-icon">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-graduation-cap mr-2"></i>
                Sistema de Prácticas Profesionales
            </a>
            
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <c:if test="${not empty sessionScope.usuario}">
                        <!-- Menú para Estudiantes -->
                        <c:if test="${sessionScope.usuario.tipoUsuario eq 'ESTUDIANTE'}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/estudiante/dashboard">
                                    <i class="fas fa-tachometer-alt"></i> Inicio
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/estudiante/ofertas">
                                    <i class="fas fa-briefcase"></i> Ofertas
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/estudiante/postulaciones">
                                    <i class="fas fa-clipboard-list"></i> Mis Postulaciones
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/estudiante/practicas">
                                    <i class="fas fa-graduation-cap"></i> Mis Prácticas
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/estudiante/perfil">
                                    <i class="fas fa-user-edit"></i> Mi Perfil
                                </a>
                            </li>
                        </c:if>
                        
                        <!-- Menú para Empresas -->
                        <c:if test="${sessionScope.usuario.tipoUsuario eq 'EMPRESA'}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/empresa/dashboard">
                                    <i class="fas fa-tachometer-alt"></i> Inicio
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/empresa/ofertas">
                                    <i class="fas fa-briefcase"></i> Mis Ofertas
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/empresa/postulaciones">
                                    <i class="fas fa-users"></i> Postulaciones
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/empresa/practicantes">
                                    <i class="fas fa-user-tie"></i> Practicantes
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/empresa/perfil">
                                    <i class="fas fa-building"></i> Mi Perfil
                                </a>
                            </li>
                        </c:if>
                        
                        <!-- Menú para Supervisores -->
                        <c:if test="${sessionScope.usuario.tipoUsuario eq 'SUPERVISOR'}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/supervisor/dashboard">
                                    <i class="fas fa-tachometer-alt"></i> Inicio
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/supervisor/practicas">
                                    <i class="fas fa-clipboard-check"></i> Prácticas
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/supervisor/estudiantes">
                                    <i class="fas fa-users"></i> Estudiantes
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/supervisor/informes">
                                    <i class="fas fa-file-alt"></i> Informes
                                </a>
                            </li>
                        </c:if>
                        
                        <!-- Menú para Administradores -->
                        <c:if test="${sessionScope.usuario.tipoUsuario eq 'ADMIN'}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                                    <i class="fas fa-tachometer-alt"></i> Inicio
                                </a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="adminDropdown" role="button" data-toggle="dropdown">
                                    <i class="fas fa-cogs"></i> Gestión
                                </a>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/estudiantes">
                                        <i class="fas fa-user-graduate"></i> Estudiantes
                                    </a>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/empresas">
                                        <i class="fas fa-building"></i> Empresas
                                    </a>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/supervisores">
                                        <i class="fas fa-user-tie"></i> Supervisores
                                    </a>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/practicas">
                                        <i class="fas fa-clipboard-list"></i> Prácticas
                                    </a>
                                </div>
                            </li>
                        </c:if>
                        
                        <!-- Menú de usuario -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown">
                                <i class="fas fa-user-circle"></i> 
                                <c:choose>
                                    <c:when test="${not empty sessionScope.estudiante}">
                                        ${sessionScope.estudiante.nombres}
                                    </c:when>
                                    <c:when test="${not empty sessionScope.empresa}">
                                        ${sessionScope.empresa.razonSocial}
                                    </c:when>
                                    <c:when test="${not empty sessionScope.supervisor}">
                                        ${sessionScope.supervisor.nombres}
                                    </c:when>
                                    <c:otherwise>
                                        ${sessionScope.usuario.username}
                                    </c:otherwise>
                                </c:choose>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right">
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/perfil">
                                    <i class="fas fa-user"></i> Mi Cuenta
                                </a>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/configuracion">
                                    <i class="fas fa-cog"></i> Configuración
                                </a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                    <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
                                </a>
                            </div>
                        </li>
                    </c:if>
                    
                    <!-- Opciones para usuarios no autenticados -->
                    <c:if test="${empty sessionScope.usuario}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                <i class="fas fa-sign-in-alt"></i> Iniciar Sesión
                            </a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="registerDropdown" role="button" data-toggle="dropdown">
                                <i class="fas fa-user-plus"></i> Registrarse
                            </a>
                            <div class="dropdown-menu dropdown-menu-right">
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/registro/estudiante">
                                    <i class="fas fa-user-graduate"></i> Como Estudiante
                                </a>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/registro/empresa">
                                    <i class="fas fa-building"></i> Como Empresa
                                </a>
                            </div>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>
    </nav>
    
    <!-- Contenedor para alertas -->
    <div id="alertaContainer" class="container mt-3"></div>
    
    <!-- Contenido principal -->
    <main class="container-fluid mt-4">