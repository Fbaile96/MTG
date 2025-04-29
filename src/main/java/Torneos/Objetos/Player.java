package Torneos.Objetos;

import lombok.Data;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

import java.util.Date;
@Data
public class Player {

    private int id;
    private String nombre;
    private String email;
    private String nickname;
    private int puntosRanking;
    private Date fechaRegistro;
    private boolean activo;
    private String password;
    private boolean administrador;

    public Player() {

    }

    public void setFechaRegistro(java.sql.Date fechaRegistro) {
    }
    public Player(String nombre, String correoElectronico, String nickname, int puntosRanking,
                  Date fechaRegistro, boolean activo, String password, boolean administrador) {
        this.nombre = nombre;
        this.email = correoElectronico;
        this.nickname = nickname;
        this.puntosRanking = puntosRanking;
        this.fechaRegistro = fechaRegistro;
        this.activo = activo;
        this.password = password;
        this.administrador = administrador;
    }
    public Player(int id,String nombre, String correoElectronico, String nickname, int puntosRanking,
                  Date fechaRegistro, boolean activo, String password, boolean administrador) {
        this.id = id;
        this.nombre = nombre;
        this.email = correoElectronico;
        this.nickname = nickname;
        this.puntosRanking = puntosRanking;
        this.fechaRegistro = fechaRegistro;
        this.activo = activo;
        this.password = password;
        this.administrador = administrador;
    }
    public Player(int id,String nombre, String correoElectronico, String nickname, int puntosRanking,
                   boolean activo, String password, boolean administrador) {
        this.id = id;
        this.nombre = nombre;
        this.email = correoElectronico;
        this.nickname = nickname;
        this.puntosRanking = puntosRanking;
        this.activo = activo;
        this.password = password;
        this.administrador = administrador;
    }

    public boolean verificarPassword(String passwordInput) {
        return this.password.equals(passwordInput);
    }



}
