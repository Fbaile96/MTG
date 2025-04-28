<%@ page import="java.sql.*, Torneos.DAO.PlayerDAO, Torneos.Objetos.Player, Torneos.Database.Database" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String mensaje = "";
  String tipoMensaje = "";

  String idParam = request.getParameter("id");
  if (idParam != null && !idParam.isEmpty()) {
    try {
      int id = Integer.parseInt(idParam);

      Database database = new Database();
      database.connect();
      PlayerDAO playerDao = new PlayerDAO(database.getConexion());

      boolean eliminado = playerDao.delete(id);

      if (eliminado) {
        mensaje = "Jugador eliminado correctamente.";
        tipoMensaje = "success";
      } else {
        mensaje = "No se pudo eliminar el jugador (puede que no exista).";
        tipoMensaje = "warning";
      }

      database.disconect();
    } catch (Exception e) {
      mensaje = "Error al eliminar el jugador: " + e.getMessage();
      tipoMensaje = "danger";
      e.printStackTrace();
    }
  } else {
    mensaje = "ID de jugador no proporcionado.";
    tipoMensaje = "danger";
  }

  // Guardar mensaje en sesión y redirigir
  session.setAttribute("mensaje", mensaje);
  session.setAttribute("tipoMensaje", tipoMensaje);
  response.sendRedirect("lista.jsp"); // Redirige a la lista de jugadores
%>
