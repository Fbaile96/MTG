<%@ page import="java.sql.*, java.text.*, java.util.*, Torneos.DAO.TournamentDAO, Torneos.Objetos.Tournament, Torneos.Database.Database" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../utiles/header.jsp" />
<%
  Database database = new Database();
  database.connect();
  TournamentDAO torneoDAO = new TournamentDAO(database.getConexion());
  String mensaje = "";
  String tipoMensaje = "";

  if ("POST".equalsIgnoreCase(request.getMethod())) {
    try {
      // Obtener y validar los parámetros del formulario
      String nombre = request.getParameter("nombre");
      String formato = request.getParameter("formato");
      String fechaInicio = request.getParameter("fechaInicio");
      String fechaFin = request.getParameter("fechaFin");
      String premioStr = request.getParameter("premio");
      String maxJugadoresStr = request.getParameter("maxJugadores");
      boolean invitacion = request.getParameter("invitacion") != null;
      String locationIdStr = request.getParameter("locationId");
      int locationId = 0;
      try {
        locationId = Integer.parseInt(locationIdStr);
      } catch (NumberFormatException e) {
        throw new IllegalArgumentException("La ubicación seleccionada no es válida");
      }

      // Validaciones básicas
      if (nombre == null || nombre.trim().isEmpty()) {
        throw new IllegalArgumentException("El nombre del torneo es obligatorio");
      }

      if (formato == null || formato.trim().isEmpty()) {
        throw new IllegalArgumentException("El formato del torneo es obligatorio");
      }

      // Conversión y validación de fecha
      java.sql.Date sqlFechaInicio = null;
      java.sql.Date sqlFechaFin = null;

      try {
        sqlFechaInicio = java.sql.Date.valueOf(fechaInicio);
        sqlFechaFin = java.sql.Date.valueOf(fechaFin);

        if (sqlFechaFin.before(sqlFechaInicio)) {
          throw new IllegalArgumentException("La fecha de fin no puede ser anterior a la fecha de inicio");
        }
      } catch (IllegalArgumentException e) {
        throw new IllegalArgumentException("Formato de fecha inválido");
      }

      // Conversión y validación de valores numéricos
      double premio = 0;
      int maxJugadores = 0;

      try {
        premio = Double.parseDouble(premioStr);
        if (premio < 0) {
          throw new IllegalArgumentException("El premio no puede ser negativo");
        }
      } catch (NumberFormatException e) {
        throw new IllegalArgumentException("El premio debe ser un valor numérico válido");
      }

      try {
        maxJugadores = Integer.parseInt(maxJugadoresStr);
        if (maxJugadores <= 0) {
          throw new IllegalArgumentException("El número máximo de jugadores debe ser mayor que cero");
        }
      } catch (NumberFormatException e) {
        throw new IllegalArgumentException("El número máximo de jugadores debe ser un número entero válido");
      }

      // Creación del objeto Torneo
      Tournament torneo = new Tournament();
      torneo.setNombre(nombre);
      torneo.setFormato(formato);
      torneo.setFechaInicio(sqlFechaInicio);
      torneo.setFechaFin(sqlFechaFin);
      torneo.setPremio((float) premio);
      torneo.setMaxJugadores(maxJugadores);
      torneo.setInvitacion(invitacion);
      torneo.setUbicacion_id(locationId);


      torneoDAO.crear(torneo);

      mensaje = "Torneo guardado correctamente.";
      tipoMensaje = "success";

    } catch (IllegalArgumentException e) {
      mensaje = "Error de validación: " + e.getMessage();
      tipoMensaje = "warning";
    } catch (Exception e) {
      mensaje = "Error al guardar el torneo: " + e.getMessage();
      tipoMensaje = "danger";
      e.printStackTrace(); // Registrar el error en el log del servidor
    }
  }
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Crear Torneo</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
  <h2 class="text-center mb-4">Crear Nuevo Torneo</h2>

  <% if (!mensaje.isEmpty()) { %>
  <div class="alert alert-<%= tipoMensaje %> alert-dismissible fade show text-center" role="alert">
    <%= mensaje %>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <% } %>

  <div class="card shadow">
    <div class="card-body">
      <form action="crear.jsp" method="post" id="formTorneo" novalidate>
      <div class="mb-3">
          <label for="nombre" class="form-label">Nombre del Torneo</label>
          <input type="text" class="form-control" id="nombre" name="nombre" required>
          <div class="invalid-feedback">Por favor ingresa un nombre para el torneo.</div>
        </div>
        <div class="mb-3">
          <label for="formato" class="form-label">Formato</label>
          <select class="form-select" id="formato" name="formato" required>
            <option value="">Seleccione un formato</option>
            <option value="Standard">Standard</option>
            <option value="Modern">Modern</option>
            <option value="Legacy">Legacy</option>
            <option value="Commander">Commander</option>
            <option value="Limited">Limited</option>
            <option value="Otro">Otro</option>
          </select>
          <div class="invalid-feedback">Por favor selecciona un formato.</div>
        </div>
        <div class="mb-3">
          <label for="fechaInicio" class="form-label">Fecha de Inicio</label>
          <input type="date" class="form-control" id="fechaInicio" name="fechaInicio" required>
          <div class="invalid-feedback">Por favor ingresa una fecha de inicio válida.</div>
        </div>
        <div class="mb-3">
          <label for="fechaFin" class="form-label">Fecha de Fin</label>
          <input type="date" class="form-control" id="fechaFin" name="fechaFin" required>
          <div class="invalid-feedback">Por favor ingresa una fecha de fin válida.</div>
        </div>
        <div class="mb-3">
          <label for="premio" class="form-label">Premio Total (€)</label>
          <input type="number" step="0.01" class="form-control" id="premio" name="premio" min="0" required>
          <div class="invalid-feedback">Por favor ingresa un valor válido para el premio.</div>
        </div>
        <div class="mb-3">
          <label for="maxJugadores" class="form-label">Máximo de Jugadores</label>
          <input type="number" class="form-control" id="maxJugadores" name="maxJugadores" min="1" required>
          <div class="invalid-feedback">Por favor ingresa un número válido de jugadores máximo.</div>
        </div>
        <div class="mb-3 form-check">
          <input type="checkbox" class="form-check-input" id="invitacion" name="invitacion">
          <label class="form-check-label" for="invitacion">Solo por invitación</label>
        </div>
        <div class="mb-3">
        <label for="locationId" class="form-label">Ubicación</label>
        <select class="form-select" id="locationId" name="locationId" required>
          <option value="">Seleccione una ubicación</option>
          <%
            // Usar la clase correcta UbicacionDAO y su respectivo paquete
            Torneos.DAO.UbicacionDAO ubicacionDAO = new Torneos.DAO.UbicacionDAO(database.getConexion());
            List<Torneos.Objetos.Ubicacion> ubicaciones = ubicacionDAO.getAll();
            for (Torneos.Objetos.Ubicacion ubicacion : ubicaciones) {
          %>
          <option value="<%= ubicacion.getId() %>"><%= ubicacion.getNombre() %> - <%= ubicacion.getCiudad() %></option>
          <%
            }
          %>

        </select>
        <div class="invalid-feedback">Por favor selecciona una ubicación.</div>
    </div>
        <div class="d-grid gap-2">
          <button type="submit" class="btn btn-primary">Guardar Torneo</button>
          <a href="lista.jsp" class="btn btn-secondary">Lista de Torneos</a>
        </div>
      </form>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Validación del lado del cliente
  document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('formTorneo');
    form.addEventListener('submit', function(event) {
      if (!form.checkValidity()) {
        event.preventDefault();
        event.stopPropagation();
      }

      // Validación adicional para fechas
      const fechaInicio = document.getElementById('fechaInicio').value;
      const fechaFin = document.getElementById('fechaFin').value;

      if (fechaInicio && fechaFin && fechaFin < fechaInicio) {
        event.preventDefault();
        alert('La fecha de fin no puede ser anterior a la fecha de inicio');
      }

      form.classList.add('was-validated');
    }, false);
  });
</script>
</body>
</html>
<jsp:include page="../utiles/footer.jsp" />