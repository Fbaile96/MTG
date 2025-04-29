<%@ page import="Torneos.Objetos.Player" %>
<%@ page import="Torneos.Database.Database" %>
<%@ page import="Torneos.DAO.PlayerDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../utiles/header.jsp" />
<%Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Detalle Jugador</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="text-center mb-4">Detalles Jugador</h2>

    <div class="table-responsive shadow-sm p-3 bg-white rounded">
        <table class="table table-bordered table-striped">
            <thead class="table-dark">
            <tr>
                <th>Nombre</th>
                <th>Email</th>
                <th>Nickname</th>
                <th>Puntos Ranking</th>
                <th>Fecha Registro</th>
                <th>Activo</th>
                <th>Administrador</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <%
                // Conectar a la base de datos y obtener el jugador directamente
                Database database = new Database();
                database.connect();
                PlayerDAO playerDAO = new PlayerDAO(database.getConexion());
                int id = Integer.parseInt(request.getParameter("id"));
                Player jugador = playerDAO.buscarPorId(id);

                if (jugador != null) {
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
                    <% if (isAdmin != null && isAdmin) { %>
                    <!-- Solo los administradores pueden ver estas opciones -->
                    <div class="btn-group btn-group-sm">
                        <a href="editar.jsp?id=<%= jugador.getId() %>" class="btn btn-outline-primary">
                            <i class="bi bi-pencil"></i> Modificar
                        </a>
                        <form action="eliminar.jsp" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="<%= jugador.getId() %>">
                            <button type="submit" class="btn btn-danger btn-sm">Eliminar</button>
                        </form>
                    </div>
                    <% } else { %>
                    <div>Requiere Admin</div>
                    <% } %>
                </td>
            </tr>
            <%
                }
                database.disconect(); // cerrar conexión
            %>
            </tbody>
        </table>
    </div>

    <div class="d-grid gap-2">
        <a href="../main.jsp" class="btn btn-secondary">Volver</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<jsp:include page="../utiles/footer.jsp" />