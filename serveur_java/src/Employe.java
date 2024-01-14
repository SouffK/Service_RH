import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Employe extends Personne{

    private String heureHoraireDebut;
    private String heureHoraireFin;

    private String heureCourant;
    private String jourCourant;

    private boolean enFonction;


    public Employe(String nCarte, Connection connection) {

        super(nCarte, connection);
    }

    @Override
    public boolean init() {
        String query = "SELECT employe.*, personne.* FROM employe JOIN personne ON employe.id_employe = personne.id_personne WHERE id_employe = ?";
        try (PreparedStatement pstm = connection.prepareStatement(query)) {
            pstm.setInt(1, Server.stringToInt(getnPersonne()));

            try (ResultSet rs = pstm.executeQuery()) {
                if (rs.next()) {
                    setNiveau(Server.intToString(rs.getInt("niveau")));
                    setEnFonction(rs.getBoolean("est_en_fonction"));
                    setHeureCourant(Server.getCurrentTime());
                    setJourCourant(Server.getCurrentDate());
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("ERREUR_SQL");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            System.out.println("Type de valeur incorrect");
        }
        return false;
    }

    public String getHeureHoraireDebut() {
        return heureHoraireDebut;
    }

    public void setHeureHoraireDebut(String heureHoraireDebut) {
        this.heureHoraireDebut = heureHoraireDebut;
    }

    public String getHeureHoraireFin() {
        return heureHoraireFin;
    }

    public void setHeureHoraireFin(String heureHoraireFin) {
        this.heureHoraireFin = heureHoraireFin;
    }

    public String getHeureCourant() {
        return heureCourant;
    }

    public void setHeureCourant(String heureCourant) {
        this.heureCourant = heureCourant;
    }

    public String getJourCourant() {
        return jourCourant;
    }

    public void setJourCourant(String jourCourant) {
        this.jourCourant = jourCourant;
    }

    public boolean getEnFonction() {
        return enFonction;
    }

    public void setEnFonction(boolean enFonction) {
        this.enFonction = enFonction;
    }

    public String getNiveau() {
        return niveau;
    }

    public void setNiveau(String niveau) {
        this.niveau = niveau;
    }
}
