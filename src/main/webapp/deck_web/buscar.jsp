<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ page import="Torneos.Objetos.Deck" %>
<%@ page import="Torneos.DAO.DeckDAO" %>
<%@ page import="Torneos.Database.Database" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Buscador de Mazos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="text-center mb-4">Buscar Mazos por Nombre o Contenido</h2>

    <!-- Formulario de búsqueda -->
    <form action="buscar.jsp" method="get" class="mb-4">
        <div class="input-group">
            <input type="text" name="nombre" class="form-control" placeholder="Introduce el nombre del mazo" >
            <input type="text" name="contenido" class="form-control" placeholder="Introduce el contenido del mazo" >
            <button type="submit" class="btn btn-primary">Buscar</button>
        </div>
    </form>

    <%
        Database database = new Database();
        database.connect();
        DeckDAO deckDAO = new DeckDAO(database.getConexion());
        String nombre = request.getParameter("nombre");
        String contenido = request.getParameter("contenido");
        List<Deck> resultados = null;

        if ((nombre != null && !nombre.isEmpty()) || (contenido != null && !contenido.isEmpty())) {
            try {
                resultados = deckDAO.buscarPorNombreYContenido(nombre, contenido);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        if (resultados != null && !resultados.isEmpty()) {
    %>
    <table class="table table-striped table-bordered">
        <thead class="table-dark">
        <tr>
            <th>Nombre</th>
            <th>Contenido</th>
            <th>Cartas Totales</th>
            <th>Porcentaje de Tierras</th>
            <th>Fecha de Envío</th>
            <th>Válido</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (Deck deck : resultados) {
        %>
        <tr>
            <td><%= deck.getNombre() %></td>
            <td><%= deck.getContenido() %></td>
            <td><%= deck.getCartasTotales() %></td>
            <td><%= deck.getPorcentajeTierras() %>%</td>
            <td><%= deck.getFechaEnvio() %></td>
            <td><%= deck.isValido() ? "Sí" : "No" %></td>
            <td>
                <div class="btn-group btn-group-sm">
                    <a href="vistaDetalle.jsp?id=<%= deck.getId() %>" class="btn btn-outline-primary">
                        <i class="bi bi-eye"></i>
                    </a>
                </div>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <%
    } else if ((nombre != null && !nombre.isEmpty()) || (contenido != null && !contenido.isEmpty())) {
    %>
    <div class="alert alert-warning">No se encontraron mazos con ese nombre o contenido.</div>
    <%
        }
    %>

    <a href="lista.jsp" class="btn btn-secondary mt-3">Volver a la lista completa</a>
</div>

</body>
</html>
