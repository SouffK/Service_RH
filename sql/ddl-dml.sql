--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9 (Homebrew)
-- Dumped by pg_dump version 14.9 (Homebrew)


ALTER TABLE IF EXISTS ONLY public.acces DROP CONSTRAINT IF EXISTS id_zone_acces_fk;
ALTER TABLE IF EXISTS ONLY public.acces DROP CONSTRAINT IF EXISTS id_personne_fk;
ALTER TABLE IF EXISTS ONLY public.manager DROP CONSTRAINT IF EXISTS id_manager_fk;
ALTER TABLE IF EXISTS ONLY public.personne DROP CONSTRAINT IF EXISTS id_jobs_fk;
ALTER TABLE IF EXISTS ONLY public.retard DROP CONSTRAINT IF EXISTS id_employe_fk;
ALTER TABLE IF EXISTS ONLY public.pointage DROP CONSTRAINT IF EXISTS id_employe_fk;
ALTER TABLE IF EXISTS ONLY public.horaire DROP CONSTRAINT IF EXISTS id_employe_fk;
ALTER TABLE IF EXISTS ONLY public.employe DROP CONSTRAINT IF EXISTS id_employe_fk;
ALTER TABLE IF EXISTS ONLY public.personne DROP CONSTRAINT IF EXISTS id_departement_fk;
ALTER TABLE IF EXISTS ONLY public.zone_acces DROP CONSTRAINT IF EXISTS zone_acces_pk;
ALTER TABLE IF EXISTS ONLY public.retard DROP CONSTRAINT IF EXISTS retard_pk;
ALTER TABLE IF EXISTS ONLY public.pointage DROP CONSTRAINT IF EXISTS pointage_pk;
ALTER TABLE IF EXISTS ONLY public.personne DROP CONSTRAINT IF EXISTS personne_pk3;
ALTER TABLE IF EXISTS ONLY public.personne DROP CONSTRAINT IF EXISTS personne_pk2;
ALTER TABLE IF EXISTS ONLY public.personne DROP CONSTRAINT IF EXISTS personne_pk;
ALTER TABLE IF EXISTS ONLY public.manager DROP CONSTRAINT IF EXISTS manager_pk;
ALTER TABLE IF EXISTS ONLY public.jobs DROP CONSTRAINT IF EXISTS jobs_pk;
ALTER TABLE IF EXISTS ONLY public.horaire DROP CONSTRAINT IF EXISTS horaire_pk;
ALTER TABLE IF EXISTS ONLY public.employe DROP CONSTRAINT IF EXISTS employe_pk;
ALTER TABLE IF EXISTS ONLY public.departement DROP CONSTRAINT IF EXISTS departement_pk;
ALTER TABLE IF EXISTS ONLY public.acces DROP CONSTRAINT IF EXISTS acces_pk;
ALTER TABLE IF EXISTS public.zone_acces ALTER COLUMN id_zone_acces DROP DEFAULT;
ALTER TABLE IF EXISTS public.retard ALTER COLUMN id_retard DROP DEFAULT;
ALTER TABLE IF EXISTS public.pointage ALTER COLUMN id_pointage DROP DEFAULT;
ALTER TABLE IF EXISTS public.horaire ALTER COLUMN id_horaire DROP DEFAULT;
ALTER TABLE IF EXISTS public.departement ALTER COLUMN id_departement DROP DEFAULT;
ALTER TABLE IF EXISTS public.acces ALTER COLUMN id_acces DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.zone_acces_id_zone_acces_seq;
DROP TABLE IF EXISTS public.zone_acces;
DROP SEQUENCE IF EXISTS public.retard_id_retard_seq;
DROP TABLE IF EXISTS public.retard;
DROP SEQUENCE IF EXISTS public.pointage_id_pointage_seq;
DROP TABLE IF EXISTS public.pointage;
DROP TABLE IF EXISTS public.personne;
DROP SEQUENCE IF EXISTS public.personne_id_personne_seq;
DROP TABLE IF EXISTS public.manager;
DROP TABLE IF EXISTS public.jobs;
DROP SEQUENCE IF EXISTS public.jobs_id_jobs_seq;
DROP SEQUENCE IF EXISTS public.horaire_id_horaire_seq;
DROP TABLE IF EXISTS public.horaire;
DROP TABLE IF EXISTS public.employe;
DROP SEQUENCE IF EXISTS public.departement_id_departement_seq;
DROP TABLE IF EXISTS public.departement;
DROP SEQUENCE IF EXISTS public.acces_id_acces_seq;
DROP TABLE IF EXISTS public.acces;

