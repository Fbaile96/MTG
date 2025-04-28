package Torneos.Objetos;

import lombok.Data;

import java.util.Date;
@Data
public class Deck {

    private int id;
    private String nombre;
    private String contenido;
    private int cartasTotales;
    private int porcentajeTierras;
    private Date fechaEnvio;
    private boolean valido;

    public Deck(int id, String nombre, String contenido, int cartasTotales, int porcentajeTierras , Date fechaEnvio,
                boolean valido) {
        this.id = id;
        this.nombre = nombre;
        this.contenido = contenido;
        this.cartasTotales = cartasTotales;
        this.porcentajeTierras = porcentajeTierras;
        this.fechaEnvio = fechaEnvio;
        this.valido = valido;
    }
    public Deck(String nombre, String contenido, int cartasTotales, int porcentajeTierras , Date fechaEnvio,
                boolean valido) {
        this.nombre = nombre;
        this.contenido = contenido;
        this.cartasTotales = cartasTotales;
        this.porcentajeTierras = porcentajeTierras;
        this.fechaEnvio = fechaEnvio;
        this.valido = valido;
    }

    public Deck() {

    }
}
