<?php
session_start();
$titre='ServiceRH | Ajout Horaire ';
if (isset($_SESSION['email']) && isset($_SESSION['password'])) {
    include_once 'include/headerConnect.inc.php';
}else {
    include_once 'include/header.inc.php';
}

$db = pg_connect("host=postgresql-projetbd23.alwaysdata.net dbname=projetbd23_srh user=projetbd23_ password=projetbd/r23*")
             or die('Connexion impossible : ' . pg_last_error());

if (!$db) {
    die("Échec de la connexion à la base de données : " . pg_last_error());
}

// Vérifier si l'utilisateur est connecté et autorisé à insérer des horaires
if (isset($_SESSION['id_employee'])) {
    $employeeId = $_SESSION['id_employee'];

    if (isset($_POST['id']) && isset($_POST['day']) && isset($_POST['start_time']) && isset($_POST['end_time'])) {
        $id = $_POST['id'];
        $employeeId = $_POST['id_employe'];
        $day = $_POST['day'];
        $start_time = $_POST['start_time'];
        $end_time = $_POST['end_time'];

        // Requête SQL pour insérer un nouvel horaire
        $sql = "INSERT INTO horaire (id_horaire, id_employe, jour, heure_debut, heure_fin) VALUES ($1,$2, $3, $4, $5)";
        $result = pg_query_params($db, $sql, array($id,$employeeId, $day, $start_time, $end_time));

        if ($result) {
            echo "Horaire inséré avec succès.";
        } else {
            echo "Erreur lors de l'insertion de l'horaire : " . pg_last_error($db);
        }
    }
} else {
    echo "Utilisateur non autorisé.";
}

?>

<!-- Formulaire pour insérer des horaires -->
<section>
    <h2>Ajouter un horaire</h2>
    <form id="schedule-form" action="ajout.php" method="post">
    <label for="id">ID :</label>
        <input type="text" id="id" name="id" required><br>

        <label for="id_employe">ID de l'employé :</label>
        <input type="text" id="id_employe" name="id_employe" required><br>

        <label for="day">Jour :</label>
        <input type="date" id="day" name="day" required><br>

        <label for="start_time">Heure de début :</label>
        <input type="time" id="start_time" name="start_time" required><br>

        <label for="end_time">Heure de fin :</label>
        <input type="time" id="end_time" name="end_time" required><br>

        <button type="submit">Ajouter l'horaire</button>
    </form>
</section>

<?php
include 'include/footer.inc.php';
pg_close($db);
?>
