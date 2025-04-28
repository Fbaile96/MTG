<%@ page import="java.sql.*, Torneos.DAO.DeckDAO, Torneos.Objetos.Deck, Torneos.Database.Database" %>
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
            DeckDAO deckDao = new DeckDAO(database.getConexion());

            boolean eliminado = deckDao.eliminar(id);

            if (eliminado) {
                mensaje = "Deck eliminado correctamente.";
                tipoMensaje = "success";
            } else {
                mensaje = "No se pudo eliminar el deck (puede que no exista).";
                tipoMensaje = "warning";
            }

            database.disconect();
        } catch (Exception e) {
            mensaje = "Error al eliminar el deck: " + e.getMessage();
            tipoMensaje = "danger";
            e.printStackTrace();
        }
    } else {
        mensaje = "ID de deck no proporcionado.";
        tipoMensaje = "danger";
    }

    session.setAttribute("mensaje", mensaje);
    session.setAttribute("tipoMensaje", tipoMensaje);
    response.sendRedirect("lista.jsp");
%>
