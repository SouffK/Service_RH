import time


def printc(text, speed=7):
    text += "\n"
    for c in text:
        print(c, end='', flush=True)
        time.sleep(speed / 1000.0)


def envoyer(text, soc):
    message = text + "\n"
    soc.sendall(message.encode("utf-8"))


def recevoir(soc):
    reponse_complete = ""
    while True:
        donnees_recues = soc.recv(255)
        if not donnees_recues:
            break
        reponse_complete += donnees_recues.decode("utf-8")
        if "\n" in reponse_complete:
            break

    return reponse_complete.rstrip("\n")


def new_input(prompt):
    while True:
        try:
            valeur = int(input(prompt))
            return str(valeur)
        except ValueError:
            print("Veuillez entrer un nombre entier.")
