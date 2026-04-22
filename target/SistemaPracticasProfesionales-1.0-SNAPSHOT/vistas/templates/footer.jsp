<%-- 
    Document   : footer
    Created on : 22 may. 2025, 11:14:13?a. m.
    Author     : LENOVO
--%>

</main>
    
    <!-- Pie de página -->
    <footer class="bg-dark text-white mt-5 py-4">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <h5><i class="fas fa-graduation-cap"></i> Sistema de Prácticas</h5>
                    <p class="mb-2">Facultad de Ingeniería Estadística e Informática</p>
                    <p class="small text-muted">
                        Plataforma integral para la gestión de prácticas profesionales, 
                        conectando estudiantes con oportunidades reales en el mercado laboral.
                    </p>
                </div>
                <div class="col-md-2">
                    <h6>Enlaces Rápidos</h6>
                    <ul class="list-unstyled">
                        <li><a href="${pageContext.request.contextPath}/" class="text-light">Inicio</a></li>
                        <li><a href="${pageContext.request.contextPath}/sobre-nosotros" class="text-light">Acerca de</a></li>
                        <li><a href="${pageContext.request.contextPath}/ayuda" class="text-light">Ayuda</a></li>
                        <li><a href="${pageContext.request.contextPath}/contacto" class="text-light">Contacto</a></li>
                    </ul>
                </div>
                <div class="col-md-3">
                    <h6>Para Estudiantes</h6>
                    <ul class="list-unstyled">
                        <li><a href="${pageContext.request.contextPath}/estudiante/ofertas" class="text-light">Ver Ofertas</a></li>
                        <li><a href="${pageContext.request.contextPath}/registro/estudiante" class="text-light">Registrarse</a></li>
                        <li><a href="${pageContext.request.contextPath}/guias/estudiante" class="text-light">Guía de Usuario</a></li>
                    </ul>
                </div>
                <div class="col-md-3">
                    <h6>Contacto</h6>
                    <address class="small">
                        <i class="fas fa-map-marker-alt"></i> Campus Universitario<br>
                        Lima, Perú<br><br>
                        <i class="fas fa-phone"></i> <a href="tel:+51123456789" class="text-light">(01) 123-4567</a><br>
                        <i class="fas fa-envelope"></i> <a href="mailto:practicas@universidad.edu.pe" class="text-light">practicas@universidad.edu.pe</a>
                    </address>
                    
                    <!-- Redes sociales -->
                    <div class="mt-3">
                        <a href="#" class="text-light mr-3"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="text-light mr-3"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-light mr-3"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#" class="text-light"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
            </div>
            <hr class="my-4">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <p class="mb-0 small">
                        &copy; <%= new java.util.Date().getYear() + 1900 %> Sistema de Prácticas Profesionales. 
                        Todos los derechos reservados.
                    </p>
                </div>
                <div class="col-md-6 text-md-right">
                    <a href="${pageContext.request.contextPath}/privacidad" class="text-light small mr-3">Política de Privacidad</a>
                    <a href="${pageContext.request.contextPath}/terminos" class="text-light small">Términos de Uso</a>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scripts de JavaScript -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/recursos/js/scripts.js"></script>
    
    <!-- Script adicional específico de la página -->
    <c:if test="${not empty param.script}">
        <script src="${pageContext.request.contextPath}/recursos/js/${param.script}"></script>
    </c:if>
</body>
</html>