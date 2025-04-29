<%@ page import="Torneos.Objetos.Deck" %>
<%@ page import="Torneos.Database.Database" %>
<%@ page import="Torneos.DAO.DeckDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../utiles/header.jsp" />
<%
    String mensaje = "";
    Deck deck = null;

    Database database = new Database();
    database.connect();
    DeckDAO deckDao = new DeckDAO(database.getConexion());

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        int id = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String contenido = request.getParameter("contenido");
        int cartasTotales = Integer.parseInt(request.getParameter("cartasTotales"));
        int porcentajeTierras = Integer.parseInt(request.getParameter("porcentajeTierras"));
        java.sql.Date fechaEnvio = java.sql.Date.valueOf(request.getParameter("fechaEnvio"));
        boolean valido = request.getParameter("valido") != null;

        deck = new Deck(id, nombre, contenido, cartasTotales, porcentajeTierras, fechaEnvio, valido);
        deckDao.actualizar(deck);
        mensaje = "Deck actualizado correctamente.";
    } else {
        int id = Integer.parseInt(request.getParameter("id"));
        deck = deckDao.buscarPorId(id);
    }

    database.disconect();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Deck</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="text-center mb-4">Editar Deck</h2>

    <% if (!mensaje.isEmpty()) { %>
    <div class="alert alert-success"><%= mensaje %></div>
    <% } %>

    <form method="post" class="shadow p-4 bg-white rounded">
        <input type="hidden" name="id" value="<%= deck.getId() %>">

        <div class="mb-3">
            <label class="form-label">Nombre</label>
            <input type="text" class="form-control" name="nombre" value="<%= deck.getNombre() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Contenido</label>
            <textarea class="form-control" name="contenido" rows="4" required><%= deck.getContenido() %></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Cartas Totales</label>
            <input type="number" class="form-control" name="cartasTotales" value="<%= deck.getCartasTotales() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Porcentaje Tierras</label>
            <input type="number" class="form-control" name="porcentajeTierras" value="<%= deck.getPorcentajeTierras() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Fecha de Envío</label>
            <input type="date" class="form-control" name="fechaEnvio" value="<%= deck.getFechaEnvio() %>" required>
        </div>

        <div class="form-check mb-3">
            <input class="form-check-input" type="checkbox" name="valido" <%= deck.isValido() ? "checked" : "" %>>
            <label class="form-check-label">Válido</label>
        </div>

        <button type="submit" class="btn btn-primary">Guardar Cambios</button>
        <a href="lista.jsp" class="btn btn-secondary">Volver</a>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<jsp:include page="../utiles/footer.jsp" />