--
-- Name: acces; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.acces (
    id_acces integer NOT NULL,
    id_personne integer NOT NULL,
    id_zone_acces integer NOT NULL,
    heure time without time zone NOT NULL,
    jour date NOT NULL
);


--
-- Name: acces_id_acces_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.acces_id_acces_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: acces_id_acces_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.acces_id_acces_seq OWNED BY public.acces.id_acces;


--
-- Name: departement; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.departement (
    id_departement integer NOT NULL,
    intitule character varying(20) NOT NULL,
    nombre_employe integer NOT NULL
);


--
-- Name: departement_id_departement_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.departement_id_departement_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: departement_id_departement_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.departement_id_departement_seq OWNED BY public.departement.id_departement;


--
-- Name: employe; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.employe (
    id_employe integer NOT NULL,
    est_en_fonction boolean DEFAULT false NOT NULL,
    nb_retard integer DEFAULT 0 NOT NULL
);


--
-- Name: horaire; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.horaire (
    id_horaire integer NOT NULL,
    id_employe integer NOT NULL,
    heure_debut time without time zone NOT NULL,
    jour date NOT NULL,
    heure_fin time without time zone NOT NULL
);


--
-- Name: horaire_id_horaire_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.horaire_id_horaire_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: horaire_id_horaire_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.horaire_id_horaire_seq OWNED BY public.horaire.id_horaire;


--
-- Name: jobs_id_jobs_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.jobs_id_jobs_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jobs (
    id_jobs integer DEFAULT nextval('public.jobs_id_jobs_seq'::regclass) NOT NULL,
    titre character varying(35) NOT NULL,
    salaire_min numeric(8,2) NOT NULL,
    salaire_max numeric(8,2) NOT NULL
);


--
-- Name: manager; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.manager (
    id_manager integer NOT NULL,
    prime_objectif numeric(8,2) NOT NULL
);


--
-- Name: personne_id_personne_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.personne_id_personne_seq
    START WITH 1001001
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: personne; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.personne (
    id_personne integer DEFAULT nextval('public.personne_id_personne_seq'::regclass) NOT NULL,
    nom character varying(30) NOT NULL,
    prenom character varying(30) NOT NULL,
    date_de_naissance date NOT NULL,
    telephone character varying(15),
    mail character varying(50),
    password character varying(256) NOT NULL,
    adresse character varying(70) NOT NULL,
    volume_horaire integer NOT NULL,
    niveau integer NOT NULL,
    date_embauche date NOT NULL,
    id_departement integer NOT NULL,
    salaire numeric(8,2) NOT NULL,
    id_jobs integer NOT NULL
);


--
-- Name: pointage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pointage (
    id_pointage integer NOT NULL,
    heure_pointage time without time zone NOT NULL,
    jour_pointage date NOT NULL,
    id_employe integer NOT NULL,
    pointage boolean NOT NULL
);


--
-- Name: pointage_id_pointage_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pointage_id_pointage_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pointage_id_pointage_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pointage_id_pointage_seq OWNED BY public.pointage.id_pointage;


--
-- Name: retard; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.retard (
    id_retard integer NOT NULL,
    id_employe integer NOT NULL,
    heure time without time zone NOT NULL,
    jour date NOT NULL
);


--
-- Name: retard_id_retard_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.retard_id_retard_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: retard_id_retard_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.retard_id_retard_seq OWNED BY public.retard.id_retard;


--
-- Name: zone_acces; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.zone_acces (
    id_zone_acces integer NOT NULL,
    niveau_requis integer NOT NULL,
    description character varying(50)
);


--
-- Name: zone_acces_id_zone_acces_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.zone_acces_id_zone_acces_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: zone_acces_id_zone_acces_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.zone_acces_id_zone_acces_seq OWNED BY public.zone_acces.id_zone_acces;


