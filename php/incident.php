<?php
session_start();
$titre='ServiceRH | Retards ';
if (isset($_SESSION['email']) && isset($_SESSION['password'])) {
    include_once 'include/headerConnect.inc.php';
} else {
    include_once 'include/header.inc.php';
}

// Connexion à la base de données PostgreSQL
$db = pg_connect("host=postgresql-projetbd23.alwaysdata.net dbname=projetbd23_srh user=projetbd23_ password=projetbd/r23*")
    or die('Connexion impossible : ' . pg_last_error());

if (isset($_SESSION['id_employee'])) {
    // Requête SQL pour sélectionner les incidents de l'utilisateur spécifié
    $id_employee = $_SESSION['id_employee'];
    $sql = "SELECT * FROM retard WHERE id_employe = '$id_employee'";

    $result = pg_query($db, $sql);
    if ($result) {
        if (pg_num_rows($result) > 0) {
            // Affichage des résultats s'il y a des incidents pour cet utilisateur
            echo "<h2> Vos incidents :</h2>";
            echo "<ul>";
            while ($row = pg_fetch_assoc($result)) {
                echo "<li> Vous êtes arrivé en retard le " . $row["jour"] . " à ". $row["heure"] ." </li>";
            }
            echo "</ul>";
        } else {
            echo "Aucun incident trouvé pour cet utilisateur.";
        }
    } else {
        echo "Erreur lors de l'exécution de la requête : " . pg_last_error($db);
    }
} else {
    echo "Aucun ID d'employé trouvé dans la session.";
}

echo "<img src='images/img_incident.png' alt='Image d'incident' width='30%' height='10%'>";


include "include/footer.inc.php";
?>
