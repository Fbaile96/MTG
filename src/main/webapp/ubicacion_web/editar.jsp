<%@ page import="Torneos.Objetos.Ubicacion" %>
<%@ page import="Torneos.Database.Database" %>
<%@ page import="Torneos.DAO.UbicacionDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../utiles/header.jsp" />
<%
  String mensaje = "";
  Ubicacion ubicacion = null;

  // Conexión a la base de datos
  Database database = new Database();
  database.connect();
  UbicacionDAO ubicacionDao = new UbicacionDAO(database.getConexion());

  // Si es un POST, se actualiza la ubicación
  if ("POST".equalsIgnoreCase(request.getMethod())) {
    int id = Integer.parseInt(request.getParameter("id"));
    String nombre = request.getParameter("nombre");
    String direccion = request.getParameter("direccion");
    String ciudad = request.getParameter("ciudad");
    int codigoPostal = Integer.parseInt(request.getParameter("codigo_postal"));
    double precioAlquiler = Double.parseDouble(request.getParameter("precio_alquiler"));
    boolean esTienda = Boolean.parseBoolean(request.getParameter("es_tienda"));

    ubicacion = new Ubicacion(id, nombre, direccion, ciudad, codigoPostal, precioAlquiler, esTienda);
    ubicacionDao.actualizar(ubicacion);
    mensaje = "Ubicación actualizada correctamente.";
  } else {
    // Si es GET, se obtiene la ubicación para editar
    int id = Integer.parseInt(request.getParameter("id"));
    ubicacion = ubicacionDao.getById(id);
  }

  // Cerrar la conexión
  database.disconect();
%>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Editar Ubicación</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
  <h2 class="text-center mb-4">Editar Ubicación</h2>

  <% if (!mensaje.isEmpty()) { %>
  <div class="alert alert-success"><%= mensaje %></div>
  <% } %>

  <form method="post" class="shadow p-4 bg-white rounded">
    <input type="hidden" name="id" value="<%= ubicacion.getId() %>">

    <div class="mb-3">
      <label class="form-label">Nombre</label>
      <input type="text" class="form-control" name="nombre" value="<%= ubicacion.getNombre() %>" required>
    </div>

    <div class="mb-3">
      <label class="form-label">Dirección</label>
      <input type="text" class="form-control" name="direccion" value="<%= ubicacion.getDireccion() %>" required>
    </div>

    <div class="mb-3">
      <label class="form-label">Ciudad</label>
      <input type="text" class="form-control" name="ciudad" value="<%= ubicacion.getCiudad() %>" required>
    </div>

    <div class="mb-3">
      <label class="form-label">Código Postal</label>
      <input type="number" class="form-control" name="codigo_postal" value="<%= ubicacion.getCodigoPostal() %>" required>
    </div>

    <div class="mb-3">
      <label class="form-label">Precio de Alquiler</label>
      <input type="number" step="0.01" class="form-control" name="precio_alquiler" value="<%= ubicacion.getPrecioAlquiler() %>" required>
    </div>

    <div class="mb-3">
      <label class="form-label">¿Es tienda?</label>
      <select class="form-control" name="es_tienda">
        <option value="true" <%= ubicacion.isEsTienda() ? "selected" : "" %>>Sí</option>
        <option value="false" <%= !ubicacion.isEsTienda() ? "selected" : "" %>>No</option>
      </select>
    </div>

    <button type="submit" class="btn btn-primary">Guardar Cambios</button>
    <a href="lista.jsp" class="btn btn-secondary">Volver</a>
  </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<jsp:include page="../utiles/footer.jsp" />
