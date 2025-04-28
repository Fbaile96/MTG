package Torneos.Objetos;

import lombok.*;
import java.util.Date;

@Data


public class Tournament {
    private int id;
    private String nombre;
    private String formato;
    private Date fechaInicio;
    private Date fechaFin;
    private float premio;
    private int maxJugadores;
    private boolean invitacion;

        public Tournament(String nombre, String formato, Date fechaInicio, Date fechaFin,
                          double premio, int maxJugadores, boolean invitacion) {
            this.nombre = nombre;
            this.formato = formato;
            this.fechaInicio = fechaInicio;
            this.fechaFin = fechaFin;
            this.premio = (float) premio;
            this.maxJugadores = maxJugadores;
            this.invitacion = invitacion;
        }

    public Tournament() {

    }

    public Tournament(int id, String nombre, String formato, Date fechaInicio, Date fechaFin,
                      double premio, int maxJugadores, boolean invitacion) {
        this.id = id;
        this.nombre = nombre;
        this.formato = formato;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
        this.premio = (float) premio;
        this.maxJugadores = maxJugadores;
        this.invitacion = invitacion;
    }


}