<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ page import="Torneos.Objetos.Tournament" %>
<%@ page import="Torneos.DAO.TournamentDAO" %>
<%@ page import="Torneos.Database.Database" %>
<jsp:include page="../utiles/header.jsp" />

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Buscador</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">

</head>
<body class="bg-light">

<div class="container mt-5">
  <h2 class="text-center mb-4">Buscar Torneos por Formato</h2>

  <form action="buscar.jsp" method="get" class="mb-4">
    <div class="input-group">
      <input type="text" name="nombre" class="form-control" placeholder="Introduce el nombre del torneo">
      <input type="text" name="formato" class="form-control" placeholder="Introduce el formato (Ej: Modern, Commander, etc.)">
      <button type="submit" class="btn btn-primary">Buscar</button>
    </div>
  </form>


  <%
    Database database = new Database();
    database.connect();
    TournamentDAO torneoDAO = new TournamentDAO(database.getConexion());
    String nombre = request.getParameter("nombre");
    String formato = request.getParameter("formato");
    List<Tournament> resultados = null;

    if ((nombre != null && !nombre.isEmpty()) || (formato != null && !formato.isEmpty())) {
      try {
        resultados = torneoDAO.buscarPorNombreYFormato(nombre, formato);
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
      <th>Formato</th>
      <th>Fecha Inicio</th>
      <th>Fecha Fin</th>
      <th>Premio (€)</th>
      <th>Máx. Jugadores</th>
      <th>Invitación</th>
      <th>Acciones</th>
    </tr>
    </thead>
    <tbody>
    <%
      for (Tournament tournament : resultados) {
    %>
    <tr>
      <td><%= tournament.getNombre() %></td>
      <td><%= tournament.getFormato() %></td>
      <td><%= tournament.getFechaInicio() %></td>
      <td><%= tournament.getFechaFin() %></td>
      <td><%= tournament.getPremio() %></td>
      <td><%= tournament.getMaxJugadores() %></td>
      <td><%= tournament.isInvitacion() ? "Sí" : "No" %></td>
      <td>
        <div class="btn-group btn-group-sm">
          <a href="vistaDetalle.jsp?id=<%= tournament.getId() %>" class="btn btn-outline-primary">
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
  } else if (formato != null) {
  %>
  <div class="alert alert-warning">No se encontraron torneos con ese formato.</div>
  <%
    }
  %>

  <a href="lista.jsp" class="btn btn-secondary mt-3">Volver a la lista completa</a>
</div>

</body>
</html>
<jsp:include page="../utiles/footer.jsp" />