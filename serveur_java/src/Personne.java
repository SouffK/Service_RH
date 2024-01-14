import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Personne {

    public Personne(String nCarte, Connection connection) {
        nPersonne = nCarte;
        this.connection = connection;
    }

    protected Connection connection;
    protected String niveau;

    protected String nPersonne;

    public boolean init() {
        String query = "SELECT * FROM personne WHERE id_personne = ?";
        try (PreparedStatement pstm = connection.prepareStatement(query)) {
            pstm.setInt(1, Server.stringToInt(getnPersonne()));

            try (ResultSet rs = pstm.executeQuery()) {
                if (rs.next()) {
                    setnPersonne(Server.intToString(rs.getInt("id_personne")));
                    setNiveau(Server.intToString(rs.getInt("niveau")));
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

    public void setNiveau(String niveau) {
        this.niveau = niveau;
    }

    public String getNiveau() {
        return niveau;
    }

    public String getnPersonne() {
        return nPersonne;
    }

    public void setnPersonne(String nPersonne) {
        this.nPersonne = nPersonne;
    }
}
