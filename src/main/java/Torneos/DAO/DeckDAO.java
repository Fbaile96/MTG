package Torneos.DAO;

import Torneos.Objetos.Deck;
import lombok.Data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

@Data
public class DeckDAO {
    private static Connection conexion;

    public DeckDAO(Connection conexion){
        this.conexion = conexion;
    }
    private final static String TABLE_NAME = "deck";
    private final static String COLUMN_ID = "id";
    private final static String COLUMN_NOMBRE = "nombre";
    private final static String COLUMN_CONTENIDO = "contenido";
    private final static String COLUMN_CARTAS_TOTALES = "cartas_totales";
    private final static String COLUMN_PORCENTAJE_TIERRAS = "porcentaje_tierras";
    private final static String COLUMN_FECHA_ENVIO = "fecha_envio";
    private final static String COLUMN_VALIDO = "valido";
    private final static String COLUMN_JUGADOR_ID = "jugador_id";


    public void add(Deck deck) throws SQLException {
        String sql = "INSERT INTO " + TABLE_NAME + " (" + COLUMN_NOMBRE + ", " + COLUMN_CONTENIDO + ", " +
                COLUMN_CARTAS_TOTALES + ", " + COLUMN_PORCENTAJE_TIERRAS + ", " + COLUMN_FECHA_ENVIO + ", " +
                COLUMN_VALIDO + ", " + COLUMN_JUGADOR_ID + ") VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setString(1, deck.getNombre());
            stmt.setString(2, deck.getContenido());
            stmt.setInt(3, deck.getCartasTotales());
            stmt.setInt(4, deck.getPorcentajeTierras());
            stmt.setDate(5, new java.sql.Date(deck.getFechaEnvio().getTime()));
            stmt.setBoolean(6, deck.isValido());
            stmt.setInt(7, deck.getPlayerId());

            stmt.executeUpdate();
        }
    }
    public ArrayList<Deck> getAll() throws SQLException {
        ArrayList<Deck> decks = new ArrayList<>();
        String sql = "SELECT " + COLUMN_ID + ", " + COLUMN_NOMBRE + ", " + COLUMN_CONTENIDO + ", " + COLUMN_CARTAS_TOTALES + ", "
                + COLUMN_PORCENTAJE_TIERRAS + ", " + COLUMN_FECHA_ENVIO + ", " + COLUMN_VALIDO + ", " + COLUMN_JUGADOR_ID + " FROM " + TABLE_NAME;

        try (PreparedStatement stmt = conexion.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Deck deck = new Deck();
                deck.setId(rs.getInt(COLUMN_ID));
                deck.setNombre(rs.getString(COLUMN_NOMBRE));
                deck.setContenido(rs.getString(COLUMN_CONTENIDO));
                deck.setCartasTotales(rs.getInt(COLUMN_CARTAS_TOTALES));
                deck.setPorcentajeTierras(rs.getInt(COLUMN_PORCENTAJE_TIERRAS));
                deck.setFechaEnvio(rs.getDate(COLUMN_FECHA_ENVIO));
                deck.setValido(rs.getBoolean(COLUMN_VALIDO));
                deck.setPlayerId(rs.getInt(COLUMN_JUGADOR_ID));
                decks.add(deck);
            }
        }
        return decks;
    }

    public ArrayList<Deck> buscarPorNombreYContenido(String nombre, String contenido) throws SQLException {
        ArrayList<Deck> resultados = new ArrayList<>();

        StringBuilder sql = new StringBuilder("SELECT "
                + COLUMN_ID + ", "
                + COLUMN_NOMBRE + ", "
                + COLUMN_CONTENIDO + ", "
                + COLUMN_CARTAS_TOTALES + ", "
                + COLUMN_PORCENTAJE_TIERRAS + ", "
                + COLUMN_FECHA_ENVIO + ", "
                + COLUMN_VALIDO + ", "
                + COLUMN_JUGADOR_ID
                + " FROM " + TABLE_NAME + " WHERE 1=1");

        if (nombre != null && !nombre.isEmpty()) {
            sql.append(" AND " + COLUMN_NOMBRE + " LIKE ?");
        }
        if (contenido != null && !contenido.isEmpty()) {
            sql.append(" AND " + COLUMN_CONTENIDO + " LIKE ?");
        }

        try (PreparedStatement statement = conexion.prepareStatement(sql.toString())) {
            int index = 1;

            if (nombre != null && !nombre.isEmpty()) {
                statement.setString(index++, "%" + nombre + "%"); // Usar % para la búsqueda parcial
            }
            if (contenido != null && !contenido.isEmpty()) {
                statement.setString(index++, "%" + contenido + "%");
            }

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Deck deck = new Deck();
                    deck.setId(resultSet.getInt(COLUMN_ID));
                    deck.setNombre(resultSet.getString(COLUMN_NOMBRE));
                    deck.setContenido(resultSet.getString(COLUMN_CONTENIDO));
                    deck.setCartasTotales(resultSet.getInt(COLUMN_CARTAS_TOTALES));
                    deck.setPorcentajeTierras(resultSet.getInt(COLUMN_PORCENTAJE_TIERRAS));
                    deck.setFechaEnvio(resultSet.getDate(COLUMN_FECHA_ENVIO));
                    deck.setValido(resultSet.getBoolean(COLUMN_VALIDO));
                    deck.setPlayerId(resultSet.getInt(COLUMN_JUGADOR_ID));

                    resultados.add(deck);
                }
            }
        }

        return resultados;
    }

    public Deck buscarPorId(int id) throws SQLException {
        Deck deck = null;
        String sql = "SELECT d." + COLUMN_ID + ", d." + COLUMN_NOMBRE + ", d." + COLUMN_CONTENIDO + ", " +
                "d." + COLUMN_CARTAS_TOTALES + ", d." + COLUMN_PORCENTAJE_TIERRAS + ", d." + COLUMN_FECHA_ENVIO + ", " +
                "d." + COLUMN_VALIDO + ", d." + COLUMN_JUGADOR_ID + ", p.nickname " +
                "FROM " + TABLE_NAME + " d " +
                "JOIN player p ON d." + COLUMN_JUGADOR_ID + " = p.id " +
                "WHERE d." + COLUMN_ID + " = ?";

        try (PreparedStatement statement = conexion.prepareStatement(sql)) {
            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                deck = new Deck();
                deck.setId(rs.getInt(COLUMN_ID));
                deck.setNombre(rs.getString(COLUMN_NOMBRE));
                deck.setContenido(rs.getString(COLUMN_CONTENIDO));
                deck.setCartasTotales(rs.getInt(COLUMN_CARTAS_TOTALES));
                deck.setPorcentajeTierras(rs.getInt(COLUMN_PORCENTAJE_TIERRAS));
                deck.setFechaEnvio(rs.getDate(COLUMN_FECHA_ENVIO));
                deck.setValido(rs.getBoolean(COLUMN_VALIDO));
                deck.setPlayerId(rs.getInt(COLUMN_JUGADOR_ID));
                deck.setPlayerNickname(rs.getString("nickname"));
            }
        }

        return deck;
    }

    public boolean actualizar(Deck deck) {
        String query = "UPDATE " + TABLE_NAME + " SET " +
                COLUMN_NOMBRE + " = ?, " +
                COLUMN_CONTENIDO + " = ?, " +
                COLUMN_CARTAS_TOTALES + " = ?, " +
                COLUMN_PORCENTAJE_TIERRAS + " = ?, " +
                COLUMN_FECHA_ENVIO + " = ?, " +
                COLUMN_VALIDO + " = ?, " +
                COLUMN_JUGADOR_ID + " = ? " +
                "WHERE " + COLUMN_ID + " = ?";

        try (PreparedStatement stmt = conexion.prepareStatement(query)) {
            stmt.setString(1, deck.getNombre());
            stmt.setString(2, deck.getContenido());
            stmt.setInt(3, deck.getCartasTotales());
            stmt.setInt(4, deck.getPorcentajeTierras());
            stmt.setDate(5, new java.sql.Date(deck.getFechaEnvio().getTime()));
            stmt.setBoolean(6, deck.isValido());
            stmt.setInt(7, deck.getPlayerId());
            stmt.setInt(8, deck.getId());


            int filasAfectadas = stmt.executeUpdate();
            return filasAfectadas > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean eliminar(int id) {
        String query = "DELETE FROM " + TABLE_NAME + " WHERE " + COLUMN_ID + " = ?";

        try (PreparedStatement stmt = conexion.prepareStatement(query)) {
            stmt.setInt(1, id);

            int filasAfectadas = stmt.executeUpdate();
            return filasAfectadas > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public ArrayList<Deck> getAllPaginado(int limite, int offset) throws SQLException {
        ArrayList<Deck> decks = new ArrayList<>();
        String sql = "SELECT " + COLUMN_ID + ", " + COLUMN_NOMBRE + ", " + COLUMN_CONTENIDO + ", "
                + COLUMN_CARTAS_TOTALES + ", " + COLUMN_PORCENTAJE_TIERRAS + ", " + COLUMN_FECHA_ENVIO + ", "
                + COLUMN_VALIDO + ", " + COLUMN_JUGADOR_ID + " FROM " + TABLE_NAME
                + " LIMIT ? OFFSET ?";

        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, limite);
            stmt.setInt(2, offset);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Deck deck = new Deck();
                    deck.setId(rs.getInt(COLUMN_ID));
                    deck.setNombre(rs.getString(COLUMN_NOMBRE));
                    deck.setContenido(rs.getString(COLUMN_CONTENIDO));
                    deck.setCartasTotales(rs.getInt(COLUMN_CARTAS_TOTALES));
                    deck.setPorcentajeTierras(rs.getInt(COLUMN_PORCENTAJE_TIERRAS));
                    deck.setFechaEnvio(rs.getDate(COLUMN_FECHA_ENVIO));
                    deck.setValido(rs.getBoolean(COLUMN_VALIDO));
                    deck.setPlayerId(rs.getInt(COLUMN_JUGADOR_ID));
                    decks.add(deck);
                }
            }
        }
        return decks;
    }


}
