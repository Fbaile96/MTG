<%@ page import="java.sql.*, Torneos.DAO.TournamentDAO, Torneos.Database.Database" %>
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
      TournamentDAO torneoDAO = new TournamentDAO(database.getConexion());

      boolean eliminado = torneoDAO.delete(id);

      if (eliminado) {
        mensaje = "Torneo eliminado correctamente.";
        tipoMensaje = "success";
      } else {
        mensaje = "No se pudo eliminar el torneo (puede que no exista).";
        tipoMensaje = "warning";
      }

      database.disconect();
    } catch (Exception e) {
      mensaje = "Error al eliminar el torneo: " + e.getMessage();
      tipoMensaje = "danger";
      e.printStackTrace();
    }
  } else {
    mensaje = "ID de torneo no proporcionado.";
    tipoMensaje = "danger";
  }

  // Guardar mensaje en sesión y redirigir
  session.setAttribute("mensaje", mensaje);
  session.setAttribute("tipoMensaje", tipoMensaje);
  response.sendRedirect("lista.jsp");
%>
