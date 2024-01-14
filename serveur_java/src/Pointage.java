import java.sql.*;
import java.text.ParseException;
import java.time.LocalTime;
import java.time.format.DateTimeParseException;

public class Pointage {

    private Connection connection;

    private Employe employe;

    public Pointage(Employe employe, Connection connection) {

        this.employe = employe;
        this.connection = connection;
    }

    public String verifierHoraire() {
        try {
            if (employe.getEnFonction()) {
                if(registerPointage("DÉPOINTAGE")) {
                    return "OK_VERIFY";
                }
                return "KO";
            } else {
                String query = "SELECT * FROM horaire WHERE id_employe = ? and jour = ?";
                PreparedStatement preparedStatement = connection.prepareStatement(query);
                preparedStatement.setInt(1, Server.stringToInt(employe.getnPersonne()));
                preparedStatement.setDate(2, Server.stringToDate(employe.getJourCourant()));

                ResultSet resultSet = preparedStatement.executeQuery();
                if (resultSet.next()) {
                    employe.setHeureHoraireDebut(Server.timeToString(resultSet.getTime("heure_debut")));
                    employe.setHeureHoraireFin(Server.timeToString(resultSet.getTime("heure_fin")));

                    LocalTime heure_debut = LocalTime.parse(employe.getHeureHoraireDebut());
                    LocalTime heure_fin = LocalTime.parse(employe.getHeureHoraireFin());
                    LocalTime heure_courante = LocalTime.parse(employe.getHeureCourant());

                    LocalTime limite_inferieure = heure_debut.minusMinutes(5);
                    LocalTime limite_superieure = heure_debut.plusMinutes(5);

                    if (heure_courante.isAfter(limite_inferieure) && heure_courante.isBefore(limite_superieure)) {
                        if(registerPointage("POINTAGE")) {
                            return "OK_VERIFY";
                        }
                        return "KO";
                    } else if (heure_courante.isAfter(heure_debut) && heure_courante.isBefore(heure_fin)) {
                        return "RETARD";
                    } else if (heure_courante.isBefore(limite_inferieure)) {
                        return "NOT_HEURE";
                    } else {
                        return "KO";
                    }
                } else {
                    return "KO";
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("ERREUR_SQL");
            return "KO";
        } catch (NumberFormatException | ParseException e) {
            e.printStackTrace();
            System.out.println("Type de valeur incorrect");
            return "KO";
        }
    }

    public String registerRetard() {
        if(registerPointage("POINTAGE")) {
            String sqlInsert = "INSERT INTO retard(id_employe, heure, jour) VALUES (?, ?, ?)";
            String sqlUpdate = "UPDATE employe SET nb_retard = (SELECT nb_retard FROM employe WHERE id_employe = ?)+1 WHERE id_employe = ?";
            try (
                    PreparedStatement preparedStatementInsert = connection.prepareStatement(sqlInsert);
                    PreparedStatement preparedStatementUpdate = connection.prepareStatement(sqlUpdate)
            ) {
                preparedStatementInsert.setInt(1, Server.stringToInt(employe.getnPersonne()));
                preparedStatementInsert.setTime(2, Server.stringToTime(employe.getHeureCourant()));
                preparedStatementInsert.setDate(3, Server.stringToDate(employe.getJourCourant()));
                int rows = preparedStatementInsert.executeUpdate();

                if (rows == 1) {
                    preparedStatementUpdate.setInt(1, Server.stringToInt(employe.getnPersonne()));
                    preparedStatementUpdate.setInt(2, Server.stringToInt(employe.getnPersonne()));

                    rows = preparedStatementUpdate.executeUpdate();
                    if (rows >= 1) {
                        return "OK_RETARD";
                    } else {
                        return "KO";
                    }
                }
                return "KO";
            } catch (SQLException e) {
                e.printStackTrace();
                System.out.println("ERREUR_SQL");
                return "KO";
            } catch (NumberFormatException | ParseException e) {
                e.printStackTrace();
                System.out.println("Type de valeur incorrect");
                return "KO";
            }
        } else {
            return "KO";
        }
    }

    public boolean registerPointage(String instruction) {

        String sqlInsert = "INSERT INTO pointage(heure_pointage, jour_pointage, id_employe, pointage) VALUES (?, ?, ?, ?)";
        String sqlUpdate = "UPDATE employe SET est_en_fonction = ? WHERE id_employe = ?";
        try (
                PreparedStatement preparedStatementInsert = connection.prepareStatement(sqlInsert);
                PreparedStatement preparedStatementUpdate = connection.prepareStatement(sqlUpdate)
        ) {
            preparedStatementInsert.setTime(1, Server.stringToTime(employe.getHeureCourant()));
            preparedStatementInsert.setDate(2, Server.stringToDate(employe.getJourCourant()));
            preparedStatementInsert.setInt(3, Server.stringToInt(employe.getnPersonne()));
            preparedStatementInsert.setBoolean(4, "POINTAGE".equalsIgnoreCase(instruction));
            int rows = preparedStatementInsert.executeUpdate();

            if (rows == 1) {
                boolean estEnFonction = "POINTAGE".equalsIgnoreCase(instruction);
                preparedStatementUpdate.setBoolean(1, estEnFonction);
                preparedStatementUpdate.setInt(2, Server.stringToInt(employe.getnPersonne()));
                rows = preparedStatementUpdate.executeUpdate();
                if (rows >= 1) {
                    return true;
                } else {
                    return false;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("ERREUR_SQL");
        } catch (NumberFormatException | ParseException e) {
            e.printStackTrace();
            System.out.println("Type de valeur incorrect");
        }
        return false;
    }

}
