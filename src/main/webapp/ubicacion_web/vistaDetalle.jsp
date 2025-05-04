<%@ page import="Torneos.Objetos.Ubicacion" %>
<%@ page import="Torneos.Database.Database" %>
<%@ page import="Torneos.DAO.UbicacionDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../utiles/header.jsp" />
<% Boolean isAdmin = (Boolean) session.getAttribute("isAdmin"); %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Detalle Ubicación</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
  <h2 class="text-center mb-4">Detalles de la Ubicación</h2>

  <div class="table-responsive shadow-sm p-3 bg-white rounded">
    <table class="table table-bordered table-striped">
      <thead class="table-dark">
      <tr>
        <th>Nombre</th>
        <th>Dirección</th>
        <th>Ciudad</th>
        <th>Código Postal</th>
        <th>Precio Alquiler</th>
        <th>Fecha Registro</th>
        <th>Es Tienda</th>
        <th>Acciones</th>
      </tr>
      </thead>
      <tbody>
      <%
        Database database = new Database();
        database.connect();
        UbicacionDAO ubicacionDAO = new UbicacionDAO(database.getConexion());
        int id = Integer.parseInt(request.getParameter("id"));
        Ubicacion ubicacion = ubicacionDAO.getById(id);

        if (ubicacion != null) {
      %>
      <tr>
        <td><%= ubicacion.getNombre() %></td>
        <td><%= ubicacion.getDireccion() %></td>
        <td><%= ubicacion.getCiudad() %></td>
        <td><%= ubicacion.getCodigoPostal() %></td>
        <td><%= ubicacion.getPrecioAlquiler() %> €</td>
        <td><%= ubicacion.getFechaRegistro() %></td>
        <td><%= ubicacion.isEsTienda() ? "Sí" : "No" %></td>

        <td>
          <% if (isAdmin != null && isAdmin) { %>
          <a href="editar.jsp?id=<%= ubicacion.getId() %>" class="btn btn-warning btn-sm">Editar</a>
          <form action="eliminar.jsp" method="post" style="display:inline;">
            <input type="hidden" name="id" value="<%= ubicacion.getId() %>">
            <button type="submit" class="btn btn-danger btn-sm">Eliminar</button>
          </form>
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
    <a href="lista.jsp" class="btn btn-secondary">Volver</a>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<jsp:include page="../utiles/footer.jsp" />
