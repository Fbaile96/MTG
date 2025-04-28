<%@ page import="Torneos.Objetos.Player" %>
<%@ page import="Torneos.Database.Database" %>
<%@ page import="Torneos.DAO.PlayerDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String mensaje = "";
  Player Player = null;

  Database database = new Database();
  database.connect();
  PlayerDAO PlayerDao = new PlayerDAO(database.getConexion());

  if ("POST".equalsIgnoreCase(request.getMethod())) {
    int id = Integer.parseInt(request.getParameter("id"));
    String nombre = request.getParameter("nombre");
    String email = request.getParameter("email");
    String nickname = request.getParameter("nickname");
    int puntosRanking = Integer.parseInt(request.getParameter("puntosRanking"));
    boolean activo = request.getParameter("activo") != null;
    String password = request.getParameter("password");
    boolean administrador = request.getParameter("administrador") != null;



    Player = new Player(id, nombre, email, nickname, puntosRanking, activo, password, administrador);
    PlayerDao.actualizar(Player);
    mensaje = "Jugador actualizado correctamente.";

  } else {
    int id = Integer.parseInt(request.getParameter("id"));
    Player = PlayerDao.buscarPorId(id);
  }

  database.disconect();
%>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Editar Jugador</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
  <h2 class="text-center mb-4">Editar Jugador</h2>

  <% if (!mensaje.isEmpty()) { %>
  <div class="alert alert-success"><%= mensaje %></div>
  <% } %>

  <form method="post" class="shadow p-4 bg-white rounded">
    <input type="hidden" name="id" value="<%= Player.getId() %>">

    <div class="mb-3">
      <label class="form-label">Nombre</label>
      <input type="text" class="form-control" name="nombre" value="<%= Player.getNombre() %>" required>
    </div>

    <div class="mb-3">
      <label class="form-label">Email</label>
      <input type="email" class="form-control" name="email" value="<%= Player.getEmail() %>" required>
    </div>

    <div class="mb-3">
      <label class="form-label">Nickname</label>
      <input type="text" class="form-control" name="nickname" value="<%= Player.getNickname() %>" required>
    </div>

    <div class="mb-3">
      <label class="form-label">Puntos Ranking</label>
      <input type="number" class="form-control" name="puntosRanking" value="<%= Player.getPuntosRanking() %>" required>
    </div>

    <div class="form-check mb-3">
      <input class="form-check-input" type="checkbox" name="activo" <%= Player.isActivo() ? "checked" : "" %>>
      <label class="form-check-label">Activo</label>
    </div>

    <div class="mb-3">
      <label class="form-label">Contraseña</label>
      <input type="password" class="form-control" name="password" value="<%= Player.getPassword() %>" required>
    </div>

    <div class="form-check mb-3">
      <input class="form-check-input" type="checkbox" name="administrador" <%= Player.isAdministrador() ? "checked" : "" %>>
      <label class="form-check-label">Administrador</label>
    </div>

    <button type="submit" class="btn btn-primary">Guardar Cambios</button>
    <a href="lista.jsp" class="btn btn-secondary">Volver</a>
  </form>
</div>
</body>
</html>
