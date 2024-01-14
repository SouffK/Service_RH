<?php
session_start();
$titre='ServiceRH | Ajout Employé ';
if (isset($_SESSION['email']) && isset($_SESSION['password'])) {
    include_once 'include/headerConnect.inc.php';
} else {
    include_once 'include/header.inc.php';
}

?>
<style>
     body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 50%;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
        }
        form {
            max-width: 400px;
            margin: 0 auto;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"] {
            width: calc(100% - 12px);
            padding: 6px;
            margin-bottom: 10px;
            border-radius: 3px;
            border: 1px solid #ccc;
        }
        input[type="email"] {
            width: calc(100% - 12px);
            padding: 6px;
            margin-bottom: 10px;
            border-radius: 3px;
            border: 1px solid #ccc;
        }
        input[type="tel"] {
            width: calc(100% - 12px);
            padding: 6px;
            margin-bottom: 10px;
            border-radius: 3px;
            border: 1px solid #ccc;
        }
        input[type="date"] {
            width: calc(100% - 12px);
            padding: 6px;
            margin-bottom: 10px;
            border-radius: 3px;
            border: 1px solid #ccc;
        }
        input[type="submit"] {
            width: 100%;
            padding: 8px;
            border-radius: 3px;
            border: none;
            background-color: #333;
            color: #fff;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
</style>
<h2>Formulaire d'ajout d'employé</h2>
    <form action="ajout.php" method="post">
    <label for="ID">ID :</label>
        <input type="text" id="ID" name="ID" required><br><br>

        <label for="nom">Nom :</label>
        <input type="text" id="nom" name="nom" required><br><br>

        <label for="prenom">Prénom :</label>
        <input type="text" id="prenom" name="prenom" required><br><br>

        <label for="poste">Poste :</label>
        <input type="text" id="poste" name="poste" required><br><br>

        <label for="naissance">Date de naissance :</label>
        <input type="text" id="naissance" name="naissance" required><br><br>

        <label for="tel">Numéro de téléphone :</label>
        <input type="text" id="tel" name="tel" required><br><br>

        <label for="mail">Mail :</label>
        <input type="text" id="mail" name="mail" required><br><br>

        <label for="mdp">Mot de passe :</label>
        <input type="text" id="mdp" name="mdp" required><br><br>

        <label for="adresse">Adresse :</label>
        <input type="text" id="adresse" name="adresse" required><br><br>

        <label for="volume">Volume horaire :</label>
        <input type="text" id="volume" name="volume" required><br><br>

        <label for="niveau">Niveau :</label>
        <input type="text" id="niveau" name="niveau" required><br><br>

        <label for="embauche">Date embauche :</label>
        <input type="text" id="embauche" name="embauche" required><br><br>

        <label for="departement">Departement :</label>
        <input type="text" id="departement" name="departement" required><br><br>

        <label for="salaire">Salaire :</label>
        <input type="text" id="salaire" name="salaire" required><br><br>

        <input type="submit" value="Ajouter">
    </form>

    <img src="images/ajoutEmp.png" alt="Image d'ajout d'employé" width = '20%' height= '10%'>

    <?php

        $db = pg_connect("host=postgresql-projetbd23.alwaysdata.net dbname=projetbd23_srh user=projetbd23_ password=projetbd/r23*")
        or die('Connexion impossible : ' . pg_last_error());

        if ($_SERVER["REQUEST_METHOD"] == "POST") {
            $nom = $_POST['nom'];
            $prenom = $_POST['prenom'];
            $poste = $_POST['poste'];
            $id_employe = $_POST['ID'];
            $naissance = $_POST['naissance'];
            $tel = $_POST['tel'];
            $mail = $_POST['mail'];
            $mdp =$_POST['mdp'];
            $adresse = $_POST['adresse'];
            $volume = $_POST['volume'];
            $niveau = $_POST['niveau'];
            $embauche = $_POST['embauche'];
            $departement = $_POST['departement'];
            $salaire = $_POST['salaire'];
            
        
            // Requête SQL pour insérer un nouvel employé dans la table employees
            $query = "INSERT INTO personne (id_personne, nom, prenom, date_de_naissance, telephone, mail, password, adresse, volume_horaire, niveau, date_embauche, id_departement, salaire, id_jobs ) 
            VALUES ('$id_employe', '$nom', '$prenom', '$naissance', '$tel', '$mail', '$mdp', '$adresse', '$volume', '$niveau', '$embauche' , '$departement', '$salaire', '$poste' )";
        
            $result = pg_query($db, $query);
        
            if ($result) {
                echo "Employé ajouté avec succès.";
            } else {
                echo "Erreur lors de l'ajout de l'employé.";
            }
        }
        
        // Fermeture de la connexion à la base de données
        pg_close($db);


        include "include/footer.inc.php";
    ?>