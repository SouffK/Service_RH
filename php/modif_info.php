<?php
session_start();
$titre='ServiceRH | Informations ';
if (isset($_SESSION['email']) && isset($_SESSION['password'])) {
    include_once 'include/headerConnect.inc.php';
}else {
    include_once 'include/header.inc.php';
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Récupération des nouvelles valeurs depuis le formulaire
    $nouveauNom = $_POST['nom'];
    $nouveauPrenom = $_POST['prenom'];
    $nouveauPoste = $_POST['poste'];
    $nouvelleAdresse = $_POST['adresse'];
    $nouvellesHeures = $_POST['heure'];
    $nouvelEmail = $_POST['email'];

    // Connexion à la base de données (à adapter avec vos informations de connexion)
    $db = pg_connect("host=postgresql-projetbd23.alwaysdata.net dbname=projetbd23_srh user=projetbd23_ password=projetbd/r23*")
    or die('Connexion impossible : ' . pg_last_error());

    // Échappement des données pour éviter les injections SQL
    $nouveauNom = pg_escape_string($db, $nouveauNom);
    $nouveauPrenom = pg_escape_string($db, $nouveauPrenom);
    // ... échapper les autres valeurs de la même manière

    // Mise à jour des informations dans la base de données
    $sql = "UPDATE personne SET nom='$nouveauNom', prenom='$nouveauPrenom', adresse='$nouvelleAdresse' WHERE mail = '{$_SESSION['email']}'";

    // Exécuter la requête SQL pour mettre à jour les données dans la base de données
    $result = pg_query($db, $sql);

    if ($result) {
        echo "Mise à jour des informations réussie";

        // Mettre à jour les variables de session avec les nouvelles valeurs
        $_SESSION['user_nom'] = $nouveauNom;
        $_SESSION['user_prenom'] = $nouveauPrenom;
        $_SESSION['user_poste'] = $nouveauPoste;
        $_SESSION['user_adresse'] = $nouvelleAdresse;
        $_SESSION['user_vlm_h'] = $nouvellesHeures;
    } else {
        echo "Erreur lors de la mise à jour : " . pg_last_error($db);
    }

}

?>