--
-- Name: acces id_acces; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acces ALTER COLUMN id_acces SET DEFAULT nextval('public.acces_id_acces_seq'::regclass);


--
-- Name: departement id_departement; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.departement ALTER COLUMN id_departement SET DEFAULT nextval('public.departement_id_departement_seq'::regclass);


--
-- Name: horaire id_horaire; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.horaire ALTER COLUMN id_horaire SET DEFAULT nextval('public.horaire_id_horaire_seq'::regclass);


--
-- Name: pointage id_pointage; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pointage ALTER COLUMN id_pointage SET DEFAULT nextval('public.pointage_id_pointage_seq'::regclass);


--
-- Name: retard id_retard; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.retard ALTER COLUMN id_retard SET DEFAULT nextval('public.retard_id_retard_seq'::regclass);


--
-- Name: zone_acces id_zone_acces; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.zone_acces ALTER COLUMN id_zone_acces SET DEFAULT nextval('public.zone_acces_id_zone_acces_seq'::regclass);


--
-- Data for Name: acces; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.acces (id_acces, id_personne, id_zone_acces, heure, jour) VALUES (4, 1001001, 1, '23:21:21', '2023-11-22');
INSERT INTO public.acces (id_acces, id_personne, id_zone_acces, heure, jour) VALUES (5, 1001001, 2, '23:22:09', '2023-11-22');
INSERT INTO public.acces (id_acces, id_personne, id_zone_acces, heure, jour) VALUES (6, 1001010, 1, '05:38:24', '2023-11-26');
INSERT INTO public.acces (id_acces, id_personne, id_zone_acces, heure, jour) VALUES (7, 1001001, 1, '05:47:27', '2023-11-26');
INSERT INTO public.acces (id_acces, id_personne, id_zone_acces, heure, jour) VALUES (8, 1001002, 2, '06:00:03', '2023-11-26');
INSERT INTO public.acces (id_acces, id_personne, id_zone_acces, heure, jour) VALUES (9, 1001007, 1, '06:21:23', '2023-11-26');
INSERT INTO public.acces (id_acces, id_personne, id_zone_acces, heure, jour) VALUES (10, 1001003, 1, '06:25:39', '2023-11-26');
INSERT INTO public.acces (id_acces, id_personne, id_zone_acces, heure, jour) VALUES (11, 1001019, 7, '06:27:29', '2023-11-26');
INSERT INTO public.acces (id_acces, id_personne, id_zone_acces, heure, jour) VALUES (12, 1001007, 5, '06:27:53', '2023-11-26');
INSERT INTO public.acces (id_acces, id_personne, id_zone_acces, heure, jour) VALUES (13, 1001010, 3, '06:28:05', '2023-11-26');
INSERT INTO public.acces (id_acces, id_personne, id_zone_acces, heure, jour) VALUES (14, 1001008, 6, '06:28:41', '2023-11-26');


--
-- Data for Name: departement; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.departement (id_departement, intitule, nombre_employe) VALUES (1, 'Informatique', 0);
INSERT INTO public.departement (id_departement, intitule, nombre_employe) VALUES (2, 'Ventes', 0);
INSERT INTO public.departement (id_departement, intitule, nombre_employe) VALUES (3, 'Ressources Humaines', 0);
INSERT INTO public.departement (id_departement, intitule, nombre_employe) VALUES (4, 'Marketing', 0);
INSERT INTO public.departement (id_departement, intitule, nombre_employe) VALUES (5, 'Comptabilité', 0);
INSERT INTO public.departement (id_departement, intitule, nombre_employe) VALUES (6, 'Managment général', 0);


