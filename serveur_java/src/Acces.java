import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;

public class Acces {

    private final Connection connection;

    private Personne personne;

    private final String id_zone;
    private String niveau_requis;


    public Acces(String id_zone, Connection connection) {
        this.connection = connection;
        this.id_zone = id_zone;
    }

    public String verifierZone() {

        String query = "SELECT * FROM zone_acces WHERE id_zone_acces = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, Server.stringToInt(getId_zone()));

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    setNiveau_requis(Server.intToString(resultSet.getInt("niveau_requis")));

                    return "OK_ZONE";
                } else {
                    return "KO";
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("ERREUR_SQL");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            System.out.println("Type de valeur incorrect");
        }
        return "KO";
    }

    public String verifierNiveau() {
        try {
            if (Server.stringToInt(personne.getNiveau()) >= Server.stringToInt(getNiveau_requis())) {
                return registerAcces();
            }
            return "KO";
        } catch (NumberFormatException e) {
            e.printStackTrace();
            System.out.println("ERREUR_PARSE");
            return "KO";
        }
    }

    private String registerAcces() {

        String sql = "INSERT INTO acces(id_personne, id_zone_acces, heure, jour) VALUES (?, ?, ?, ?)";
        try (
                PreparedStatement preparedStatement = connection.prepareStatement(sql)
        ) {
            preparedStatement.setInt(1, Server.stringToInt(personne.getnPersonne()));
            preparedStatement.setInt(2, Server.stringToInt(getId_zone()));
            preparedStatement.setTime(3, Server.stringToTime(Server.getCurrentTime()));
            preparedStatement.setDate(4, Server.stringToDate(Server.getCurrentDate()));
            int rows = preparedStatement.executeUpdate();

            if (rows == 1) {
                return "OK_ACCESS";
            }
            return "KO";
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("ERREUR_SQL");
            return "KO";
        } catch (NumberFormatException | ParseException e) {
            e.printStackTrace();
            System.out.println("ERREUR_PARSE");
            return "KO";
        }
    }

    public void setPersonne(Personne personne) {
        this.personne = personne;
    }

    public String getId_zone() {
        return id_zone;
    }

    public String getNiveau_requis() {
        return niveau_requis;
    }

    public void setNiveau_requis(String niveau_requis) {
        this.niveau_requis = niveau_requis;
    }

}
