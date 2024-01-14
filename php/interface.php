<?php 
session_start();
$titre='ServiceRH | Espace Personnel ';
    if (isset($_SESSION['email']) && isset($_SESSION['password'])) {
        include 'include/headerConnect.inc.php';
    }else {
        include 'include/header.inc.php';
    }
    
?>

    <section>
        <h1>Bienvenue sur votre espace personnel <?php echo $_SESSION['user_prenom']." ".$_SESSION['user_nom']; ?>!</h1>
        <article>
        </article>
    </section>

        <?php
             $db = pg_connect("host=postgresql-projetbd23.alwaysdata.net dbname=projetbd23_srh user=projetbd23_ password=projetbd/r23*")
             or die('Connexion impossible : ' . pg_last_error());
            function getPostePersonneConnectee($db,$employeId) {
               
                $employeId = $_SESSION['id_employee'];
                $query = "SELECT jobs.titre FROM personne INNER JOIN jobs ON personne.id_jobs = jobs.id_jobs  WHERE personne.id_personne = $employeId";
                
                $result = pg_query($db, $query);


                if ($result) {
                    // Récupération de la ligne de résultat
                    $row = pg_fetch_assoc($result);
            
                    if ($row) {
                        // Retourne le poste de la personne connectée
                        return $row['titre'];
                    } else {
                        // Aucun résultat trouvé pour cette personne
                        return null;
                    }
                } else {
                    // Erreur lors de l'exécution de la requête SQL
                    return null;
                }
            }
        ?>
        <?php
           $personneId = $_SESSION['id_employee'];
            $postePersonneConnectee = getPostePersonneConnectee($db, $personneId);
            if ($postePersonneConnectee === 'Manager') {
                // Si le poste de la personne connectée est un manager, afficher le bouton pour les notifications
                echo " <p> Ce site vous pemettra d'ajouter un employé, ajouter des horaires aux employées et consulter vos informations les modifier si le service RH s'est trompé sur une information</p>";
                echo '<a href="ajout_edt.php"><button>Ajouter des horaires</button></a>';
                echo '<a href="ajout.php"><button>Ajouté un employé</button></a>';
            } else {
                // Si le poste de la personne connectée n'est pas un manager, afficher le bouton pour les incidents
                echo "<p> Ce site vous pemettra de visualiser vos différents incidents si vous en avez, consulter vos informations les modifier si le service RH s'est trompé sur une information</p> ";
                echo '<a href="incident.php"><button>Aller aux incidents</button></a>';
                echo '<a href="edt.php"><button>Visualiser mon emploi du temps </button></a>';
            }
        ?>

    <figure>
        <img src="images/img_interface.png" alt="image d'interface"  width=40% height=10% >
    </figure>

<?php
    include "include/footer.inc.php";
?>