--
-- Data for Name: employe; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.employe (id_employe, est_en_fonction, nb_retard) VALUES (1001005, false, 0);
INSERT INTO public.employe (id_employe, est_en_fonction, nb_retard) VALUES (1001009, false, 0);
INSERT INTO public.employe (id_employe, est_en_fonction, nb_retard) VALUES (1001012, false, 0);
INSERT INTO public.employe (id_employe, est_en_fonction, nb_retard) VALUES (1001001, false, 1);
INSERT INTO public.employe (id_employe, est_en_fonction, nb_retard) VALUES (1001013, false, 0);
INSERT INTO public.employe (id_employe, est_en_fonction, nb_retard) VALUES (1001011, false, 1);
INSERT INTO public.employe (id_employe, est_en_fonction, nb_retard) VALUES (1001002, true, 1);
INSERT INTO public.employe (id_employe, est_en_fonction, nb_retard) VALUES (1001004, true, 1);
INSERT INTO public.employe (id_employe, est_en_fonction, nb_retard) VALUES (1001018, true, 1);


--
-- Data for Name: horaire; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.horaire (id_horaire, id_employe, heure_debut, jour, heure_fin) VALUES (3, 1001001, '00:10:00', '2023-11-23', '07:00:00');
INSERT INTO public.horaire (id_horaire, id_employe, heure_debut, jour, heure_fin) VALUES (4, 1001013, '07:10:00', '2023-11-26', '12:00:00');
INSERT INTO public.horaire (id_horaire, id_employe, heure_debut, jour, heure_fin) VALUES (5, 1001011, '07:00:00', '2023-11-26', '15:00:00');
INSERT INTO public.horaire (id_horaire, id_employe, heure_debut, jour, heure_fin) VALUES (6, 1001002, '07:00:00', '2023-11-26', '12:00:00');
INSERT INTO public.horaire (id_horaire, id_employe, heure_debut, jour, heure_fin) VALUES (7, 1001004, '06:10:00', '2023-11-26', '19:00:00');
INSERT INTO public.horaire (id_horaire, id_employe, heure_debut, jour, heure_fin) VALUES (8, 1001018, '03:00:00', '2023-11-26', '10:00:00');
INSERT INTO public.horaire (id_horaire, id_employe, heure_debut, jour, heure_fin) VALUES (9, 1001009, '07:15:00', '2023-11-26', '15:15:00');


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.jobs (id_jobs, titre, salaire_min, salaire_max) VALUES (1, 'Comptable Public', 4200.00, 9000.00);
INSERT INTO public.jobs (id_jobs, titre, salaire_min, salaire_max) VALUES (2, 'Manager Comptabilité', 8200.00, 16000.00);
INSERT INTO public.jobs (id_jobs, titre, salaire_min, salaire_max) VALUES (3, 'Assistant Administratif', 3000.00, 6000.00);
INSERT INTO public.jobs (id_jobs, titre, salaire_min, salaire_max) VALUES (4, 'Président', 20000.00, 40000.00);
INSERT INTO public.jobs (id_jobs, titre, salaire_min, salaire_max) VALUES (5, 'Vice-Président Administration', 15000.00, 30000.00);
INSERT INTO public.jobs (id_jobs, titre, salaire_min, salaire_max) VALUES (6, 'Comptable', 4200.00, 9000.00);
INSERT INTO public.jobs (id_jobs, titre, salaire_min, salaire_max) VALUES (7, 'Manager Financier', 8200.00, 16000.00);
INSERT INTO public.jobs (id_jobs, titre, salaire_min, salaire_max) VALUES (8, 'Ressources Humaines', 4000.00, 9000.00);
INSERT INTO public.jobs (id_jobs, titre, salaire_min, salaire_max) VALUES (9, 'Développeur Informatique', 4000.00, 10000.00);
INSERT INTO public.jobs (id_jobs, titre, salaire_min, salaire_max) VALUES (10, 'Manager Marketing', 9000.00, 15000.00);


--
-- Data for Name: manager; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.manager (id_manager, prime_objectif) VALUES (1001006, 2000.00);
INSERT INTO public.manager (id_manager, prime_objectif) VALUES (1001007, 2000.00);
INSERT INTO public.manager (id_manager, prime_objectif) VALUES (1001010, 2000.00);
INSERT INTO public.manager (id_manager, prime_objectif) VALUES (1001015, 2000.00);
INSERT INTO public.manager (id_manager, prime_objectif) VALUES (1001017, 2000.00);
INSERT INTO public.manager (id_manager, prime_objectif) VALUES (1001003, 1700.00);
INSERT INTO public.manager (id_manager, prime_objectif) VALUES (1001016, 1000.00);
INSERT INTO public.manager (id_manager, prime_objectif) VALUES (1001014, 1000.00);
INSERT INTO public.manager (id_manager, prime_objectif) VALUES (1001019, 2500.00);
INSERT INTO public.manager (id_manager, prime_objectif) VALUES (1001008, 1000.00);


