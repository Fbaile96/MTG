<%@ page import="java.sql.*, java.text.*, java.util.*, Torneos.DAO.TournamentDAO, Torneos.Objetos.Tournament, Torneos.Database.Database" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../utiles/header.jsp" />
<%
  Database database = new Database();
  database.connect();
  TournamentDAO torneoDAO = new TournamentDAO(database.getConexion());
  List<Tournament> torneos = new ArrayList<>();
  String mensaje = "";
  String tipoMensaje = "";
  int pagina = 1;
  int torneosPorPagina = 4;

  String paramPagina = request.getParameter("pagina");
  if (paramPagina != null) {
    try {
      pagina = Integer.parseInt(paramPagina);
      if (pagina < 1) pagina = 1;
    } catch (NumberFormatException e) {
      pagina = 1;
    }
  }

  int offset = (pagina - 1) * torneosPorPagina;

  try {
    torneos = torneoDAO.listAll(torneosPorPagina, offset);
  } catch (Exception e) {
    mensaje = "Error al recuperar los torneos: " + e.getMessage();
    tipoMensaje = "danger";
    e.printStackTrace();
  }

  // Manejo de mensajes de sesión (para redirecciones)
  String mensajeSesion = (String) session.getAttribute("mensaje");
  String tipoMensajeSesion = (String) session.getAttribute("tipoMensaje");

  if (mensajeSesion != null && !mensajeSesion.isEmpty()) {
    mensaje = mensajeSesion;
    tipoMensaje = tipoMensajeSesion;
    session.removeAttribute("mensaje");
    session.removeAttribute("tipoMensaje");
  }
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Lista de Torneos</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<div class="container mt-5">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Lista de Torneos</h2>
  </div>

  <% if (!mensaje.isEmpty()) { %>
  <div class="alert alert-<%= tipoMensaje %> alert-dismissible fade show" role="alert">
    <%= mensaje %>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <% } %>

  <div class="card shadow">
    <div class="card-body">
      <% if (torneos.isEmpty()) { %>
      <div class="text-center p-4">
        <p class="text-muted">No hay torneos registrados.</p>
      </div>
      <% } else { %>
      <div class="table-responsive">
        <table class="table table-striped table-hover">
          <thead>
          <tr>
            <th>Nombre</th>
            <th>Formato</th>
            <th>Premio (€)</th>
            <th>Por Invitación</th>
            <th>Acciones</th>
          </tr>
          </thead>
          <tbody>
          <% for (Tournament torneo : torneos) { %>
          <tr>
            <td><%= torneo.getNombre() %></td>
            <td><%= torneo.getFormato() %></td>
            <td><%= String.format("%.2f", torneo.getPremio()) %></td>
            <td>
              <% if (torneo.isInvitacion()) { %>
              <span class="badge bg-info">Sí</span>
              <% } else { %>
              <span class="badge bg-secondary">No</span>
              <% } %>
            </td>
            <td>
              <div class="btn-group btn-group-sm">
                <a href="vistaDetalle.jsp?id=<%= torneo.getId() %>" class="btn btn-outline-primary">
                  <i class="bi bi-eye"></i>
                </a>
                </div>
            </td>
          </tr>
          <% } %>
          </tbody>
        </table>
      </div>
      <% } %>
    </div>
  </div>
  <div class="d-grid gap-2">
    <a href="../main.jsp" class="btn btn-secondary">Volver</a>
</div>
  <div class="d-flex justify-content-between mt-3">
    <% if (pagina > 1) { %>
    <a href="lista.jsp?pagina=<%= pagina - 1 %>" class="btn btn-outline-primary">
      <i class="bi bi-chevron-left"></i> Anterior
    </a>
    <% } else { %>
    <span></span>
    <% } %>

    <% if (torneos.size() == torneosPorPagina) { %>
    <a href="lista.jsp?pagina=<%= pagina + 1 %>" class="btn btn-outline-primary">
      Siguiente <i class="bi bi-chevron-right"></i>
    </a>
    <% } else { %>
    <span></span>
    <% } %>
  </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<jsp:include page="../utiles/footer.jsp" />