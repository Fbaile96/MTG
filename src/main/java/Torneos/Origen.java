package Torneos;

import Torneos.DAO.TournamentDAO;
import Torneos.Database.Database;
import Torneos.Objetos.Tournament;

import java.sql.*;
import java.util.ArrayList;

public class Origen {
    public static void main(String[] args) {

        Database db = new Database();
        try {
            db.connect();


            TournamentDAO tournamentDAO = new TournamentDAO(db.getConexion());
            ArrayList<Tournament> tournamentArrayList = tournamentDAO.getAll();

            for (Tournament tournament : tournamentArrayList) {
                System.out.println(tournament.getNombre());
                System.out.println(tournament.getFormato());
                System.out.println(tournament.getPremio());
                System.out.println(tournament.getId());
                System.out.println();

            }


            db.disconect();

        } catch (ClassNotFoundException cnfe) {
            System.out.println("No se ha encontrado el driver");
            cnfe.printStackTrace();
        } catch (SQLException sqle) {
            System.out.println("No se ha podido conectar con la base de datos");
            sqle.printStackTrace();
        }
    }
}