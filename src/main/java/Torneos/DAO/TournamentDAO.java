package Torneos.DAO;

import Torneos.Objetos.Tournament;
import lombok.Data;

import java.sql.*;
import java.util.ArrayList;

@Data
public class TournamentDAO {
    private final static String TABLE_NAME = "tournament";
    private final static String COLUMN_ID = "id";


    public  Connection conexion;

    public TournamentDAO(Connection conexion){
        this.conexion = conexion;
    }

    public TournamentDAO() {

    }

    public  ArrayList<Tournament> getAll() throws SQLException {
        String sql = "SELECT * FROM tournament";
        PreparedStatement statement = null;
        ResultSet result = null;
        ArrayList<Tournament> tournamentList =new ArrayList<>();


        statement = conexion.prepareStatement(sql);
        result = statement.executeQuery();

        while (result.next()){
            Tournament tournament = new Tournament();
            tournament.setId(result.getInt("id"));
            tournament.setNombre(result.getString("nombre"));
            tournament.setFormato(result.getString("formato"));
            tournament.setFechaInicio(result.getDate("fecha_inicio"));
            tournament.setFechaFin(result.getDate("fecha_fin"));
            tournament.setPremio(result.getFloat("premio"));
            tournament.setMaxJugadores(result.getInt("max_jugadores"));
            tournament.setInvitacion(result.getBoolean("invitacion"));
            tournamentList.add(tournament);
        }
        statement.close();

        return tournamentList;

    }
    public boolean add(Tournament tournament) throws SQLException{
        String sql = "INSERT INTO tournament (nombre, formato) VALUES (?. ?)";
        PreparedStatement statement = null;

        statement = conexion.prepareStatement(sql);
        statement.setString(1, tournament.getNombre());
        statement.setString(2, tournament.getFormato());
        statement.executeUpdate();
        int affectedRows = statement.executeUpdate();

        return affectedRows !=0;
    }

    public void modify(){

    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM tournament WHERE id = ?";

        PreparedStatement statement = conexion.prepareStatement(sql);
        statement.setInt(1, id);
        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;
    }

    public void crear(Tournament tournament) throws SQLException{
         {
            String sql = "INSERT INTO tournament (nombre, formato, fecha_inicio, fecha_fin, premio, max_jugadores, invitacion, ubicacion_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
             PreparedStatement stmt = conexion.prepareStatement(sql);
            stmt.setString(1, tournament.getNombre());
            stmt.setString(2, tournament.getFormato());
            stmt.setDate(3, (Date) tournament.getFechaInicio());
            stmt.setDate(4, (Date) tournament.getFechaFin());
            stmt.setDouble(5, tournament.getPremio());
            stmt.setInt(6, tournament.getMaxJugadores());
            stmt.setBoolean(7, tournament.isInvitacion());
            stmt.setInt(8, tournament.getUbicacion_id());
            stmt.executeUpdate();
        }
    }

    public ArrayList<Tournament> buscarPorNombreYFormato(String nombre, String formato) throws SQLException {
        ArrayList<Tournament> lista = new ArrayList<>();
        String sql = "SELECT t.*, u.nombre AS nombre_ubicacion " +
                "FROM tournament t " +
                "JOIN ubicaciones u ON t.ubicacion_id = u.id " +
                "WHERE 1=1";

        if (nombre != null && !nombre.isEmpty()) {
            sql += " AND LOWER(t.nombre) LIKE LOWER(?)";
        }
        if (formato != null && !formato.isEmpty()) {
            sql += " AND LOWER(t.formato) LIKE LOWER(?)";
        }

        PreparedStatement stmt = conexion.prepareStatement(sql);

        int index = 1;
        if (nombre != null && !nombre.isEmpty()) {
            stmt.setString(index++, "%" + nombre + "%");
        }
        if (formato != null && !formato.isEmpty()) {
            stmt.setString(index++, "%" + formato + "%");
        }

        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            Tournament torneo = new Tournament(
                    rs.getString("nombre"),
                    rs.getString("formato"),
                    rs.getDate("fecha_inicio"),
                    rs.getDate("fecha_fin"),
                    rs.getDouble("premio"),
                    rs.getInt("max_jugadores"),
                    rs.getBoolean("invitacion")
            );
            torneo.setId(rs.getInt("id"));
            torneo.setUbicacion_id(rs.getInt("ubicacion_id"));
            torneo.setUbicacionNombre(rs.getString("nombre_ubicacion"));
            lista.add(torneo);
        }
        return lista;
    }

    public Tournament buscarPorId(int id) {
        Tournament torneo = null;
        String sql = "SELECT * FROM " + TABLE_NAME + " WHERE "+ COLUMN_ID + " = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    torneo = new Tournament(
                            rs.getInt(COLUMN_ID),
                            rs.getString("nombre"),
                            rs.getString("formato"),
                            rs.getDate("fecha_inicio"),
                            rs.getDate("fecha_fin"),
                            rs.getDouble("premio"),
                            rs.getInt("max_jugadores"),
                            rs.getBoolean("invitacion"),
                            rs.getInt("ubicacion_id")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return torneo;
    }
    public void actualizar(Tournament torneo) {
        String sql = "UPDATE " + TABLE_NAME +
                " SET nombre = ?, formato = ?, fecha_inicio = ?, fecha_fin = ?, premio = ?, max_jugadores = ?, invitacion = ?, ubicacion_id = ? WHERE id = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setString(1, torneo.getNombre());
            stmt.setString(2, torneo.getFormato());
            stmt.setDate(3, (Date) torneo.getFechaInicio());
            stmt.setDate(4, (Date) torneo.getFechaFin());
            stmt.setDouble(5, torneo.getPremio());
            stmt.setInt(6, torneo.getMaxJugadores());
            stmt.setBoolean(7, torneo.isInvitacion());
            stmt.setInt(8, torneo.getUbicacion_id());
            stmt.setInt(9, torneo.getId());
            int filasActualizadas = stmt.executeUpdate();
            if (filasActualizadas == 0) {
                System.out.println("No se actualizó ningún torneo. ¿El ID existe?");
            } else {
                System.out.println("Torneo actualizado correctamente.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public ArrayList<Tournament> listAll(int limit, int offset) throws SQLException {
        String sql = "SELECT * FROM tournament LIMIT ? OFFSET ?";
        PreparedStatement statement = conexion.prepareStatement(sql);

        statement.setInt(1, limit);
        statement.setInt(2, offset);

        ResultSet result = statement.executeQuery();
        ArrayList<Tournament> tournamentList = new ArrayList<>();

        while (result.next()) {
            Tournament tournament = new Tournament();
            tournament.setId(result.getInt("id"));
            tournament.setNombre(result.getString("nombre"));
            tournament.setFormato(result.getString("formato"));
            tournament.setFechaInicio(result.getDate("fecha_inicio"));
            tournament.setFechaFin(result.getDate("fecha_fin"));
            tournament.setPremio(result.getFloat("premio"));
            tournament.setMaxJugadores(result.getInt("max_jugadores"));
            tournament.setInvitacion(result.getBoolean("invitacion"));
            tournamentList.add(tournament);
        }
        statement.close();

        return tournamentList;

    }





}
