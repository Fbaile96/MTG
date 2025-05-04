<%@ page import="Torneos.Database.Database" %>
<%@ page import="Torneos.DAO.UbicacionDAO" %>
<%@ page import="Torneos.Objetos.Ubicacion" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../utiles/header.jsp" />
<%@ page import="Torneos.Objetos.Player" %>
<%
    Player jugador = (Player) session.getAttribute("player");
    if (jugador == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<%
    Database database = new Database();
    database.connect();
    UbicacionDAO ubicacionDao = new UbicacionDAO(database.getConexion());
    String mensaje = "";
    String tipoMensaje = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            String nombre = request.getParameter("nombre");
            String ciudad = request.getParameter("ciudad");
            String direccion = request.getParameter("direccion");
            int codigoPostal = Integer.parseInt(request.getParameter("codigoPostal"));
            double precioAlquiler = Double.parseDouble(request.getParameter("precioAlquiler"));
            boolean esTienda = request.getParameter("esTienda") != null;

            Ubicacion ubicacion = new Ubicacion();
            ubicacion.setNombre(nombre);
            ubicacion.setCiudad(ciudad);
            ubicacion.setDireccion(direccion);
            ubicacion.setCodigoPostal(codigoPostal);
            ubicacion.setPrecioAlquiler(precioAlquiler);
            ubicacion.setEsTienda(esTienda);

            ubicacionDao.add(ubicacion);
            mensaje = "Ubicación registrada correctamente.";
            tipoMensaje = "success";
        } catch (NumberFormatException e) {
            mensaje = "Error al registrar la ubicación: " + e.getMessage();
            tipoMensaje = "danger";
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar Ubicación</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <% if (mensaje != null && !mensaje.isEmpty()) { %>
            <div class="alert alert-<%= tipoMensaje %> alert-dismissible fade show mb-4 shadow-sm" role="alert">
                <%= mensaje %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% } %>

            <div class="card shadow">
                <div class="card-header text-center">
                    <h2 class="mb-0"><i class="fas fa-location-arrow me-2"></i>Registrar Nueva Ubicación</h2>
                </div>
                <div class="card-body p-4">
                    <form method="post" class="needs-validation" novalidate>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Nombre de la ubicación" required>
                            <label for="nombre"><i class="fas fa-map-marker-alt me-2"></i>Nombre de la Ubicación</label>
                            <div class="invalid-feedback">
                                Por favor ingrese el nombre de la ubicación.
                            </div>
                        </div>

                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="ciudad" name="ciudad" placeholder="Ciudad" required>
                            <label for="ciudad"><i class="fas fa-directions me-2"></i>Ciudad</label>
                            <div class="invalid-feedback">
                                Por favor ingrese la ciudad.
                            </div>
                        </div>

                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="direccion" name="direccion" placeholder="Dirección" required>
                            <label for="direccion"><i class="fas fa-directions me-2"></i>Dirección</label>
                            <div class="invalid-feedback">
                                Por favor ingrese la dirección.
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="number" class="form-control" id="codigoPostal" name="codigoPostal" placeholder="Código Postal" required>
                                    <label for="codigoPostal"><i class="fas fa-code me-2"></i>Código Postal</label>
                                    <div class="invalid-feedback">
                                        Por favor ingrese el código postal.
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="number" class="form-control" id="precioAlquiler" name="precioAlquiler" placeholder="Precio de Alquiler" required>
                                    <label for="precioAlquiler"><i class="fas fa-dollar-sign me-2"></i>Precio de Alquiler</label>
                                    <div class="invalid-feedback">
                                        Por favor ingrese el precio de alquiler.
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-check form-switch mb-4">
                            <input class="form-check-input" type="checkbox" id="esTienda" name="esTienda">
                            <label class="form-check-label" for="esTienda">
                                <i class="fas fa-store me-2"></i>Es una tienda
                            </label>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-success btn-lg">
                                <i class="fas fa-save me-2"></i>Registrar Ubicación
                            </button>
                        </div>
                    </form>
                </div>
                <div class="card-footer text-center text-muted py-3">
                    <small>Todos los campos son obligatorios</small>
                </div>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    (function () {
        'use strict'
        var forms = document.querySelectorAll('.needs-validation')
        Array.prototype.slice.call(forms)
            .forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault()
                        event.stopPropagation()
                    }
                    form.classList.add('was-validated')
                }, false)
            })
    })()
</script>
</body>
</html>
<jsp:include page="../utiles/footer.jsp" />
