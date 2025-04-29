<%@ page import="Torneos.Objetos.Deck" %>
<%@ page import="Torneos.Database.Database" %>
<%@ page import="Torneos.DAO.DeckDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../utiles/header.jsp" />
<%Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Detalle Deck</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="text-center mb-4">Detalles del Deck</h2>

    <div class="table-responsive shadow-sm p-3 bg-white rounded">
        <table class="table table-bordered table-striped">
            <thead class="table-dark">
            <tr>
                <th>Nombre</th>
                <th>Contenido</th>
                <th>Cartas Totales</th>
                <th>Porcentaje Tierras</th>
                <th>Fecha Envío</th>
                <th>Válido</th>
                <th>Creador</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <%
                Database database = new Database();
                database.connect();
                DeckDAO deckDAO = new DeckDAO(database.getConexion());
                int id = Integer.parseInt(request.getParameter("id"));
                Deck deck = deckDAO.buscarPorId(id);

                if (deck != null) {
            %>
            <tr>
                <td><%= deck.getNombre() %></td>
                <td><%= deck.getContenido() %></td>
                <td><%= deck.getCartasTotales() %></td>
                <td><%= deck.getPorcentajeTierras() %>%</td>
                <td><%= deck.getFechaEnvio() %></td>
                <td><%= deck.isValido() ? "Sí" : "No" %></td>
                <td><%= deck.getPlayerNickname() %></td>

                <td>
                    <% if (isAdmin != null && isAdmin) { %>

                    <a href="editar.jsp?id=<%= deck.getId() %>" class="btn btn-warning btn-sm">Editar</a>
                    <form action="eliminar.jsp" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="<%= deck.getId() %>">
                        <button type="submit" class="btn btn-danger btn-sm">Eliminar</button>
                    </form>
                    <% } else { %>
                    <div>Requiere Admin</div>
                    <% } %></td>
                </td>
            </tr>
            <%
                }
                database.disconect();
            %>
            </tbody>
        </table>
    </div>

    <div class="d-grid gap-2">
        <a href="lista.jsp" class="btn btn-secondary">Volver</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<jsp:include page="../utiles/footer.jsp" />