--
-- Data for Name: personne; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.personne (id_personne, nom, prenom, date_de_naissance, telephone, mail, password, adresse, volume_horaire, niveau, date_embauche, id_departement, salaire, id_jobs) VALUES (1001001, 'Martin', 'Léa', '1992-11-30', '0712345678', 'lea.martin@gmail.com', 'mdp123', '3 boulevard Haussmann, 75009 Paris', 32, 2, '2020-08-15', 1, 4500.00, 1);
INSERT INTO public.personne (id_personne, nom, prenom, date_de_naissance, telephone, mail, password, adresse, volume_horaire, niveau, date_embauche, id_departement, salaire, id_jobs) VALUES (1001002, 'Bernard', 'Emma', '1988-04-10', '0678456712', 'emma.bernard@gmail.com', 'pass1234', '22 rue de Rivoli, 75004 Paris', 38, 3, '2017-01-05', 5, 6100.00, 6);
INSERT INTO public.personne (id_personne, nom, prenom, date_de_naissance, telephone, mail, password, adresse, volume_horaire, niveau, date_embauche, id_departement, salaire, id_jobs) VALUES (1001004, 'Kari', 'Ayman', '2004-08-20', '0727293729', 'ayman.kari@gmail.com', 'password', '2 rue Lyon, 75001 Paris', 30, 1, '2021-05-05', 1, 5000.00, 9);
INSERT INTO public.personne (id_personne, nom, prenom, date_de_naissance, telephone, mail, password, adresse, volume_horaire, niveau, date_embauche, id_departement, salaire, id_jobs) VALUES (1001005, 'Petit', 'Julie', '1989-12-25', '0789654321', 'julie.petit@gmail.com', 'mypassword', '18 avenue des Champs-Élysées, 75008 Paris', 33, 2, '2016-07-07', 3, 4500.00, 8);
INSERT INTO public.personne (id_personne, nom, prenom, date_de_naissance, telephone, mail, password, adresse, volume_horaire, niveau, date_embauche, id_departement, salaire, id_jobs) VALUES (1001006, 'Dupont', 'Sarah', '1990-03-15', '0654367821', 'sarah.dupont@gmail.com', 'motdepasse', '15 avenue Montaigne, 75008 Paris', 35, 3, '2019-09-01', 2, 9500.00, 10);
INSERT INTO public.personne (id_personne, nom, prenom, date_de_naissance, telephone, mail, password, adresse, volume_horaire, niveau, date_embauche, id_departement, salaire, id_jobs) VALUES (1001008, 'Leblanc', 'Marc', '1985-07-22', '0622345678', 'marc.leblanc@gmail.com', 'secret', '10 rue de la Paix, 75002 Paris', 40, 4, '2018-02-20', 6, 18000.00, 5);
INSERT INTO public.personne (id_personne, nom, prenom, date_de_naissance, telephone, mail, password, adresse, volume_horaire, niveau, date_embauche, id_departement, salaire, id_jobs) VALUES (1001009, 'Moreau', 'Anne', '1984-02-17', '0712345679', 'anne.moreau@gmail.com', 'mdp234', '4 boulevard Haussmann, 75009 Paris', 40, 2, '2019-01-15', 1, 6000.00, 3);
INSERT INTO public.personne (id_personne, nom, prenom, date_de_naissance, telephone, mail, password, adresse, volume_horaire, niveau, date_embauche, id_departement, salaire, id_jobs) VALUES (1001011, 'Blanchard', 'Hugo', '1987-09-08', '0623456789', 'hugo.blanchard@gmail.com', 'hello123', '9 avenue Parmentier, 75011 Paris', 30, 1, '2019-08-20', 3, 4500.00, 8);
INSERT INTO public.personne (id_personne, nom, prenom, date_de_naissance, telephone, mail, password, adresse, volume_horaire, niveau, date_embauche, id_departement, salaire, id_jobs) VALUES (1001012, 'Gauthier', 'Émilie', '1982-12-22', '0690123456', 'emilie.gauthier@gmail.com', 'mypassword123', '2 rue de Charonne, 75011 Paris', 38, 3, '2020-05-05', 5, 6500.00, 6);
INSERT INTO public.personne (id_personne, nom, prenom, date_de_naissance, telephone, mail, password, adresse, volume_horaire, niveau, date_embauche, id_departement, salaire, id_jobs) VALUES (1001013, 'Lemoine', 'Clara', '1996-04-18', '0745612390', 'clara.lemoine@gmail.com', 'secret123', '7 rue de la Roquette, 75011 Paris', 36, 2, '2021-07-07', 1, 5500.00, 9);
INSERT INTO public.personne (id_personne, nom, prenom, date_de_naissance, telephone, mail, password, adresse, volume_horaire, niveau, date_embauche, id_departement, salaire, id_jobs) VALUES (1001014, 'Lefebvre', 'Maxime', '1990-01-30', '0632145678', 'maxime.lefebvre@gmail.com', '1234abcd', '6 rue de Lappe, 75011 Paris', 40, 4, '2018-11-11', 6, 25000.00, 5);
INSERT INTO public.personne (id_personne, nom, prenom, date_de_naissance, telephone, mail, password, adresse, volume_horaire, niveau, date_embauche, id_departement, salaire, id_jobs) VALUES (1001016, 'Bonnet', 'Quentin', '1998-05-23', '0656781234', 'quentin.bonnet@gmail.com', 'qwerty', '15 rue de la Roquette, 75011 Paris', 38, 3, '2020-09-09', 4, 9500.00, 10);
INSERT INTO public.personne (id_personne, nom, prenom, date_de_naissance, telephone, mail, password, adresse, volume_horaire, niveau, date_embauche, id_departement, salaire, id_jobs) VALUES (1001018, 'Lambert', 'Camille', '1994-11-11', '0623456790', 'camille.lambert@gmail.com', 'password123', '25 rue du Faubourg Saint-Antoine, 75012 Paris', 36, 1, '2022-03-03', 1, 4500.00, 1);
INSERT INTO public.personne (id_personne, nom, prenom, date_de_naissance, telephone, mail, password, adresse, volume_horaire, niveau, date_embauche, id_departement, salaire, id_jobs) VALUES (1001019, 'Roux', 'Alice', '1991-06-12', '0765432190', 'alice.roux@gmail.com', 'mdp456', '8 rue du Faubourg Saint-Antoine, 75012 Paris', 40, 3, '2021-04-01', 2, 8500.00, 10);
INSERT INTO public.personne (id_personne, nom, prenom, date_de_naissance, telephone, mail, password, adresse, volume_horaire, niveau, date_embauche, id_departement, salaire, id_jobs) VALUES (1001010, 'Simon', 'Lucas', '1995-03-15', '0678901234', 'lucas.simon@gmail.com', 'password2', '11 rue Oberkampf, 75011 Paris', 35, 4, '2022-01-10', 4, 11000.00, 4);
INSERT INTO public.personne (id_personne, nom, prenom, date_de_naissance, telephone, mail, password, adresse, volume_horaire, niveau, date_embauche, id_departement, salaire, id_jobs) VALUES (1001003, 'Girard', 'Thomas', '1994-05-19', '0765432189', 'thomas.girard@gmail.com', 'password1', '1 rue du Louvre, 75001 Paris', 36, 3, '2022-03-10', 3, 6500.00, 7);
INSERT INTO public.personne (id_personne, nom, prenom, date_de_naissance, telephone, mail, password, adresse, volume_horaire, niveau, date_embauche, id_departement, salaire, id_jobs) VALUES (1001017, 'Francois', 'Julien', '1986-08-17', '0765432191', 'julien.francois@gmail.com', '12345678', '20 rue de la Bastille, 75004 Paris', 35, 3, '2019-06-06', 3, 5000.00, 7);
INSERT INTO public.personne (id_personne, nom, prenom, date_de_naissance, telephone, mail, password, adresse, volume_horaire, niveau, date_embauche, id_departement, salaire, id_jobs) VALUES (1001015, 'Leroy', 'Sophie', '1993-07-19', '0612345678', 'sophie.leroy@gmail.com', 'letmein', '5 rue de la Bastille, 75004 Paris', 32, 3, '2021-02-02', 2, 9200.00, 2);
INSERT INTO public.personne (id_personne, nom, prenom, date_de_naissance, telephone, mail, password, adresse, volume_horaire, niveau, date_embauche, id_departement, salaire, id_jobs) VALUES (1001007, 'Durand', 'Nicolas', '1993-09-09', '0698765432', 'nicolas.durand@gmail.com', 'abc123', '5 rue de la République, 75003 Paris', 29, 4, '2021-11-11', 4, 7500.00, 4);


