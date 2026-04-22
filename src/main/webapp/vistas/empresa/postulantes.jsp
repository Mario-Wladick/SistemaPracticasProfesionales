<%-- 
    Document   : postulantes
    Created on : 23 jun. 2025, 2:49:31 p. m.
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Empresa" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Postulantes - Sistema de Prácticas</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body class="bg-light">
    <%
        Empresa empresa = (Empresa) request.getAttribute("empresa");
        String mensaje = (String) request.getAttribute("mensaje");
        String error = (String) request.getAttribute("error");
    %>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="<%= request.getContextPath() %>/empresa/dashboard">
                <i class="fas fa-building"></i> 
                <% if (empresa != null) { %>
                    <%= empresa.getRazonSocial() %>
                <% } else { %>
                    Panel de Empresa
                <% } %>
            </a>
            
            <div class="navbar-nav ml-auto">
                <a class="nav-link text-white" href="<%= request.getContextPath() %>/logout">
                    <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-users text-primary"></i> Gestión de Postulantes</h2>
                    <a href="<%= request.getContextPath() %>/empresa/dashboard" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Volver al Dashboard
                    </a>
                </div>

                <!-- Mensajes -->
                <% if (mensaje != null) { %>
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle"></i> <%= mensaje %>
                    </div>
                <% } %>
                
                <% if (error != null) { %>
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-triangle"></i> <%= error %>
                    </div>
                <% } %>

                <!-- Contenido principal -->
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-user-graduate"></i> Gestión de Postulantes a tus Ofertas
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="text-center py-5">
                            <i class="fas fa-users fa-5x text-muted mb-4"></i>
                            <h4>Panel de Postulantes</h4>
                            <p class="text-muted">Aquí podrás revisar, aprobar y gestionar todas las postulaciones a tus ofertas de práctica.</p>
                            
                            <div class="row mt-4">
                                <div class="col-md-3">
                                    <div class="card border-warning">
                                        <div class="card-body text-center">
                                            <i class="fas fa-clock fa-2x text-warning mb-2"></i>
                                            <h6>Pendientes</h6>
                                            <p class="small text-muted">Postulaciones por revisar</p>
                                            <h4 class="text-warning">4</h4>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
    <div class="card border-success">
        <div class="card-body text-center">
            <i class="fas fa-check fa-2x text-success mb-2"></i>
            <h6>Aceptados</h6>
            <p class="small text-muted">Candidatos aprobados</p>
            <h4 class="text-success">6</h4>
            
            <!-- Botón de firma digital -->
            <div class="mt-2">
                <button class="btn btn-outline-success btn-sm" onclick="mostrarPostulantesAceptados()">
                    <i class="fas fa-eye"></i> Ver Lista
                </button>
            </div>
        </div>
    </div>
</div>
                                <div class="col-md-3">
                                    <div class="card border-danger">
                                        <div class="card-body text-center">
                                            <i class="fas fa-times fa-2x text-danger mb-2"></i>
                                            <h6>Rechazados</h6>
                                            <p class="small text-muted">Postulaciones rechazadas</p>
                                            <h4 class="text-danger">2</h4>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="card border-info">
                                        <div class="card-body text-center">
                                            <i class="fas fa-chart-bar fa-2x text-info mb-2"></i>
                                            <h6>Total</h6>
                                            <p class="small text-muted">Todas las postulaciones</p>
                                            <h4 class="text-info">12</h4>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Acciones rápidas -->
                            <div class="row mt-4">
                                <div class="col-md-6">
                                    <div class="card bg-light">
                                        <div class="card-body">
                                            <h6><i class="fas fa-search"></i> Buscar Postulantes</h6>
                                            <p class="small text-muted">Filtra por especialidad, promedio, etc.</p>
                                            <button class="btn btn-outline-primary btn-sm" disabled>
                                                <i class="fas fa-search"></i> Buscar
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="card bg-light">
                                        <div class="card-body">
                                            <h6><i class="fas fa-download"></i> Exportar Datos</h6>
                                            <p class="small text-muted">Descarga lista de postulantes</p>
                                            <button class="btn btn-outline-success btn-sm" disabled>
                                                <i class="fas fa-file-excel"></i> Exportar
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mt-4">
                                <p class="text-muted">
                                    <i class="fas fa-code"></i> 
                                    <strong>En desarrollo:</strong> Esta funcionalidad se está desarrollando. 
                                    Pronto podrás ver todos los estudiantes que se han postulado a tus ofertas.
                                </p>
                            </div>
                            
                            <!-- Preview de funcionalidades -->
                            <div class="mt-4">
                                <h6 class="text-muted">Funcionalidades que incluirá:</h6>
                                <div class="row text-left">
                                    <div class="col-md-6">
                                        <ul class="list-unstyled">
                                            <li><i class="fas fa-check text-success"></i> Ver perfil completo de estudiantes</li>
                                            <li><i class="fas fa-check text-success"></i> Aprobar/rechazar postulaciones</li>
                                            <li><i class="fas fa-check text-success"></i> Filtrar por especialidad</li>
                                        </ul>
                                    </div>
                                    <div class="col-md-6">
                                        <ul class="list-unstyled">
                                            <li><i class="fas fa-check text-success"></i> Comunicación directa con estudiantes</li>
                                            <li><i class="fas fa-check text-success"></i> Historial de postulaciones</li>
                                            <li><i class="fas fa-check text-success"></i> Reportes y estadísticas</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
                <!-- Sección de Postulantes Aceptados (oculta por defecto) -->
