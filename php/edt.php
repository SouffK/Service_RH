<?php

session_start();
$titre='ServiceRH | Emploi du temps';
if (isset($_SESSION['email']) && isset($_SESSION['password'])) {
    include 'include/headerConnect.inc.php';
}else {
    include 'include/header.inc.php';
}

?>





<?php

$db = pg_connect("host=postgresql-projetbd23.alwaysdata.net dbname=projetbd23_srh user=projetbd23_ password=projetbd/r23*")
or die('Connexion impossible : ' . pg_last_error());
$employeId = $_SESSION['id_employee'];
$query = "SELECT * FROM horaire WHERE id_employe = '$employeId'";
$result = pg_query($db, $query);

if (!$result) {
    echo "Erreur lors de l'exécution de la requête.";
    exit;
}

// Affichage des données de l'emploi du temps dans un tableau
echo "<table>
        <tr>
            <th>Jour</th>
            <th>Heure de début</th>
            <th>Heure de fin</th>
        </tr>";

while ($row = pg_fetch_assoc($result)) {
    echo "<tr>
            <td>".$row['jour']."</td>
            <td>".$row['heure_debut']."</td>
            <td>".$row['heure_fin']."</td>
          </tr>";
}

echo "</table>";


pg_close($db);
?>


<?php
    include "include/footer.inc.php";
?>