--
-- Data for Name: pointage; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.pointage (id_pointage, heure_pointage, jour_pointage, id_employe, pointage) VALUES (9, '00:24:58', '2023-11-23', 1001001, true);
INSERT INTO public.pointage (id_pointage, heure_pointage, jour_pointage, id_employe, pointage) VALUES (10, '00:25:10', '2023-11-23', 1001001, false);
INSERT INTO public.pointage (id_pointage, heure_pointage, jour_pointage, id_employe, pointage) VALUES (11, '07:08:32', '2023-11-26', 1001013, true);
INSERT INTO public.pointage (id_pointage, heure_pointage, jour_pointage, id_employe, pointage) VALUES (12, '07:08:57', '2023-11-26', 1001013, false);
INSERT INTO public.pointage (id_pointage, heure_pointage, jour_pointage, id_employe, pointage) VALUES (13, '07:10:19', '2023-11-26', 1001011, true);
INSERT INTO public.pointage (id_pointage, heure_pointage, jour_pointage, id_employe, pointage) VALUES (14, '07:10:48', '2023-11-26', 1001011, false);
INSERT INTO public.pointage (id_pointage, heure_pointage, jour_pointage, id_employe, pointage) VALUES (15, '07:16:42', '2023-11-26', 1001002, true);
INSERT INTO public.pointage (id_pointage, heure_pointage, jour_pointage, id_employe, pointage) VALUES (16, '07:16:55', '2023-11-26', 1001004, true);
INSERT INTO public.pointage (id_pointage, heure_pointage, jour_pointage, id_employe, pointage) VALUES (17, '07:23:57', '2023-11-26', 1001018, true);


