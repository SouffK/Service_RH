-- Requête pour selectionner une zone qui correspond à l'id
SELECT * FROM zone_acces WHERE id_zone_acces = ?;

-- Requête pour selectionner une employe qui correspond à l'id
SELECT employe.*, personne.* FROM employe JOIN personne ON employe.id_employe = personne.id_personne WHERE id_employe = ?;

-- Requête pour selectionner un manager qui correspond à l'id
SELECT manager.*, personne.* FROM manager JOIN personne ON manager.id_manager = personne.id_personne WHERE id_manager = ?;

-- Requête pour selectionner une personne qui correspond à l'id
SELECT * FROM personne WHERE id_personne = ?;

-- Requête pour selectionner un horaire qui correspond à l'id et à la date
SELECT * FROM horaire WHERE id_employe = ? and jour = ?

--Requête qui selectionne les différentes zones par niveau requis
SELECT niveau_requis, STRING_AGG(id_zone_acces::text, ', ' ORDER BY id_zone_acces) AS salles_concatenated 
FROM zone_acces
GROUP BY niveau_requis;

-- Requête pour selectionner les horaires d'un employé
SELECT * FROM horaire WHERE id_employe = ?;

-- Requête pour selectionner les retards d'un employé 
SELECT * FROM retard WHERE id_employe = ?;

-- Requête qui selectionne les personnes selon leur poste 
SELECT jobs.titre FROM personne INNER JOIN jobs ON personne.id_jobs = jobs.id_jobs  WHERE personne.id_personne = ?;

--Requête qui selectionne le mail d'une personne
SELECT * FROM personne WHERE mail = ?;