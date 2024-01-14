<?php
session_start();
$titre='ServiceRH | Se connecter ';
include "include/header.inc.php";


$host = "postgresql-projetbd23.alwaysdata.net";
$port = "5432";
$dbname = "projetbd23_srh";
$user = "projetbd23_";
$password = "projetbd/r23*";
$connection_string = "host={$host} port={$port} dbname={$dbname} user={$user} password={$password}";
$db = pg_connect($connection_string);
$res = 0;

if (!$db) {
    die("Échec de la connexion à la base de données : " . pg_last_error());
}

if (isset($_POST['email']) && isset($_POST['password'])) {
    $email = $_POST['email'];
    $password = $_POST['password'];


    $sql = "SELECT * FROM personne WHERE mail = $1";
    $result = pg_query_params($db, $sql, array($email));

    if (!$result) {
        echo "Erreur dans la requête SQL.";
        exit;
    }
    if (pg_num_rows($result) == 1) {
        $row = pg_fetch_assoc($result);
        $hashedPasswordFromDB = $row['password'];
        if($password == $hashedPasswordFromDB){
            // Authentification réussie
            $_SESSION['email'] = $email;
            $_SESSION['password'] = $password;
            $_SESSION['id_employee'] = $row['id_personne'];
            $_SESSION['user_nom'] = $row['nom'];
            $_SESSION['user_prenom'] = $row['prenom'];
            $_SESSION['user_poste'] = $row['id_jobs'];
            $_SESSION['user_vlm_h'] = $row['volume_horaire'];
            $_SESSION['user_adresse'] = $row['adresse'];
            $_SESSION['user_naissance'] = $row['date_de_naissance'];
            $_SESSION['telephone'] = $row['telephone'];
            $_SESSION['niveau'] = $row['niveau'];
            header('location: interface.php');
            exit;
        } else {
            echo "<p style='color : #FF0000'>Mot de passe incorrect. </p>";
        }
    } else {
        echo "Adresse e-mail non trouvée.";
    }
}
?>

<section>
    <h2>Veuillez saisir vos identifiants confiés par la société</h2>
</section>

<section id="login-section">
    <h2>Connexion</h2>
    <form id="login-form" action="loginv2.php" method="post">
        <label for="email">Adresse e-mail :</label>
        <input type="email" id="email" name="email" required>
        <label for="password">Mot de passe :</label>
        <input type="password" id="password" name="password" required>
        <button type="submit">Se connecter</button>
    </form>
</section>

<?php
include 'include/footer.inc.php';
pg_close($db);
?>
