package Torneos.Objetos;

import lombok.Data;

import java.util.Date;

@Data
public class Partida {

    private int id;
    private String resultado;
    private int mesa;
    private int duracion_minutos;
    private int diferencia_puntos;
    private Date fechaPartida;
    private boolean reportadoPorJuez;

}
