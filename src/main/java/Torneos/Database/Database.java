package Torneos.Database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {

    private Connection conexion;

    public void connect()throws ClassNotFoundException, SQLException {
        try {
        Class.forName("org.mariadb.jdbc.Driver");
        conexion = DriverManager.getConnection(
                "jdbc:mariadb://localhost:3306/mtg_torneos",
                "fran", "fran");
        } catch (SQLException | ClassNotFoundException e) {
            throw new SQLException("Error al conectar con la base de datos: " + e.getMessage(), e);
        }
    }

    public void disconect() throws SQLException {
        conexion.close();
    }
    public Connection getConexion(){

        return conexion;
    }
}
