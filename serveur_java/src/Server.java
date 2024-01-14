import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketException;
import java.net.SocketTimeoutException;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;

public class Server {

    private ServerSocket serverSocket;

    private Connection connection;

    private final String user = "projetbd23_nasser";
    private final String password = "projetbdrAa*";
    private final String database = "projetbd23_rh";
    private final String jbdc = "jdbc:postgresql://postgresql-projetbd23.alwaysdata.net:5432/";

    public Server(int port) throws IOException, ClassNotFoundException, SQLException {

        this.serverSocket = new ServerSocket(port);
        Class.forName("org.postgresql.Driver");
        this.connection = DriverManager.getConnection( jbdc + database, user, password);
    }

    public void start() {
        System.out.println("Le serveur écoute sur le port " + serverSocket.getLocalPort());

        while (true) {
            try (
                    Socket client = serverSocket.accept();
                    BufferedReader in = new BufferedReader(new InputStreamReader(client.getInputStream()));
                    PrintWriter out = new PrintWriter(client.getOutputStream(), true)
            ) {
                String client_ip = client.getInetAddress().getHostAddress();
                int client_port = client.getPort();
                System.out.println("Nouvelle connection - " + client_ip + ":" + client_port);

                client.setSoTimeout(10000); // Timeout de 10 secondes

                String data = recevoir(in);
                if (data.equalsIgnoreCase("POINT")) {
                    envoyer(out, "OK_POINT");

                    data = recevoir(in);
                    Employe employe = new Employe(data, connection);
                    if (employe.init()) {
                        Pointage pointage = new Pointage(employe, connection);
                        envoyer(out, "OK_CARTE");

                        data = recevoir(in);
                        if(data.equalsIgnoreCase("VERIFY")) {
                            envoyer(out, pointage.verifierHoraire());

                            data = recevoir(in);
                            if(!data.equalsIgnoreCase("BYE")) {

                                Manager manager = new Manager(data, connection);
                                if(manager.init()) {
                                    envoyer(out, pointage.registerRetard());
                                } else {
                                    envoyer(out, "KO");
                                }
                            }
                        } else {
                            envoyer(out, "KO");
                        }
                    } else {
                        envoyer(out, "KO");
                    }
                } else if (data.equalsIgnoreCase("ACCES")) {
                    envoyer(out, "OK_ACCES");

                    Acces acces = new Acces(recevoir(in), connection);
                    envoyer(out, acces.verifierZone());

                    data = recevoir(in);
                    Personne personne = new Personne(data, connection);
                    if (personne.init()) {
                        envoyer(out, "OK_CARTE");

                        acces.setPersonne(personne);

                        data = recevoir(in);
                        if(data.equalsIgnoreCase("ACCESS")) {
                            envoyer(out, acces.verifierNiveau());
                        } else {
                            envoyer(out, "KO");
                        }
                    }
                } else {
                    envoyer(out, "KO");
                }
            } catch (SocketTimeoutException e) {
                System.out.println("Le client a mis trop de temps à répondre.");
            } catch (SocketException | EOFException e) {
                System.out.println("Déconnexion inattendue du client.");
            } catch (IOException e) {
                System.out.println("Connexion interrompue avec le client.");
            }
        }
    }

    /**
     * Convertit une chaîne de caractères en java.sql.Date.
     * @param dateString La chaîne de caractères représentant la date.
     * @return L'objet java.sql.Date correspondant à la chaîne de caractères.
     * @throws ParseException Si la chaîne de caractères n'est pas dans le format attendu.
     */
    public static Date stringToDate(String dateString) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date parsedDate = dateFormat.parse(dateString);
        return new Date(parsedDate.getTime());
    }

    /**
     * Convertit une chaîne de caractères en java.sql.Time.
     * @param timeString La chaîne de caractères représentant l'heure.
     * @return L'objet java.sql.Time correspondant à la chaîne de caractères.
     * @throws ParseException Si la chaîne de caractères n'est pas dans le format attendu.
     */
    public static Time stringToTime(String timeString) throws ParseException {
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
        java.util.Date parsedTime = timeFormat.parse(timeString);
        return new Time(parsedTime.getTime());
    }

    /**
     * Convertit une chaîne de caractères en entier (int).
     * @param intString La chaîne de caractères représentant un nombre entier.
     * @return Le nombre entier (int) correspondant à la chaîne de caractères.
     */
    public static int stringToInt(String intString) throws NumberFormatException {
        return Integer.parseInt(intString);
    }

    /**
     * Convertit un java.sql.Date en chaîne de caractères.
     * @param date L'objet java.sql.Date à convertir.
     * @return La chaîne de caractères représentant la date.
     */
    public static String dateToString(Date date) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        return dateFormat.format(date);
    }

    /**
     * Convertit un java.sql.Time en chaîne de caractères.
     * @param time L'objet java.sql.Time à convertir.
     * @return La chaîne de caractères représentant l'heure.
     */
    public static String timeToString(Time time) {
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
        return timeFormat.format(time);
    }

    /**
     * Convertit un entier (int) en chaîne de caractères.
     * @param number Le nombre entier à convertir.
     * @return La chaîne de caractères représentant le nombre entier.
     */
    public static String intToString(int number) {
        return Integer.toString(number);
    }

    /**
     * Retourne la date actuelle.
     * @return String représentant la date actuelle.
     */
    public static String getCurrentDate() {
        LocalDate currentDate = LocalDate.now();
        return dateToString(Date.valueOf(currentDate));
    }

    /**
     * Retourne l'heure actuelle.
     * @return String représentant l'heure actuelle.
     */
    public static String getCurrentTime() {
        LocalTime currentTime = LocalTime.now();
        return timeToString(Time.valueOf(currentTime));
    }

    /**
     * Reçoit des données à partir d'un BufferedReader.
     * @param br Le BufferedReader à utiliser pour la lecture des données.
     * @return La chaîne de caractères lue.
     * @throws IOException Si une erreur de lecture survient.
     */
    public String recevoir(BufferedReader br) throws IOException {
        int maxSize = 1024;
        char[] buffer = new char[maxSize];
        int read = br.read(buffer, 0, buffer.length);
        if (read == -1) {
            throw new IOException("Fin de flux atteinte");
        }
        return new String(buffer, 0, read);
    }


    /**
     * Envoie des données à un PrintWriter.
     * @param pw Le PrintWriter à utiliser pour l'envoi des données.
     * @param data La chaîne de caractères à envoyer.
     */
    private void envoyer(PrintWriter pw, String data) {
        pw.println(data);
    }

}
