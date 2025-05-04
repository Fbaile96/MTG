<%@ page import="java.sql.*, Torneos.DAO.UbicacionDAO, Torneos.Objetos.Ubicacion, Torneos.Database.Database" %>
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
            UbicacionDAO ubicacionDao = new UbicacionDAO(database.getConexion());

            boolean eliminado = ubicacionDao.eliminar(id);

            if (eliminado) {
                mensaje = "Ubicación eliminada correctamente.";
                tipoMensaje = "success";
            } else {
                mensaje = "No se pudo eliminar la ubicación (puede que no exista).";
                tipoMensaje = "warning";
            }

            database.disconect();
        } catch (Exception e) {
            mensaje = "Error al eliminar la ubicación: " + e.getMessage();
            tipoMensaje = "danger";
            e.printStackTrace();
        }
    } else {
        mensaje = "ID de ubicación no proporcionado.";
        tipoMensaje = "danger";
    }

    session.setAttribute("mensaje", mensaje);
    session.setAttribute("tipoMensaje", tipoMensaje);
    response.sendRedirect("lista.jsp");
%>
