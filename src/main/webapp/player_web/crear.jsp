<%@ page import="Torneos.Database.Database" %>
<%@ page import="Torneos.DAO.PlayerDAO" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="Torneos.Objetos.Player" %>
<%@ page import="java.time.LocalDate" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../utiles/header.jsp" />
<%
    Database database = new Database();
    database.connect();
    PlayerDAO playerDao = new PlayerDAO(database.getConexion());
    String mensaje = "";
    String tipoMensaje = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            // Obtener y validar los parámetros del formulario
            String nombre = request.getParameter("nombre");
            String email = request.getParameter("email");
            String nickname = request.getParameter("nickname");
            int puntosRanking = Integer.parseInt(request.getParameter("puntosRanking"));

            // Convertir LocalDate a java.sql.Date
            LocalDate fechaRegistro = LocalDate.now();
            java.sql.Date sqlFechaRegistro = java.sql.Date.valueOf(fechaRegistro); // Convertir a java.sql.Date

            boolean activo = request.getParameter("activo") != null;
            String password = request.getParameter("password");
            boolean administrador = request.getParameter("administrador") != null;

            // Crear el objeto Player
            Player player = new Player();
            player.setNombre(nombre);
            player.setEmail(email);
            player.setNickname(nickname);
            player.setPuntosRanking(puntosRanking);
            player.setFechaRegistro(sqlFechaRegistro); //todo Usar java.sql.Date aquí
            player.setActivo(activo);
            player.setPassword(password);
            player.setAdministrador(administrador);

            // Insertar en la base de datos
            playerDao.add(player);
            mensaje = "Jugador registrado correctamente.";
            tipoMensaje = "success";

        } catch (SQLException | NumberFormatException e) {
            mensaje = "Error al registrar el jugador: " + e.getMessage();
            tipoMensaje = "danger";
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Jugador</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <% if (mensaje != null && !mensaje.isEmpty()) { %>
            <div class="alert alert-<%= tipoMensaje %> alert-dismissible fade show mb-4 shadow-sm" role="alert">
                <% if ("success".equals(tipoMensaje)) { %>
                <i class="fas fa-check-circle me-2"></i>
                <% } else { %>
                <i class="fas fa-exclamation-circle me-2"></i>
                <% } %>
                <%= mensaje %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% } %>

            <div class="card shadow">
                <div class="card-header text-center">
                    <h2 class="mb-0"><i class="fas fa-user-plus me-2"></i>Registrar Nuevo Jugador</h2>
                </div>
                <div class="card-body p-4">
                    <form method="post" class="needs-validation" novalidate>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Nombre completo" required>
                                    <label for="nombre"><i class="fas fa-user me-2"></i>Nombre</label>
                                    <div class="invalid-feedback">
                                        Por favor ingrese un nombre.
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" id="nickname" name="nickname" placeholder="Nickname" required>
                                    <label for="nickname"><i class="fas fa-user-tag me-2"></i>Nickname</label>
                                    <div class="invalid-feedback">
                                        Por favor ingrese un nickname.
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-floating mb-3">
                            <input type="email" class="form-control" id="email" name="email" placeholder="name@example.com" required>
                            <label for="email"><i class="fas fa-envelope me-2"></i>Correo Electrónico</label>
                            <div class="invalid-feedback">
                                Por favor ingrese un correo electrónico válido.
                            </div>
                        </div>

                        <div class="input-group mb-3">
                            <span class="input-group-text"><i class="fas fa-trophy"></i></span>
                            <div class="form-floating">
                                <input type="number" class="form-control" id="puntosRanking" name="puntosRanking" placeholder="Puntos" required>
                                <label for="puntosRanking">Puntos de Ranking</label>
                            </div>
                            <div class="invalid-feedback">
                                Por favor ingrese los puntos de ranking.
                            </div>
                        </div>

                        <div class="form-floating mb-3">
                            <input type="password" class="form-control" id="password" name="password" placeholder="Contraseña" required>
                            <label for="password"><i class="fas fa-lock me-2"></i>Contraseña</label>
                            <div class="invalid-feedback">
                                Por favor ingrese una contraseña.
                            </div>
                        </div>

                        <div class="row mb-4">
                            <div class="col-md-6">
                                <div class="form-check form-switch mb-3">
                                    <input class="form-check-input" type="checkbox" id="activo" name="activo" checked>
                                    <label class="form-check-label" for="activo">
                                        <i class="fas fa-toggle-on me-2"></i>Jugador Activo
                                    </label>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="administrador" name="administrador">
                                    <label class="form-check-label" for="administrador">
                                        <i class="fas fa-user-shield me-2"></i>Administrador
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary btn-lg">
                                <i class="fas fa-save me-2"></i>Registrar Jugador
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-wfS0xOjBXTrY3WR5z9u9k8qY/F5JrE7/jGT4W9BzFn9g7A5jLEByHac2DZlF1zty" crossorigin="anonymous"></script>
<script>
    // JavaScript para validación del formulario
    (function () {
        'use strict'

        // Fetch all forms that need validation
        var forms = document.querySelectorAll('.needs-validation')

        // Loop over them and prevent submission
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