<div id="postulantesAceptados" class="card mt-4" style="display: none;">
    <div class="card-header bg-success text-white">
        <h5 class="mb-0">
            <i class="fas fa-user-check"></i> Postulantes Aceptados - Listos para Firmar
        </h5>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Estudiante</th>
                        <th>Oferta</th>
                        <th>Fecha Aceptación</th>
                        <th>Estado Firma</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody id="tablaPostulantesAceptados">
                    <!-- Datos de ejemplo -->
                    <tr>
                        <td>
                            <strong>Juan Pérez García</strong><br>
                            <small class="text-muted">Ing. Sistemas - Ciclo 8</small>
                        </td>
                        <td>
                            <strong>Desarrollador Web</strong><br>
                            <small class="text-muted">Modalidad: Remoto</small>
                        </td>
                        <td>08/07/2025</td>
                        <td>
                            <span class="badge badge-warning">Sin Firmar</span>
                        </td>
                        <td>
                            <button class="btn btn-success btn-sm" onclick="firmarAceptacion(123, {nombreEstudiante: 'Juan Pérez García', tituloOferta: 'Desarrollador Web'})">
                                <i class="fas fa-signature"></i> Firmar Contrato
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>María López Silva</strong><br>
                            <small class="text-muted">Ing. Sistemas - Ciclo 9</small>
                        </td>
                        <td>
                            <strong>Analista de Datos</strong><br>
                            <small class="text-muted">Modalidad: Híbrido</small>
                        </td>
                        <td>09/07/2025</td>
                        <td>
                            <span class="badge badge-success">Firmado</span>
                        </td>
                        <td>
                            <button class="btn btn-outline-secondary btn-sm" disabled>
                                <i class="fas fa-check"></i> Contrato Firmado
                            </button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Tocapu Integration -->
<!-- TOCAPU DIRECTO EN JSP -->
<script>
console.log("🔧 Cargando Tocapu directamente...");

// Función signTocapu
function signTocapu(tipoUsuario, idPostulacion, contexto = {}) {
    console.log("🔥 Activando Tocapu:", tipoUsuario, idPostulacion);
    
    const timestamp = new Date().getTime();
    const fileName = `contrato_${idPostulacion}_${timestamp}.pdf`;
    
    // URL para Tocapu
    const tocapuUrl = `tocapusign:?environment=demo&from=http://localhost:8080/SistemaPracticasProfesionales/documentos_firmados/articulo_convex___no_convex.pdf&to=http://localhost:8080/SistemaPracticasProfesionales/app/subir?name=${fileName}`;
    
    console.log("🔗 URL Tocapu:", tocapuUrl);
    
    try {
        // Crear enlace invisible
        const link = document.createElement('a');
        link.href = tocapuUrl;
        link.style.display = 'none';
        document.body.appendChild(link);
        
        // Activar enlace
        link.click();
        
        // Limpiar
        document.body.removeChild(link);
        
        alert("✅ Tocapu activado! Complete la firma en la aplicación.");
        
    } catch (error) {
        console.error("❌ Error al activar Tocapu:", error);
        alert("❌ Error al activar Tocapu: " + error.message);
    }
}

// Función firmarAceptacion
function firmarAceptacion(idPostulacion, contexto) {
    console.log("🖊️ Iniciando firma para postulación:", idPostulacion);
    
    if (confirm(`¿Deseas firmar digitalmente el contrato para ${contexto.nombreEstudiante}?`)) {
        signTocapu("empresa", idPostulacion, contexto);
    }
}

console.log("✅ Funciones Tocapu cargadas directamente");
</script>
<script>
function mostrarPostulantesAceptados() {
    const seccion = document.getElementById('postulantesAceptados');
    if (seccion.style.display === 'none') {
        seccion.style.display = 'block';
        // Scroll hacia la tabla
        seccion.scrollIntoView({ behavior: 'smooth' });
    } else {
        seccion.style.display = 'none';
    }
}

// Función específica para firmar aceptación
function firmarAceptacion(idPostulacion, contexto) {
    if (confirm(`¿Deseas firmar digitalmente el contrato para ${contexto.nombreEstudiante}?`)) {
        signTocapu("empresa", idPostulacion, contexto);
    }
}
</script>
</body>
</html