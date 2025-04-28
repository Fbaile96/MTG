package Torneos.DAO;

import Torneos.Objetos.Player;
import lombok.Data;

import java.sql.*;
import java.util.ArrayList;

@Data
public class PlayerDAO {

    private static Connection conexion;

    public PlayerDAO(Connection conexion){
        this.conexion = conexion;
    }

    public void add (Player player) throws SQLException{
        String sql = "INSERT INTO player (nombre, email, nickname, " +
                "puntos_ranking, fecha_registro, activo, password, administrador) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement statement = null;
        statement = conexion.prepareStatement(sql);

            statement.setString(1, player.getNombre());
            statement.setString(2, player.getEmail());
            statement.setString(3, player.getNickname());
            statement.setInt(4, player.getPuntosRanking());
            statement.setDate(5, (Date) player.getFechaRegistro());
            statement.setBoolean(6, player.isActivo());
            statement.setString(7, player.getPassword());
            statement.setBoolean(8, player.isAdministrador());

            statement.executeUpdate();


    }
    public ArrayList<Player> getAll() throws SQLException {
        String sql = "SELECT * FROM player";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        ArrayList<Player> jugadorList = new ArrayList<>();

        try {
            stmt = conexion.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Player jugador = new Player();
                jugador.setId(rs.getInt("id"));
                jugador.setNombre(rs.getString("nombre"));
                jugador.setEmail(rs.getString("email"));
                jugador.setNickname(rs.getString("nickname"));
                jugador.setPuntosRanking(rs.getInt("puntos_ranking"));
                jugador.setFechaRegistro(rs.getDate("fecha_registro"));
                jugador.setActivo(rs.getBoolean("activo"));
                jugador.setPassword(rs.getString("password"));
                jugador.setAdministrador(rs.getBoolean("administrador"));
                jugadorList.add(jugador);
            }
        } catch (SQLException e) {
            throw new SQLException("Error al obtener los jugadores: " + e.getMessage(), e);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
        }

        return jugadorList;
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM player WHERE id = ?";
        PreparedStatement stmt = null;

        try {
            stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, id);

            int filasAfectadas = stmt.executeUpdate();
            return filasAfectadas > 0;
        } catch (SQLException e) {
            throw new SQLException("Error al eliminar el jugador: " + e.getMessage(), e);
        } finally {
            if (stmt != null) {
                stmt.close();
            }
        }
    }
    public static void actualizar(Player jugador) {
        String sql = "UPDATE player SET nombre = ?, email = ?, nickname = ?, puntos_ranking = ?, activo = ?, password = ?, administrador = ? WHERE id = ?";

        try (PreparedStatement statement = conexion.prepareStatement(sql)) {
            statement.setString(1, jugador.getNombre());
            statement.setString(2, jugador.getEmail());
            statement.setString(3, jugador.getNickname());
            statement.setInt(4, jugador.getPuntosRanking());
            statement.setBoolean(5, jugador.isActivo());
            statement.setString(6, jugador.getPassword());
            statement.setBoolean(7, jugador.isAdministrador());
            statement.setInt(8, jugador.getId());
            statement.executeUpdate();
            int filasActualizadas = statement.executeUpdate();
            if (filasActualizadas == 0) {
                System.out.println("No se actualizó ningún torneo. ¿El ID existe?");
            } else {
                System.out.println("Torneo actualizado correctamente.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static Player buscarPorId(int id) {
        String sql = "SELECT * FROM player WHERE id = ?";
        Player jugador = null;

        try (PreparedStatement statement = conexion.prepareStatement(sql)) {
            statement.setInt(1, id);

            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                jugador = new Player(
                        resultSet.getInt("id"),
                        resultSet.getString("nombre"),
                        resultSet.getString("email"),
                        resultSet.getString("nickname"),
                        resultSet.getInt("puntos_ranking"),
                        resultSet.getDate("fecha_registro"),
                        resultSet.getBoolean("activo"),
                        resultSet.getString("password"),
                        resultSet.getBoolean("administrador")
                );
                System.out.println("Jugador encontrado: " + jugador.getNombre()); // Imprime ahora, cuando sí existe
            } else {
                System.out.println("No se encontró ningún jugador con id: " + id);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return jugador;
    }
    public ArrayList<Player> buscarPorNombreYNickname(String nombre, String nickname) throws SQLException {
        ArrayList<Player> jugadores = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM player WHERE ");

        // Condiciones para nombre y nickname
        if (nombre != null && !nombre.isEmpty()) {
            sql.append("nombre LIKE ? ");
        }
        if (nickname != null && !nickname.isEmpty()) {
            if (nombre != null && !nombre.isEmpty()) {
                sql.append("OR ");
            }
            sql.append("nickname LIKE ? ");
        }

        try (PreparedStatement statement = conexion.prepareStatement(sql.toString())) {
            int index = 1;
            if (nombre != null && !nombre.isEmpty()) {
                statement.setString(index++, "%" + nombre + "%");
            }
            if (nickname != null && !nickname.isEmpty()) {
                statement.setString(index, "%" + nickname + "%");
            }

            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Player jugador = new Player(
                        resultSet.getInt("id"),
                        resultSet.getString("nombre"),
                        resultSet.getString("email"),
                        resultSet.getString("nickname"),
                        resultSet.getInt("puntos_ranking"),
                        resultSet.getDate("fecha_registro"),
                        resultSet.getBoolean("activo"),
                        resultSet.getString("password"),
                        resultSet.getBoolean("administrador")
                );
                jugadores.add(jugador);
            }
        }
        return jugadores;
    }

    public Player buscarPorNickname(String nickname) throws SQLException {
        String query = "SELECT * FROM Player WHERE nickname = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(query)) {
            stmt.setString(1, nickname);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Player player = new Player();
                player.setId(rs.getInt("id"));
                player.setNombre(rs.getString("nombre"));
                player.setEmail(rs.getString("email"));
                player.setNickname(rs.getString("nickname"));
                player.setPassword(rs.getString("password"));
                player.setPuntosRanking(rs.getInt("puntos_ranking"));
                player.setActivo(rs.getBoolean("activo"));
                player.setAdministrador(rs.getBoolean("administrador"));
                return player;
            }
        }
        return null;
    }

}