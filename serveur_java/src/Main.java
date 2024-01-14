import java.net.BindException;
import java.util.InputMismatchException;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        int port = 50000;
        try (Scanner scanner = new Scanner(System.in)) {
            System.out.print("Configuration par défaut ? (O/N): ");
            if (!scanner.next().equalsIgnoreCase("O")) {
                System.out.print("Veuillez saisir le numéro de port pour le serveur : ");
                port = scanner.nextInt();

                if (port < 1024 || port > 65535) {
                    System.out.println("Numéro de port invalide. Veuillez choisir un port entre 1024 et 65535.");
                    return;
                }
            }
            Server server = new Server(port);
            server.start();
        } catch (BindException e) {
            System.out.println("Le port " + port + " est déjà utilisé.");
        } catch (InputMismatchException e) {
            System.out.println("Type de valeur saisie incorrect");
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }
}

