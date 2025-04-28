<%@ page import="Torneos.Objetos.Tournament" %>
<%@ page import="Torneos.Database.Database" %>
<%@ page import="Torneos.DAO.TournamentDAO" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String mensaje = "";
  Tournament torneo = null;

// Conexión a la base de datos
  Database database = new Database();
  database.connect();
  TournamentDAO torneoDAO = new TournamentDAO(database.getConexion());

  if ("POST".equalsIgnoreCase(request.getMethod())) {
    // Obtener datos del formulario
    int id = Integer.parseInt(request.getParameter("id"));
    String nombre = request.getParameter("nombre");
    String formato = request.getParameter("formato");
    String fechaInicioStr = request.getParameter("fechaInicio");
    String fechaFinStr = request.getParameter("fechaFin");

    // Conversión String -> util.Date
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    Date fechaInicio = null;
    Date fechaFin = null;
    try {
      fechaInicio = sdf.parse(fechaInicioStr);
      fechaFin = sdf.parse(fechaFinStr);
    } catch (Exception e) {
      e.printStackTrace();
      mensaje = "Error en el formato de fechas.";
    }

    // Conversión util.Date -> sql.Date
    java.sql.Date sqlFechaInicio = null;
    java.sql.Date sqlFechaFin = null;
    if (fechaInicio != null && fechaFin != null) {
      sqlFechaInicio = new java.sql.Date(fechaInicio.getTime());
      sqlFechaFin = new java.sql.Date(fechaFin.getTime());
    }

    double premio = Double.parseDouble(request.getParameter("premio"));
    int maxJugadores = Integer.parseInt(request.getParameter("maxJugadores"));
    boolean invitacion = request.getParameter("invitacion") != null;

    torneo = new Tournament(id, nombre, formato, sqlFechaInicio, sqlFechaFin, premio, maxJugadores, invitacion);
    torneoDAO.actualizar(torneo);
    mensaje = "Torneo actualizado correctamente.";

  } else {
    int id = Integer.parseInt(request.getParameter("id"));
    torneo = torneoDAO.buscarPorId(id);
  }

  database.disconect();
%>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Editar Torneo</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
  <h2 class="text-center mb-4">Editar Torneo</h2>

  <% if (!mensaje.isEmpty()) { %>
  <div class="alert alert-success"><%= mensaje %></div>
  <% } %>

  <form method="post" class="shadow p-4 bg-white rounded">
    <input type="hidden" name="id" value="<%= torneo.getId() %>">

    <div class="mb-3">
      <label class="form-label">Nombre</label>
      <input type="text" class="form-control" name="nombre" value="<%= torneo.getNombre() %>" required>
    </div>

    <div class="mb-3">
      <label class="form-label">Formato</label>
      <input type="text" class="form-control" name="formato" value="<%= torneo.getFormato() %>" required>
    </div>

    <div class="mb-3">
      <label class="form-label">Fecha de Inicio</label>
      <input type="date" class="form-control" name="fechaInicio" value="<%= torneo.getFechaInicio() %>" required>
    </div>

    <div class="mb-3">
      <label class="form-label">Fecha de Fin</label>
      <input type="date" class="form-control" name="fechaFin" value="<%= torneo.getFechaFin() %>" required>
    </div>

    <div class="mb-3">
      <label class="form-label">Premio (€)</label>
      <input type="number" step="0.01" class="form-control" name="premio" value="<%= torneo.getPremio() %>" required>
    </div>

    <div class="mb-3">
      <label class="form-label">Máximo de Jugadores</label>
      <input type="number" class="form-control" name="maxJugadores" value="<%= torneo.getMaxJugadores() %>" required>
    </div>

    <div class="form-check mb-3">
      <input class="form-check-input" type="checkbox" name="invitacion" <%= torneo.isInvitacion() ? "checked" : "" %>>
      <label class="form-check-label">Torneo por invitación</label>
    </div>

    <button type="submit" class="btn btn-primary">Guardar Cambios</button>
    <a href="lista.jsp" class="btn btn-secondary">Volver</a>
  </form>
</div>
</body>
</html>
