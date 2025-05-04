package Torneos.DAO;
import Torneos.Objetos.Ubicacion;

import java.sql.*;
import java.util.ArrayList;

public class UbicacionDAO {


        private final Connection conexion;

        public UbicacionDAO(Connection conexion) {
            this.conexion = conexion;
        }

    public boolean add(Ubicacion ubicacion) {
        String sql = "INSERT INTO ubicaciones (nombre, ciudad, direccion, codigo_postal, precio_alquiler, fecha_registro, es_tienda) " +
                "VALUES (?, ?, ?, ?, ?, CURRENT_TIMESTAMP, ?)";

        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setString(1, ubicacion.getNombre());
            stmt.setString(2, ubicacion.getCiudad());
            stmt.setString(3, ubicacion.getDireccion());
            stmt.setInt(4, ubicacion.getCodigoPostal());
            stmt.setDouble(5, ubicacion.getPrecioAlquiler());
            stmt.setBoolean(6, ubicacion.isEsTienda());

            int filasInsertadas = stmt.executeUpdate();
            return filasInsertadas > 0;
        } catch (SQLException e) {
            System.err.println("Error al insertar ubicación: " + e.getMessage());
            return false;
        }
    }


    public ArrayList<Ubicacion> getAll() {
            ArrayList<Ubicacion> lista = new ArrayList<>();
            String sql = "SELECT * FROM ubicaciones";

            try (PreparedStatement stmt = conexion.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {

                while (rs.next()) {
                    Ubicacion u = new Ubicacion();
                    u.setId(rs.getInt("id"));
                    u.setNombre(rs.getString("nombre"));
                    u.setCiudad(rs.getString("ciudad"));
                    u.setDireccion(rs.getString("direccion"));
                    u.setCodigoPostal(rs.getInt("codigo_postal"));
                    u.setPrecioAlquiler(rs.getDouble("precio_alquiler"));
                    u.setFechaRegistro(rs.getDate("fecha_registro"));
                    u.setEsTienda(rs.getBoolean("es_tienda"));

                    lista.add(u);
                }

            } catch (SQLException e) {
                System.err.println("Error al obtener ubicaciones: " + e.getMessage());
            }

            return lista;
        }
    public ArrayList<Ubicacion> getAllPaginado(int limite, int offset) {
        ArrayList<Ubicacion> lista = new ArrayList<>();
        String sql = "SELECT * FROM ubicaciones ORDER BY id LIMIT ? OFFSET ?";

        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, limite);
            stmt.setInt(2, offset);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Ubicacion u = new Ubicacion();
                    u.setId(rs.getInt("id"));
                    u.setNombre(rs.getString("nombre"));
                    u.setCiudad(rs.getString("ciudad"));
                    u.setDireccion(rs.getString("direccion"));
                    u.setCodigoPostal(rs.getInt("codigo_postal"));
                    u.setPrecioAlquiler(rs.getDouble("precio_alquiler"));
                    u.setFechaRegistro(rs.getDate("fecha_registro"));
                    u.setEsTienda(rs.getBoolean("es_tienda"));

                    lista.add(u);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener ubicaciones paginadas: " + e.getMessage());
        }

        return lista;
    }


    public Ubicacion getById(int id) {
        String sql = "SELECT * FROM ubicaciones WHERE id = ?";
        Ubicacion ubicacion = null;

        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    ubicacion = new Ubicacion();
                    ubicacion.setId(rs.getInt("id"));
                    ubicacion.setNombre(rs.getString("nombre"));
                    ubicacion.setCiudad(rs.getString("ciudad"));
                    ubicacion.setDireccion(rs.getString("direccion"));
                    ubicacion.setCodigoPostal(rs.getInt("codigo_postal"));
                    ubicacion.setPrecioAlquiler(rs.getDouble("precio_alquiler"));
                    ubicacion.setFechaRegistro(rs.getDate("fecha_registro"));
                    ubicacion.setEsTienda(rs.getBoolean("es_tienda"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener ubicación por ID: " + e.getMessage());
        }

        return ubicacion;
    }

    public void actualizar(Ubicacion ubicacion) {
        String sql = "UPDATE ubicaciones SET " +
                "nombre = ?, direccion = ?, ciudad = ?, codigo_postal = ?, " +
                "precio_alquiler = ?, es_tienda = ? " +
                "WHERE id = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setString(1, ubicacion.getNombre());
            stmt.setString(2, ubicacion.getDireccion());
            stmt.setString(3, ubicacion.getCiudad());
            stmt.setInt(4, ubicacion.getCodigoPostal());
            stmt.setDouble(5, ubicacion.getPrecioAlquiler());
            stmt.setBoolean(6, ubicacion.isEsTienda());
            stmt.setInt(7, ubicacion.getId());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error al actualizar la ubicación", e);
        }
    }
    public boolean eliminar(int id) {
        String sql = "DELETE FROM ubicaciones WHERE id = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, id);
            int filasEliminadas = stmt.executeUpdate();
            return filasEliminadas > 0;
        } catch (SQLException e) {
            System.err.println("Error al eliminar ubicación: " + e.getMessage());
            return false;
        }
    }
    public ArrayList<Ubicacion> buscarPorNombreYCiudad(String nombre, String ciudad) {
        ArrayList<Ubicacion> ubicaciones = new ArrayList<>();
        String sql = "SELECT * FROM ubicaciones WHERE nombre LIKE ? AND ciudad LIKE ?";

        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            // Utilizamos los comodines "%" para realizar la búsqueda parcial
            stmt.setString(1, "%" + nombre + "%");
            stmt.setString(2, "%" + ciudad + "%");

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Ubicacion ubicacion = new Ubicacion();
                    ubicacion.setId(rs.getInt("id"));
                    ubicacion.setNombre(rs.getString("nombre"));
                    ubicacion.setDireccion(rs.getString("direccion"));
                    ubicacion.setCiudad(rs.getString("ciudad"));
                    ubicacion.setCodigoPostal(rs.getInt("codigo_postal"));
                    ubicacion.setPrecioAlquiler(rs.getDouble("precio_alquiler"));
                    ubicacion.setFechaRegistro(rs.getDate("fecha_registro"));
                    ubicacion.setEsTienda(rs.getBoolean("es_tienda"));

                    ubicaciones.add(ubicacion);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al buscar ubicaciones por nombre y ciudad: " + e.getMessage());
        }

        return ubicaciones;
    }



}