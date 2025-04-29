package Torneos.servlet;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import Torneos.Database.Database;
import Torneos.DAO.PlayerDAO;
import Torneos.Objetos.Player;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener parámetros de la solicitud
        String nickname = request.getParameter("nickname");
        String password = request.getParameter("password");
        String mensaje = "";

        // Verificar que los parámetros no sean nulos o vacíos
        if (nickname == null || nickname.isEmpty() || password == null || password.isEmpty()) {
            mensaje = "Por favor, ingresa tanto el nombre de usuario como la contraseña.";
            request.setAttribute("mensaje", mensaje);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Conectar a la base de datos
        Database database = new Database();
        try {
            database.connect();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            mensaje = "Error al conectar con la base de datos. Por favor, intenta más tarde.";
            request.setAttribute("mensaje", mensaje);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Crear instancia de PlayerDAO y buscar al jugador por nickname
        PlayerDAO playerDAO = new PlayerDAO(database.getConexion());
        Player player = null;
        try {
            player = playerDAO.buscarPorNickname(nickname);
        } catch (SQLException e) {
            e.printStackTrace();
            mensaje = "Error al realizar la consulta. Por favor, intenta más tarde.";
            request.setAttribute("mensaje", mensaje);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Verificar si el jugador existe y si la contraseña es correcta
        if (player != null && player.verificarPassword(password)) {
            // Inicio de sesión exitoso
            HttpSession session = request.getSession();
            session.setAttribute("player", player);
            session.setAttribute("isAdmin", player.isAdministrador()); // Guardamos el estado de administrador en la sesión
            response.sendRedirect("dashboard.jsp"); // Redirigir al panel de control
        } else {
            // Inicio de sesión fallido
            mensaje = "Nombre de usuario o contraseña incorrectos.";
            request.setAttribute("mensaje", mensaje);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }

        // Desconectar de la base de datos
        try {
            database.disconect();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
