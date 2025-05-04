<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Torneos.Objetos.Ubicacion" %>
<%@ page import="Torneos.DAO.UbicacionDAO" %>
<%@ page import="Torneos.Database.Database" %>
<jsp:include page="../utiles/header.jsp" />

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Buscador de Ubicaciones</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="text-center mb-4">Buscar Ubicaciones por Nombre y Ciudad</h2>

    <form action="buscar.jsp" method="get" class="mb-4">
        <div class="input-group">
            <input type="text" name="nombre" class="form-control" placeholder="Introduce el nombre de la ubicación">
            <input type="text" name="ciudad" class="form-control" placeholder="Introduce la ciudad">
            <button type="submit" class="btn btn-primary">Buscar</button>
        </div>
    </form>

    <%
        Database database = new Database();
        database.connect();
        UbicacionDAO ubicacionDAO = new UbicacionDAO(database.getConexion());
        String nombre = request.getParameter("nombre");
        String ciudad = request.getParameter("ciudad");
        List<Ubicacion> resultados = null;

        if ((nombre != null && !nombre.isEmpty()) || (ciudad != null && !ciudad.isEmpty())) {
            resultados = ubicacionDAO.buscarPorNombreYCiudad(nombre, ciudad);
        }
        if (resultados != null && !resultados.isEmpty()) {
    %>
    <table class="table table-striped table-bordered">
        <thead class="table-dark">
        <tr>
            <th>Nombre</th>
            <th>Dirección</th>
            <th>Ciudad</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (Ubicacion ubicacion : resultados) {
        %>
        <tr>
            <td><%= ubicacion.getNombre() %></td>
            <td><%= ubicacion.getDireccion() %></td>
            <td><%= ubicacion.getCiudad() %></td>
            <td>
                <div class="btn-group btn-group-sm">
                    <a href="vistaDetalle.jsp?id=<%= ubicacion.getId() %>" class="btn btn-outline-primary">
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
    } else if (nombre != null || ciudad != null) {
    %>
    <div class="alert alert-warning">No se encontraron ubicaciones con esos criterios de búsqueda.</div>
    <%
        }
    %>

    <a href="lista.jsp" class="btn btn-secondary mt-3">Volver a la lista completa</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<jsp:include page="../utiles/footer.jsp" />
