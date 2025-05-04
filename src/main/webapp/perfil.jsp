<%@ page import="Torneos.DAO.PlayerDAO" %>
<%@ page import="Torneos.Database.Database" %>
<%@ page import="Torneos.Objetos.Player" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>

<%
    // Verificar si el usuario está logueado
    Player jugador = (Player) session.getAttribute("player");
    if (jugador == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String mensaje = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // Obtener los parámetros del formulario
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String nickname = request.getParameter("nickname");
        String password = request.getParameter("password");

        // Actualizar el jugador con los nuevos valores
        jugador.setNombre(nombre);
        jugador.setEmail(email);
        jugador.setNickname(nickname);
        jugador.setPassword(password);

        try {
            // Conectar a la base de datos y actualizar la información
            Database db = new Database();
            db.connect();
            PlayerDAO dao = new PlayerDAO(db.getConexion());
            dao.update(jugador);  // Método para actualizar en la base de datos
            db.disconect();

            // Actualizar la sesión con los nuevos datos
            session.setAttribute("player", jugador);
            mensaje = "Perfil actualizado correctamente.";
        } catch (SQLException e) {
            mensaje = "Error al actualizar el perfil: " + e.getMessage();
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfil de Usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<header>
    <nav class="navbar navbar-dark bg-dark mb-4">
        <div class="container-fluid">
            <a class="navbar-brand" href="main.jsp">Torneos MTG</a>
            <a href="login.jsp" class="btn btn-outline-light">Ingresar</a>
        </div>
    </nav>
</header>

<div class="container mt-5">
    <h2 class="text-center mb-4">Perfil de <%= jugador.getNickname() %></h2>

    <% if (mensaje != null && !mensaje.isEmpty()) { %>
    <div class="alert alert-success">
        <%= mensaje %>
    </div>
    <% } %>

    <!-- Formulario para editar perfil -->
    <form method="post" class="shadow p-4 bg-white rounded">
        <div class="mb-3">
            <label for="nombre" class="form-label">Nombre</label>
            <input type="text" id="nombre" name="nombre" class="form-control" value="<%= jugador.getNombre() %>" required>
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">Correo electrónico</label>
            <input type="email" id="email" name="email" class="form-control" value="<%= jugador.getEmail() %>" required>
        </div>

        <div class="mb-3">
            <label for="nickname" class="form-label">Nickname</label>
            <input type="text" id="nickname" name="nickname" class="form-control" value="<%= jugador.getNickname() %>" required>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Contraseña</label>
            <input type="password" id="password" name="password" class="form-control" value="<%= jugador.getPassword() %>" required>
        </div>

        <button type="submit" class="btn btn-primary">Actualizar Perfil</button>
    </form>
</div>

</body>
</html>
