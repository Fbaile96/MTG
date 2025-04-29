<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ page import="Torneos.Objetos.Player" %>
<%@ page import="Torneos.DAO.PlayerDAO" %>
<%@ page import="Torneos.Database.Database" %>
<%@ page import="Torneos.DAO.PlayerDAO" %>
<jsp:include page="../utiles/header.jsp" />

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Buscador de Jugadores</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">

</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="text-center mb-4">Buscar Jugadores por Nombre o Nickname</h2>

    <!-- Formulario de búsqueda -->
    <form action="buscar.jsp" method="get" class="mb-4">
        <div class="input-group">
            <input type="text" name="nombre" class="form-control" placeholder="Introduce el nombre del jugador" >
            <input type="text" name="nickname" class="form-control" placeholder="Introduce el nickname del jugador" >
            <button type="submit" class="btn btn-primary">Buscar</button>
        </div>
    </form>

    <%
        Database database = new Database();
        database.connect();
        PlayerDAO jugadorDAO = new PlayerDAO(database.getConexion());
        String nombre = request.getParameter("nombre");
        String nickname = request.getParameter("nickname");
        List<Player> resultados = null;

        if ((nombre != null && !nombre.isEmpty()) || (nickname != null && !nickname.isEmpty())) {
            try {
                resultados = jugadorDAO.buscarPorNombreYNickname(nombre, nickname);
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
            <th>Email</th>
            <th>Nickname</th>
            <th>Puntos de Ranking</th>
            <th>Fecha de Registro</th>
            <th>Activo</th>
            <th>Administrador</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (Player jugador : resultados) {
        %>
        <tr>
            <td><%= jugador.getNombre() %></td>
            <td><%= jugador.getEmail() %></td>
            <td><%= jugador.getNickname() %></td>
            <td><%= jugador.getPuntosRanking() %></td>
            <td><%= jugador.getFechaRegistro() %></td>
            <td><%= jugador.isActivo() ? "Sí" : "No" %></td>
            <td><%= jugador.isAdministrador() ? "Sí" : "No" %></td>
            <td>
                <div class="btn-group btn-group-sm">
                    <a href="vistaDetalle.jsp?id=<%= jugador.getId() %>" class="btn btn-outline-primary">
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
    } else if ((nombre != null && !nombre.isEmpty()) || (nickname != null && !nickname.isEmpty())) {
    %>
    <div class="alert alert-warning">No se encontraron jugadores con ese nombre o nickname.</div>
    <%
        }
    %>

    <a href="lista.jsp" class="btn btn-secondary mt-3">Volver a la lista completa</a>
</div>

</body>
</html>
<jsp:include page="../utiles/footer.jsp" />