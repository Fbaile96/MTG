<%@ page import="Torneos.Objetos.Tournament" %>
<%@ page import="Torneos.Objetos.Ubicacion" %>
<%@ page import="Torneos.Database.Database" %>
<%@ page import="Torneos.DAO.TournamentDAO" %>
<%@ page import="Torneos.DAO.UbicacionDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../utiles/header.jsp" />
<% Boolean isAdmin = (Boolean) session.getAttribute("isAdmin"); %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Detalle Torneo</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="text-center mb-4">Detalles Torneo</h2>

    <div class="table-responsive shadow-sm p-3 bg-white rounded">
        <table class="table table-bordered table-striped">
            <thead class="table-dark">
            <tr>
                <th>Nombre</th>
                <th>Formato</th>
                <th>Fecha Inicio</th>
                <th>Fecha Fin</th>
                <th>Premio (€)</th>
                <th>Max. Jugadores</th>
                <th>Invitación</th>
                <th>Ubicación</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <%
                // Conectar a la base de datos y obtener los torneos
                Database database = new Database();
                database.connect();
                TournamentDAO torneoDAO = new TournamentDAO(database.getConexion());
                int id = Integer.parseInt(request.getParameter("id")); // Obtener el id del torneo
                Tournament torneo = torneoDAO.buscarPorId(id); // Buscar el torneo

                if (torneo != null) {
                    // Obtener la ubicación del torneo
                    UbicacionDAO ubicacionDAO = new UbicacionDAO(database.getConexion());
                    Ubicacion ubicacion = ubicacionDAO.getById(torneo.getUbicacion_id());
            %>
            <tr>
                <td><%= torneo.getNombre() %></td>
                <td><%= torneo.getFormato() %></td>
                <td><%= torneo.getFechaInicio() %></td>
                <td><%= torneo.getFechaFin() %></td>
                <td><%= torneo.getPremio() %></td>
                <td><%= torneo.getMaxJugadores() %></td>
                <td><%= torneo.isInvitacion() ? "Sí" : "No" %></td>
                <td>
                    <%
                        if (ubicacion != null) {
                    %>
                    <a href="../ubicacion_web/vistaDetalle.jsp?id=<%= ubicacion.getId() %>">
                        <%= ubicacion.getNombre() %> - <%= ubicacion.getCiudad() %>
                    </a>
                    <%
                    } else {
                    %>
                    <span>No disponible</span>
                    <%
                        }
                    %>
                </td>

                <td>
                    <% if (isAdmin != null && isAdmin) { %>
                    <div class="btn-group btn-group-sm">
                        <a href="editar.jsp?id=<%= torneo.getId() %>" class="btn btn-warning btn-sm">Editar</a>
                        <form action="eliminar.jsp" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="<%= torneo.getId() %>">
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
                database.disconect();
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