--
-- Data for Name: retard; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.retard (id_retard, id_employe, heure, jour) VALUES (3, 1001001, '00:16:20', '2023-11-23');
INSERT INTO public.retard (id_retard, id_employe, heure, jour) VALUES (4, 1001001, '00:18:50', '2023-11-23');
INSERT INTO public.retard (id_retard, id_employe, heure, jour) VALUES (5, 1001001, '00:21:59', '2023-11-23');
INSERT INTO public.retard (id_retard, id_employe, heure, jour) VALUES (6, 1001001, '00:24:58', '2023-11-23');
INSERT INTO public.retard (id_retard, id_employe, heure, jour) VALUES (7, 1001011, '07:10:19', '2023-11-26');
INSERT INTO public.retard (id_retard, id_employe, heure, jour) VALUES (8, 1001002, '07:16:42', '2023-11-26');
INSERT INTO public.retard (id_retard, id_employe, heure, jour) VALUES (9, 1001004, '07:16:55', '2023-11-26');
INSERT INTO public.retard (id_retard, id_employe, heure, jour) VALUES (10, 1001018, '07:23:57', '2023-11-26');


--
-- Data for Name: zone_acces; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.zone_acces (id_zone_acces, niveau_requis, description) VALUES (1, 0, 'Salle de repos des employés');
INSERT INTO public.zone_acces (id_zone_acces, niveau_requis, description) VALUES (2, 2, 'Réserve');
INSERT INTO public.zone_acces (id_zone_acces, niveau_requis, description) VALUES (3, 0, 'Entrée employée');
INSERT INTO public.zone_acces (id_zone_acces, niveau_requis, description) VALUES (4, 3, 'Salle de stockage du matériel informatique');
INSERT INTO public.zone_acces (id_zone_acces, niveau_requis, description) VALUES (5, 3, 'Salle des managers');
INSERT INTO public.zone_acces (id_zone_acces, niveau_requis, description) VALUES (6, 3, 'Salle de stockage produits importants');
INSERT INTO public.zone_acces (id_zone_acces, niveau_requis, description) VALUES (7, 3, 'Salle des serveurs');


