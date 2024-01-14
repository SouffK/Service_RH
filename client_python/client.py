import socket
from datetime import datetime
from fonctions import *


def pointer(carte_id, a_ip, a_port):
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as client_socket:
        client_socket.connect((a_ip, a_port))
        client_socket.settimeout(10.0)

        envoyer("POINT", client_socket)
        reponse = recevoir(client_socket)

        if reponse == "OK_POINT":
            envoyer(carte_id, client_socket)

            reponse = recevoir(client_socket)
            if reponse == "OK_CARTE":

                envoyer("VERIFY", client_socket)
                reponse = recevoir(client_socket)

                if reponse == "OK_VERIFY":
                    envoyer("BYE", client_socket)
                    printc(f"Pointage validé : {datetime.now().strftime('%H:%M')}")
                elif reponse == "NOT_HEURE":
                    envoyer("BYE", client_socket)
                    printc("Votre horaire de début n'est pas encore arrivée.")
                    printc("Veuillez repointer à ± 5 MINUTES de votre heure de début.")
                elif reponse == "RETARD":
                    printc("Vous êtes en retard. Dérogation nécessaire !")
                    printc("En attente d'un manager...")

                    carte_manager = new_input(">> ")
                    envoyer(carte_manager, client_socket)
                    reponse = recevoir(client_socket)
                    if reponse == "OK_RETARD":
                        printc("Dérogation validée.")
                        printc(f"Début de travail : {datetime.now().strftime('%H:%M')}")
                    else:
                        printc("\nPointage refusé")
                        printc("Veuillez consulter votre manager.")
                    envoyer("BYE", client_socket)
                else:
                    envoyer("BYE", client_socket)
                    printc("\nPointage refusé")
            else:
                envoyer("BYE", client_socket)
                printc("\nVous n'êtes pas reconnu par le système")
        else:
            envoyer("BYE", client_socket)
            printc("\nConnexion au serveur --REFUSÉE--")


def acceder(zone, a_ip, a_port):
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as client_socket:
        printc("\nLecture de carte en attente...")
        id_carte = input(">> ")
        client_socket.connect((a_ip, a_port))
        client_socket.settimeout(10.0)

        envoyer("ACCES", client_socket)
        reponse = recevoir(client_socket)

        if reponse == "OK_ACCES":
            envoyer(zone, client_socket)
            reponse = recevoir(client_socket)

            if reponse == "OK_ZONE":
                envoyer(id_carte, client_socket)
                reponse = recevoir(client_socket)

                if reponse == "OK_CARTE":
                    envoyer("ACCESS", client_socket)
                    reponse = recevoir(client_socket)

                    if reponse == "OK_ACCESS":
                        printc("Accès --AUTORISÉ--")
                    else:
                        printc("Accès --REFUSÉ--")
                    envoyer("BYE", client_socket)
                else:
                    envoyer("BYE", client_socket)
                    printc("\nVous n'êtes pas reconnu par le système")
            else:
                envoyer("BYE", client_socket)
                printc("\nErreur ZONE")
        else:
            envoyer("BYE", client_socket)
            printc("\nConnexion au serveur --REFUSÉE--")


try:
    rep = input("Configuration par défaut ? (O/N): ")
    if rep.upper() == "O":
        ip = "127.0.0.1"
        port = 50000
    else:
        ip = input("Adresse IP : ")
        while(True):
            try :
                port = int(input("Port : "))
            except:
                print("Veuillez rentrer un nombre entier !")


    while True:
        printc("Choisissez une option :")
        printc("1. Pointeuse")
        printc("2. Accéder à une zone")
        choix = input(">> ")

        if choix == "1":
            printc("\nLecture de carte en attente...")
            carte_identifiant = new_input(">> ")
            pointer(carte_identifiant, ip, port)
        elif choix == "2":
            printc("\nNuméro de zone :")
            id_zone = new_input(">> ")
            acceder(id_zone, ip, port)
        else:
            printc("Option non valide.")
except socket.timeout:
    print("\nLe serveur a mis trop de temps à répondre.")
except ConnectionRefusedError:
    print("Impossible de se connecter au serveur. Le serveur pourrait être inactif ou le port est fermé.")
except socket.error:
    printc("\nErreur de connexion avec le serveur.")
except KeyboardInterrupt:
    printc("\nArrêt brutal du client.")
