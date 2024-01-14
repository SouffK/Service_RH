<?php  
$titre='ServiceRH | A propos';
    include "include/header.inc.php";
    
?>


<style>
    .team-member {
    width : 300px;
    margin: 20px;
    padding: 15px;
    border: 1px solid #ccc;
    text-align: center;
    display : inline-block;
}

.team-member img {
    width: 200px;
    height: 200px;
    border-radius: 50%;
    margin-bottom: 10px;
}

.team-member h2 {
    margin-bottom: 10px;
    font-size: 1.2em;
}

.team-member p {
    font-size: 0.9em;
}
</style>
<section>
    <h1> Qui sommes-nous ?</h1>
    <h2>Site réalisé dans le cadre d'un projet informatique </h2>
</section>
<section class="team-member">
            <img src="images/img_about.png" alt="Membre 1">
            <h2>KHOMSI Soufiane</h2>
            <p>Programmeur en 3ème années de licence informatique</p>
        </section>

        <section class="team-member">
            <img src="images/img_about.png" alt="Membre 2">
            <h2>TINE Abdelnasser </h2>
            <p>Programmeur en 3ème année de licence informatique</p>
        </section>

        <!-- Ajouter plus de sections pour chaque membre de votre équipe -->

        <!-- Exemple avec un autre membre -->
        <section class="team-member">
            <img src="images/img_about3.png" alt="Membre 3">
            <h2>Colline</h2>
            <p>Progammeuse en 3ème année de licence informatique</p>
        </section>

<?php
    include "include/footer.inc.php";
?>