--
-- Name: acces_id_acces_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.acces_id_acces_seq', 14, true);


--
-- Name: departement_id_departement_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.departement_id_departement_seq', 1, false);


--
-- Name: horaire_id_horaire_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.horaire_id_horaire_seq', 9, true);


--
-- Name: jobs_id_jobs_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.jobs_id_jobs_seq', 1, false);


--
-- Name: personne_id_personne_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.personne_id_personne_seq', 1020, true);


--
-- Name: pointage_id_pointage_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pointage_id_pointage_seq', 17, true);


--
-- Name: retard_id_retard_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.retard_id_retard_seq', 10, true);


--
-- Name: zone_acces_id_zone_acces_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.zone_acces_id_zone_acces_seq', 7, true);


--
-- Name: acces acces_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acces
    ADD CONSTRAINT acces_pk PRIMARY KEY (id_acces);


--
-- Name: departement departement_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.departement
    ADD CONSTRAINT departement_pk PRIMARY KEY (id_departement);


--
-- Name: employe employe_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employe
    ADD CONSTRAINT employe_pk PRIMARY KEY (id_employe);


--
-- Name: horaire horaire_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.horaire
    ADD CONSTRAINT horaire_pk PRIMARY KEY (id_horaire);


--
-- Name: jobs jobs_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pk PRIMARY KEY (id_jobs);


--
-- Name: manager manager_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manager
    ADD CONSTRAINT manager_pk PRIMARY KEY (id_manager);


--
-- Name: personne personne_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personne
    ADD CONSTRAINT personne_pk PRIMARY KEY (id_personne);


--
-- Name: personne personne_pk2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personne
    ADD CONSTRAINT personne_pk2 UNIQUE (mail);


--
-- Name: personne personne_pk3; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personne
    ADD CONSTRAINT personne_pk3 UNIQUE (telephone);


--
-- Name: pointage pointage_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pointage
    ADD CONSTRAINT pointage_pk PRIMARY KEY (id_pointage);


--
-- Name: retard retard_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.retard
    ADD CONSTRAINT retard_pk PRIMARY KEY (id_retard);


--
-- Name: zone_acces zone_acces_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.zone_acces
    ADD CONSTRAINT zone_acces_pk PRIMARY KEY (id_zone_acces);


--
-- Name: personne id_departement_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personne
    ADD CONSTRAINT id_departement_fk FOREIGN KEY (id_departement) REFERENCES public.departement(id_departement) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: employe id_employe_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employe
    ADD CONSTRAINT id_employe_fk FOREIGN KEY (id_employe) REFERENCES public.personne(id_personne) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: horaire id_employe_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.horaire
    ADD CONSTRAINT id_employe_fk FOREIGN KEY (id_employe) REFERENCES public.employe(id_employe) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: pointage id_employe_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pointage
    ADD CONSTRAINT id_employe_fk FOREIGN KEY (id_employe) REFERENCES public.employe(id_employe) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: retard id_employe_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.retard
    ADD CONSTRAINT id_employe_fk FOREIGN KEY (id_employe) REFERENCES public.employe(id_employe) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: personne id_jobs_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personne
    ADD CONSTRAINT id_jobs_fk FOREIGN KEY (id_jobs) REFERENCES public.jobs(id_jobs) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: manager id_manager_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manager
    ADD CONSTRAINT id_manager_fk FOREIGN KEY (id_manager) REFERENCES public.personne(id_personne) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: acces id_personne_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acces
    ADD CONSTRAINT id_personne_fk FOREIGN KEY (id_personne) REFERENCES public.personne(id_personne) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: acces id_zone_acces_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acces
    ADD CONSTRAINT id_zone_acces_fk FOREIGN KEY (id_zone_acces) REFERENCES public.zone_acces(id_zone_acces);


--
-- PostgreSQL database dump complete
--

