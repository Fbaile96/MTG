<%@ page import="Torneos.Database.Database" %>
<%@ page import="Torneos.DAO.DeckDAO" %>
<%@ page import="Torneos.Objetos.Deck" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.time.LocalDate" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Database database = new Database();
    database.connect();
    DeckDAO deckDao = new DeckDAO(database.getConexion());
    String mensaje = "";
    String tipoMensaje = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            String nombre = request.getParameter("nombre");
            String contenido = request.getParameter("contenido");
            int cartasTotales = Integer.parseInt(request.getParameter("cartasTotales"));
            int porcentajeTierras = Integer.parseInt(request.getParameter("porcentajeTierras"));
            java.sql.Date fechaEnvio = java.sql.Date.valueOf(LocalDate.now());
            boolean valido = request.getParameter("valido") != null;

            Deck deck = new Deck();
            deck.setNombre(nombre);
            deck.setContenido(contenido);
            deck.setCartasTotales(cartasTotales);
            deck.setPorcentajeTierras(porcentajeTierras);
            deck.setFechaEnvio(fechaEnvio);
            deck.setValido(valido);

            deckDao.add(deck);
            mensaje = "Mazo registrado correctamente.";
            tipoMensaje = "success";
        } catch (SQLException | NumberFormatException e) {
            mensaje = "Error al registrar el mazo: " + e.getMessage();
            tipoMensaje = "danger";
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar Mazo</title>
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
                    <h2 class="mb-0"><i class="fas fa-layer-group me-2"></i>Registrar Nuevo Mazo</h2>
                </div>
                <div class="card-body p-4">
                    <form method="post" class="needs-validation" novalidate>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Nombre del mazo" required>
                            <label for="nombre"><i class="fas fa-scroll me-2"></i>Nombre del Mazo</label>
                            <div class="invalid-feedback">
                                Por favor ingrese el nombre del mazo.
                            </div>
                        </div>

                        <div class="form-floating mb-3">
                            <textarea class="form-control" placeholder="Contenido del mazo" id="contenido" name="contenido" style="height: 150px" required></textarea>
                            <label for="contenido"><i class="fas fa-file-alt me-2"></i>Contenido del Mazo</label>
                            <div class="invalid-feedback">
                                Por favor ingrese el contenido del mazo.
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="number" class="form-control" id="cartasTotales" name="cartasTotales" placeholder="Cantidad total de cartas" required>
                                    <label for="cartasTotales"><i class="fas fa-clone me-2"></i>Cartas Totales</label>
                                    <div class="invalid-feedback">
                                        Por favor ingrese la cantidad total de cartas.
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="number" class="form-control" id="porcentajeTierras" name="porcentajeTierras" placeholder="Porcentaje de tierras" required>
                                    <label for="porcentajeTierras"><i class="fas fa-percentage me-2"></i>% Tierras</label>
                                    <div class="invalid-feedback">
                                        Por favor ingrese el porcentaje de tierras.
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-check form-switch mb-4">
                            <input class="form-check-input" type="checkbox" id="valido" name="valido" checked>
                            <label class="form-check-label" for="valido">
                                <i class="fas fa-check-circle me-2"></i>Mazo Válido
                            </label>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-success btn-lg">
                                <i class="fas fa-save me-2"></i>Registrar Mazo
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
