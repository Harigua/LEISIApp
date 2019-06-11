-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  jeu. 21 juin 2018 à 14:20
-- Version du serveur :  5.7.19
-- Version de PHP :  5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `dbpfe`
--

-- --------------------------------------------------------

--
-- Structure de la table `alluquot`
--

DROP TABLE IF EXISTS `alluquot`;
CREATE TABLE IF NOT EXISTS `alluquot` (
  `ID_ALLUQUOT` char(20) NOT NULL,
  `ID_SAMPLE` char(50) NOT NULL,
  `LOGINUSER` char(100) NOT NULL,
  `VOLUME` decimal(5,0) DEFAULT NULL,
  `CONSERVATION_PLACE` char(50) DEFAULT NULL,
  PRIMARY KEY (`ID_ALLUQUOT`),
  KEY `FK_ALLUQUOT_ADDALL_USERDATA` (`LOGINUSER`),
  KEY `FK_ALLUQUOT_GIVE_SAMPLE` (`ID_SAMPLE`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `alluquot`
--

INSERT INTO `alluquot` (`ID_ALLUQUOT`, `ID_SAMPLE`, `LOGINUSER`, `VOLUME`, `CONSERVATION_PLACE`) VALUES
('Alliquot1', '', 'emna', '3', 'R80/2/1-1/1/1');

-- --------------------------------------------------------

--
-- Structure de la table `diognosis`
--

DROP TABLE IF EXISTS `diognosis`;
CREATE TABLE IF NOT EXISTS `diognosis` (
  `IDDIAGNOSIS` char(20) NOT NULL,
  `TEST` char(20) NOT NULL,
  `LABORATORY_NAME` char(20) NOT NULL,
  `ID_SAMPLE` char(50) NOT NULL,
  `DIAGNOSIS_DATE` date DEFAULT NULL,
  `QUANTITE` decimal(5,0) DEFAULT NULL,
  `RESULT` char(10) DEFAULT NULL,
  `LEISHSUSPECT` char(20) DEFAULT NULL,
  PRIMARY KEY (`IDDIAGNOSIS`),
  KEY `FK_DIOGNOSI_ANALYSESA_SAMPLE` (`ID_SAMPLE`),
  KEY `FK_DIOGNOSI_DO_AT_LABORATO` (`LABORATORY_NAME`),
  KEY `FK_DIOGNOSI_USEMOLTES_MOLECULA` (`TEST`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `interrogator`
--

DROP TABLE IF EXISTS `interrogator`;
CREATE TABLE IF NOT EXISTS `interrogator` (
  `ID_INTERROGATOR` char(20) NOT NULL,
  `LOGINUSER` char(100) NOT NULL,
  `FIRST_NAME_INTERROGATOR` char(50) DEFAULT NULL,
  `LAST_NAME_INTERROGATOR` char(20) DEFAULT NULL,
  `QUALITY` char(20) DEFAULT NULL,
  PRIMARY KEY (`ID_INTERROGATOR`),
  KEY `FK_INTERROG_ADDINTER_USERDATA` (`LOGINUSER`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `laboratory`
--

DROP TABLE IF EXISTS `laboratory`;
CREATE TABLE IF NOT EXISTS `laboratory` (
  `LABORATORY_NAME` char(20) NOT NULL,
  `LOGINUSER` char(100) NOT NULL,
  `COUNTRY` char(20) DEFAULT NULL,
  PRIMARY KEY (`LABORATORY_NAME`),
  KEY `FK_LABORATO_ADDDLAB_USERDATA` (`LOGINUSER`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `leishmania_species`
--

DROP TABLE IF EXISTS `leishmania_species`;
CREATE TABLE IF NOT EXISTS `leishmania_species` (
  `SPECIES` char(100) NOT NULL,
  `INFORMATION` char(100) DEFAULT NULL,
  PRIMARY KEY (`SPECIES`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `medical_checkup`
--

DROP TABLE IF EXISTS `medical_checkup`;
CREATE TABLE IF NOT EXISTS `medical_checkup` (
  `ID_MED` char(20) NOT NULL,
  `DATE_MED` date NOT NULL,
  `ID_INTERROGATOR` char(20) NOT NULL,
  `PATIENT_IDENTIFIER` char(50) NOT NULL,
  `LOGINUSER` char(100) NOT NULL,
  `HOSPITAL` char(50) DEFAULT NULL,
  `PHYSICIAN` char(50) DEFAULT NULL,
  `SAMPLER` char(50) DEFAULT NULL,
  `ANIMAL_AROUND` char(200) DEFAULT NULL,
  `POSSIBLE_HUMAN_HOSTS` char(200) DEFAULT NULL,
  `CLINICAL_STATE` mediumtext,
  `LESPOSSS` char(50) DEFAULT NULL,
  `GENDESC` char(200) DEFAULT NULL,
  PRIMARY KEY (`DATE_MED`,`ID_MED`),
  KEY `FK_MEDICAL__ADDCHECK_USERDATA` (`LOGINUSER`),
  KEY `FK_MEDICAL__DO_PATIENT` (`PATIENT_IDENTIFIER`),
  KEY `FK_MEDICAL__INVESTIGA_INTERROG` (`ID_INTERROGATOR`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `medical_checkup`
--

INSERT INTO `medical_checkup` (`ID_MED`, `DATE_MED`, `ID_INTERROGATOR`, `PATIENT_IDENTIFIER`, `LOGINUSER`, `HOSPITAL`, `PHYSICIAN`, `SAMPLER`, `ANIMAL_AROUND`, `POSSIBLE_HUMAN_HOSTS`, `CLINICAL_STATE`, `LESPOSSS`, `GENDESC`) VALUES
('Medical-check1', '2018-06-06', '', 'IPTtest0', 'emna', 'CHU-FHS', 'akila', 'mili', 'Cats, Dogs', 'Friend', 'Diabetes', '04', '');

-- --------------------------------------------------------

--
-- Structure de la table `molecularl_test`
--

DROP TABLE IF EXISTS `molecularl_test`;
CREATE TABLE IF NOT EXISTS `molecularl_test` (
  `TEST` char(20) NOT NULL,
  `LOGINUSER` char(100) NOT NULL,
  `TEST_TYPE` char(20) DEFAULT NULL,
  PRIMARY KEY (`TEST`),
  KEY `FK_MOLECULA_ADDMOLTES_USERDATA` (`LOGINUSER`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `patient`
--

DROP TABLE IF EXISTS `patient`;
CREATE TABLE IF NOT EXISTS `patient` (
  `PATIENT_IDENTIFIER` char(50) NOT NULL,
  `LOGINUSER` char(100) NOT NULL,
  `MEDICAL_FILE_NUMBER` char(50) DEFAULT NULL,
  `FIRST_NAME` char(20) DEFAULT NULL,
  `LAST_NAME` char(20) DEFAULT NULL,
  `BIRTH_DATE` date DEFAULT NULL,
  `NATIONALITY` char(3) DEFAULT NULL,
  `GENDER` char(10) DEFAULT NULL,
  `CONSENT` char(3) DEFAULT NULL,
  `PHONE_NUMBER` int(11) DEFAULT NULL,
  PRIMARY KEY (`PATIENT_IDENTIFIER`),
  KEY `FK_PATIENT_ADDPATT_USERDATA` (`LOGINUSER`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `patient`
--

INSERT INTO `patient` (`PATIENT_IDENTIFIER`, `LOGINUSER`, `MEDICAL_FILE_NUMBER`, `FIRST_NAME`, `LAST_NAME`, `BIRTH_DATE`, `NATIONALITY`, `GENDER`, `CONSENT`, `PHONE_NUMBER`) VALUES
('IPTtest0', 'emna', '0000', '', '', '2011-06-06', 'TUN', 'Male', 'Yes', 1250222);

-- --------------------------------------------------------

--
-- Structure de la table `region`
--

DROP TABLE IF EXISTS `region`;
CREATE TABLE IF NOT EXISTS `region` (
  `CITY` char(20) NOT NULL,
  `COUNTRY_` char(20) DEFAULT NULL,
  `GOVERNORATE` char(20) DEFAULT NULL,
  PRIMARY KEY (`CITY`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `sample`
--

DROP TABLE IF EXISTS `sample`;
CREATE TABLE IF NOT EXISTS `sample` (
  `ID_SAMPLE` char(50) NOT NULL,
  `PATIENT_IDENTIFIER` char(50) NOT NULL,
  `SPECIES` char(100) NOT NULL,
  `LOGINUSER` char(100) NOT NULL,
  `LESION_SITE_SAMPLED` char(20) DEFAULT NULL,
  `SAMPLING_METHOD` char(20) DEFAULT NULL,
  `TYPE_OF_SAMPLE_SUPPORT_` char(20) DEFAULT NULL,
  `DIRECT_EXAMINATION` char(20) DEFAULT NULL,
  `ABUDANCE_ON_THE_SMEAR` char(6) DEFAULT NULL,
  `LESION_AGE` date DEFAULT NULL,
  `DIAMETRE` int(11) DEFAULT NULL,
  `LOCALISATION` smallint(6) DEFAULT NULL,
  `DESCRIPTION` mediumtext,
  `DATE_EXTRACTION` date DEFAULT NULL,
  PRIMARY KEY (`ID_SAMPLE`),
  KEY `FK_SAMPLE_ADDSAMPL_USERDATA` (`LOGINUSER`),
  KEY `FK_SAMPLE_CONTAIN_LEISHMAN` (`SPECIES`),
  KEY `FK_SAMPLE_EXTRACT_PATIENT` (`PATIENT_IDENTIFIER`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `sample`
--

INSERT INTO `sample` (`ID_SAMPLE`, `PATIENT_IDENTIFIER`, `SPECIES`, `LOGINUSER`, `LESION_SITE_SAMPLED`, `SAMPLING_METHOD`, `TYPE_OF_SAMPLE_SUPPORT_`, `DIRECT_EXAMINATION`, `ABUDANCE_ON_THE_SMEAR`, `LESION_AGE`, `DIAMETRE`, `LOCALISATION`, `DESCRIPTION`, `DATE_EXTRACTION`) VALUES
('Sampletaken1', 'IPTtest0', 'Not Identified', 'emna', '', 'Scrapping', 'Scrapping', 'Positive', '+++', '2018-06-06', 3, 39, 'Pseudotumoral, Ulcerative crusty', '2018-06-06');

-- --------------------------------------------------------

--
-- Structure de la table `travel_residency`
--

DROP TABLE IF EXISTS `travel_residency`;
CREATE TABLE IF NOT EXISTS `travel_residency` (
  `IDMVT` char(20) NOT NULL,
  `CITY` char(20) NOT NULL,
  `PATIENT_IDENTIFIER` char(50) NOT NULL,
  `FROMDATE` date DEFAULT NULL,
  `TODATE` date DEFAULT NULL,
  `BYTENOT` char(15) DEFAULT NULL,
  `RESIDENCY` char(10) DEFAULT NULL,
  PRIMARY KEY (`IDMVT`),
  KEY `FK_TRAVEL_R_TRAVEL_PATIENT` (`PATIENT_IDENTIFIER`),
  KEY `FK_TRAVEL_R_VISIT_REGION` (`CITY`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `treatment`
--

DROP TABLE IF EXISTS `treatment`;
CREATE TABLE IF NOT EXISTS `treatment` (
  `TREATMENT_TYPE` char(20) NOT NULL,
  `LOGINUSER` char(100) NOT NULL,
  PRIMARY KEY (`TREATMENT_TYPE`),
  KEY `FK_TREATMEN_ADDDTREAT_USERDATA` (`LOGINUSER`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `treatmenthistory`
--

DROP TABLE IF EXISTS `treatmenthistory`;
CREATE TABLE IF NOT EXISTS `treatmenthistory` (
  `IDTREATMENT` char(40) NOT NULL,
  `PATIENT_IDENTIFIER` char(50) NOT NULL,
  `TREATMENT_TYPE` char(20) NOT NULL,
  `PRESCRIBEDFOR` char(20) DEFAULT NULL,
  `START_DATE` date DEFAULT NULL,
  `POSOLOGY` char(100) DEFAULT NULL,
  `ADMINROUTE` char(100) DEFAULT NULL,
  `INJECTION_NUMBER` int(11) DEFAULT NULL,
  `DURATIONN` char(20) DEFAULT NULL,
  `HEALING_DATE` char(50) DEFAULT NULL,
  PRIMARY KEY (`IDTREATMENT`),
  KEY `FK_TREATMEN_ADDTREATM_PATIENT` (`PATIENT_IDENTIFIER`),
  KEY `FK_TREATMEN_USETREATM_TREATMEN` (`TREATMENT_TYPE`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `treatmenthistory`
--

INSERT INTO `treatmenthistory` (`IDTREATMENT`, `PATIENT_IDENTIFIER`, `TREATMENT_TYPE`, `PRESCRIBEDFOR`, `START_DATE`, `POSOLOGY`, `ADMINROUTE`, `INJECTION_NUMBER`, `DURATIONN`, `HEALING_DATE`) VALUES
('Treatment1', 'IPTtest0', 'Antibiotics', 'Leishmania', '2018-06-06', '5', 'iv', 3, '2', '2018-06-06');

-- --------------------------------------------------------

--
-- Structure de la table `userdata`
--

DROP TABLE IF EXISTS `userdata`;
CREATE TABLE IF NOT EXISTS `userdata` (
  `LOGINUSER` char(100) NOT NULL,
  `USE_LOGINUSER` char(100) NOT NULL,
  `MOTDPASS` char(100) DEFAULT NULL,
  `LEVELSECURE` char(10) DEFAULT NULL,
  `FROMINST` char(100) DEFAULT NULL,
  PRIMARY KEY (`LOGINUSER`),
  KEY `FK_USERDATA_CREATER_USERDATA` (`USE_LOGINUSER`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `userdata`
--

INSERT INTO `userdata` (`LOGINUSER`, `USE_LOGINUSER`, `MOTDPASS`, `LEVELSECURE`, `FROMINST`) VALUES
('super', 'super', '16souleis', 'super', 'IPT'),
('emna', 'super', '16souemna', 'normal', 'IPT');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
