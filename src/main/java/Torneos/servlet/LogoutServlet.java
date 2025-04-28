package Torneos.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Invalidar la sesión actual para cerrar la sesión del usuario
        HttpSession session = request.getSession(false); // Usar false para no crear una nueva sesión si no existe
        if (session != null) {
            session.invalidate(); // Invalidar la sesión
        }

        // Redirigir al usuario a la página de login o a la página de inicio
        response.sendRedirect("login.jsp"); // O redirige a la página que prefieras
    }
}
