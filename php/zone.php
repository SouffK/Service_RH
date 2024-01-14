<?php 
    session_start();
    $titre='ServiceRH | Les zones';

    if (isset($_SESSION['email']) && isset($_SESSION['password'])) {
        include 'include/headerConnect.inc.php';
    }else {
        include 'include/header.inc.php';
    }
    
?>


<?php
$db = pg_connect("host=postgresql-projetbd23.alwaysdata.net dbname=projetbd23_srh user=projetbd23_ password=projetbd/r23*")
or die('Connexion impossible : ' . pg_last_error());

$sql = "SELECT niveau_requis, STRING_AGG(id_zone_acces::text, ', ' ORDER BY id_zone_acces) AS salles_concatenated 
FROM zone_acces
GROUP BY niveau_requis";


$result = pg_query($db, $sql);
if (!$result) {
echo "Erreur lors de l'exécution de la requête.";
exit;
}

echo "<p> Voici les plans du batiments pour s'y retrouver <p> ";

// Affichage des résultats
echo " Votre niveau est ". $_SESSION['niveau']. "";
echo "<table><tr><th>Niveau minimum requis</th><th>Zones</th></tr>";
while ($row = pg_fetch_assoc($result)) {
echo "<tr><td>".$row['niveau_requis']."</td><td>".$row['salles_concatenated']."</td></tr>";
}
echo "</table>";

?>

<figure>
    <img src="images/img_zone.png" alt="Image de zone" width=30% height=10%>
</figure>


<?php 
    include "include/footer.inc.php";
?>
