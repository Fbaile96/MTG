package Torneos.Objetos;

import lombok.Data;

import java.util.Date;
@Data
public class Ubicacion {
    private int id;
    private String nombre;
    private String ciudad;
    private String direccion;
    private int codigoPostal;
    private double precioAlquiler;
    private Date fechaRegistro;
    private boolean esTienda;

    public Ubicacion() {}

    public Ubicacion(String nombre, String ciudad, String direccion, int codigoPostal, double precioAlquiler, Date fechaRegistro, boolean esTienda) {
        this.nombre = nombre;
        this.ciudad = ciudad;
        this.direccion = direccion;
        this.codigoPostal = codigoPostal;
        this.precioAlquiler = precioAlquiler;
        this.fechaRegistro = fechaRegistro;
        this.esTienda = esTienda;
    }
    public Ubicacion(int id, String nombre, String ciudad, String direccion, int codigoPostal, double precioAlquiler, boolean esTienda) {
        this.id = id;
        this.nombre = nombre;
        this.ciudad = ciudad;
        this.direccion = direccion;
        this.codigoPostal = codigoPostal;
        this.precioAlquiler = precioAlquiler;
        this.esTienda = esTienda;
    }

}
