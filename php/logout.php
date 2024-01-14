<?php
    $titre='ServiceRH | Deconnexion ';
    include "include/header.inc.php";
    
?>
<?php
// Démarrez la session
session_start();
echo "Vous êtes bien déconnecter";
// Détruire toutes les variables de session
session_unset();

// Détruire la session
session_destroy();

echo "<figure>";
echo "<img src='images/img_deconnexion.png' alt='image de deconnexion' width='20%' height='10%'</img>";
echo "<form action='index.php' class='return-form'>";
echo "<input type='submit' value='Retour a la connexion'>";
echo "</form>";
exit();
?>

<?php
    include "include/footer.inc.php";
?>