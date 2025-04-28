<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="Torneos.Objetos.Player" %>
<%
    // Obtener la sesión y el jugador
    HttpSession session = request.getSession(false); // Usar 'false' para no crear una nueva sesión si no existe
    Player player = null;

    // Verificar si la sesión existe y tiene un objeto 'player'
    if (session != null) {
        player = (Player) session.getAttribute("player");
    }

    // Redirigir al login si no existe una sesión de jugador válida
    if (player == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel de Control</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="text-center mb-4">Bienvenido, <%= player.getNickname() %></h2>
    <p class="lead">¡Has iniciado sesión correctamente!</p>

    <!-- Botón de cerrar sesión -->
    <a href="LogoutServlet" class="btn btn-danger">Cerrar sesión</a>
</div>

</body>
</html>
