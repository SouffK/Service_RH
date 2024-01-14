<?php 
    session_start();
    $titre='ServiceRH | Informations ';
    if (isset($_SESSION['email']) && isset($_SESSION['password'])) {
        include_once 'include/headerConnect.inc.php';
    }else {
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
<section>
    <article>
    <section>
    <h1> Vos informations </h1>
    <article>
        <div class="container">
        <?php
        echo "<form action='modif_info.php' method='post'>";
        echo "<p> Nom : <input type='text' name='nom' value='" . $_SESSION['user_nom'] . "'></p>";
        echo "<p> Prenom : <input type='text' name='prenom' value='" . $_SESSION['user_prenom'] . "'></p>";
        echo "<p> Adresse : <input type='text' name='adresse' value='" . $_SESSION['user_adresse'] . "'></p>";
        echo "<p> Adresse Mail : <input type='email' name='email' value='" . $_SESSION['email'] . "'></p>";
        echo "<p> Numéro de téléphone : <input type='tel' name='tel' value='" . $_SESSION['telephone'] . "'></p>";
        echo "<p> Date de naissance : <input type='date' name='date' value='" . $_SESSION['user_naissance'] . "'></p>";
        echo "<input type='submit' value='Modifier'>";
        echo "</form>";
        ?>
        </div>
    </article>
</section>

    </article>

    <article>

<?php
    include "include/footer.inc.php";
?>