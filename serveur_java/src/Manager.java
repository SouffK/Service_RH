import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;

public class Manager extends Personne {

    public Manager(String nCarte, Connection connection) {

        super(nCarte, connection);
    }

    @Override
    public boolean init() {
        String query = "SELECT manager.*, personne.* FROM manager JOIN personne ON manager.id_manager = personne.id_personne WHERE id_manager = ?";
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
            return false;
        } catch (NumberFormatException e) {
            e.printStackTrace();
            System.out.println("Type de valeur incorrect");
            return false;
        }
        return false;
    }
}
