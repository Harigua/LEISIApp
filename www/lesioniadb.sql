-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Mar 17 Octobre 2017 à 05:30
-- Version du serveur :  5.6.17
-- Version de PHP :  5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `lesioniadb`
--

-- --------------------------------------------------------

--
-- Structure de la table `alluquot`
--

CREATE TABLE IF NOT EXISTS `alluquot` (
  `ID_ALLUQUOT` char(20) NOT NULL,
  `ID_SAMPLE` char(50) NOT NULL,
  `LOGIN` char(100) NOT NULL,
  `VOLUME` decimal(5,0) DEFAULT NULL,
  `CONSERVATION_PLACE` char(50) DEFAULT NULL,
  PRIMARY KEY (`ID_ALLUQUOT`),
  KEY `FK_ALLUQUOT_ADDALL_USER` (`LOGIN`),
  KEY `FK_ALLUQUOT_GIVE_SAMPLE` (`ID_SAMPLE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `alluquot`
--

INSERT INTO `alluquot` (`ID_ALLUQUOT`, `ID_SAMPLE`, `LOGIN`, `VOLUME`, `CONSERVATION_PLACE`) VALUES
('Alliquot1', 'JKKLNLKN', 'super', '200', 'gF10'),
('Alliquot2', 'JKKLNLKN', 'super', '300', 'GL11');

-- --------------------------------------------------------

--
-- Structure de la table `diognosis`
--

CREATE TABLE IF NOT EXISTS `diognosis` (
  `TEST` char(20) NOT NULL,
  `LABORATORY_NAME` char(20) NOT NULL,
  `ID_SAMPLE` char(50) NOT NULL,
  `DIAGNOSIS_DATE` date DEFAULT NULL,
  `QUANTITE` decimal(5,0) DEFAULT NULL,
  `RESULT` char(10) DEFAULT NULL,
  `LEISHSUSPECT` char(20) DEFAULT NULL,
  PRIMARY KEY (`TEST`,`LABORATORY_NAME`,`ID_SAMPLE`),
  KEY `FK_DIOGNOSI_DIOGNOSIS_SAMPLE` (`ID_SAMPLE`),
  KEY `FK_DIOGNOSI_DIOGNOSIS_LABORATO` (`LABORATORY_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `diognosis`
--

INSERT INTO `diognosis` (`TEST`, `LABORATORY_NAME`, `ID_SAMPLE`, `DIAGNOSIS_DATE`, `QUANTITE`, `RESULT`, `LEISHSUSPECT`) VALUES
('Direct Examination', 'CHU', 'SAMPLE2', '1999-11-03', '10', '+', NULL),
('Direct Examination', 'CHU', 'SAMPLE6', '2016-10-18', '20', '+', 'MAJOR'),
('PA-LF', 'CHU', 'SAMPLE12', '2016-10-27', NULL, '+', 'MAJOR'),
('PA-LF', 'CHU', 'SAMPLE2', '2017-11-14', '12', '+', NULL),
('PA-LF', 'CHU', 'SAMPLE26', '2016-12-12', '23', '+', 'TROPICA'),
('PA-LF', 'CHU', 'SAMPLE2é', '2016-10-04', '45', '+', 'INFANTUM'),
('PA-LF', 'CHU', 'SAMPLE7', '2017-10-16', '0', '', ''),
('PA-LF', 'CHU', 'SAMPLE9', '2017-02-15', '10', '+', 'MAJOR'),
('PCR', 'CHU', 'SAMPLE6', '2016-07-12', '13', '+', 'MAJOR'),
('PCR ITS', 'CHU', 'SAMPLE1', '2017-08-09', '12', '+', 'INFANTUM'),
('PCR ITS', 'CHU', 'SAMPLE10', '2016-08-16', '15', '+', 'TROPICA'),
('PCR ITS', 'CHU', 'SAMPLE13', '2017-08-01', '40', '+', 'INFANTUM'),
('PCR ITS', 'CHU', 'SAMPLE14', '2017-08-13', '40', '+', 'INFANTUM'),
('PCR ITS', 'CHU', 'SAMPLE16', '2016-10-19', '10', '+', 'TROPICA'),
('PCR ITS', 'CHU', 'SAMPLE18', '2016-12-12', '10', '+', 'TROPICA'),
('PCR ITS', 'CHU', 'SAMPLE21', '2017-02-06', '12', '+', 'INFANTUM'),
('PCR ITS', 'CHU', 'SAMPLE4', '2017-08-09', '13', '+', 'MAJOR'),
('PCR ITS', 'CHU', 'SAMPLE7', '2016-07-19', '20', '+', 'MAJOR'),
('PCR ITS', 'CHU', 'SAMPLE8', '2017-01-08', '13', '+', 'MAJOR'),
('qPCR', 'CHU', 'JKKLNLKN', '2017-01-15', '20', '+', 'TROPICA'),
('qPCR', 'CHU', 'SAMPLE11', NULL, NULL, '+', 'TROPICA'),
('qPCR', 'CHU', 'SAMPLE15', NULL, '10', '+', 'TROPICA'),
('qPCR', 'CHU', 'SAMPLE20', '2017-08-14', NULL, '+', 'MAJOR'),
('qPCR', 'CHU', 'SAMPLE24', '2016-12-21', '12', '+', 'MAJOR'),
('qPCR', 'CHU', 'SAMPLE25', '2016-11-06', '40', '+', 'INFANTUM'),
('qPCR', 'CHU', 'SAMPLE27', '2016-12-12', '21', '+', 'MAJOR'),
('qPCR', 'CHU', 'SAMPLE3', '2016-01-22', '10', '+', 'MAJOR'),
('qPCR', 'CHU', 'SAMPLE5', '2017-03-13', '14', '+', 'MAJOR');

-- --------------------------------------------------------

--
-- Structure de la table `interrogator`
--

CREATE TABLE IF NOT EXISTS `interrogator` (
  `ID_INTERROGATOR` char(20) NOT NULL,
  `LOGIN` char(100) NOT NULL,
  `FIRST_NAME_INTERROGATOR` char(50) DEFAULT NULL,
  `LAST_NAME_INTERROGATOR` char(20) DEFAULT NULL,
  `QUALITY` char(20) DEFAULT NULL,
  PRIMARY KEY (`ID_INTERROGATOR`),
  KEY `FK_INTERROG_ADDINTER_USER` (`LOGIN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `interrogator`
--

INSERT INTO `interrogator` (`ID_INTERROGATOR`, `LOGIN`, `FIRST_NAME_INTERROGATOR`, `LAST_NAME_INTERROGATOR`, `QUALITY`) VALUES
('11111111', 'super', 'Ali', 'Boubaker', 'Doctor'),
('22222222', 'normal', 'Fatima', 'Fridhi', 'nurse');

-- --------------------------------------------------------

--
-- Structure de la table `laboratory`
--

CREATE TABLE IF NOT EXISTS `laboratory` (
  `LABORATORY_NAME` char(20) NOT NULL,
  `LOGIN` char(100) NOT NULL,
  `COUNTRY` char(20) DEFAULT NULL,
  PRIMARY KEY (`LABORATORY_NAME`),
  KEY `FK_LABORATO_ADDDLAB_USER` (`LOGIN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `laboratory`
--

INSERT INTO `laboratory` (`LABORATORY_NAME`, `LOGIN`, `COUNTRY`) VALUES
('CHU', 'super', 'Tunisia');

-- --------------------------------------------------------

--
-- Structure de la table `leishmania_species`
--

CREATE TABLE IF NOT EXISTS `leishmania_species` (
  `SPECIES` char(100) NOT NULL,
  `INFORMATION` char(100) DEFAULT NULL,
  PRIMARY KEY (`SPECIES`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `leishmania_species`
--

INSERT INTO `leishmania_species` (`SPECIES`, `INFORMATION`) VALUES
('.Major', NULL),
('Inconnu', NULL),
('L.Infantum', NULL),
('L.Tropica', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `medical_checkup`
--

CREATE TABLE IF NOT EXISTS `medical_checkup` (
  `ID_MED` char(20) NOT NULL,
  `DATE_MED` date NOT NULL,
  `ID_INTERROGATOR` char(20) NOT NULL,
  `PATIENT_IDENTIFIER` char(50) NOT NULL,
  `LOGIN` char(100) NOT NULL,
  `HOSPITAL` char(50) DEFAULT NULL,
  `PHYSICIAN` char(50) DEFAULT NULL,
  `SAMPLER` char(50) DEFAULT NULL,
  `ANIMAL_AROUND` char(200) DEFAULT NULL,
  `POSSIBLE_HUMAN_HOSTS` char(200) DEFAULT NULL,
  `CLINICAL_STATE` char(100) DEFAULT NULL,
  `LESPOSSS` char(50) DEFAULT NULL,
  `GENDESC` char(200) DEFAULT NULL,
  PRIMARY KEY (`DATE_MED`,`ID_MED`),
  KEY `FK_MEDICAL__ADDCHECK_USER` (`LOGIN`),
  KEY `FK_MEDICAL__DO_PATIENT` (`PATIENT_IDENTIFIER`),
  KEY `FK_MEDICAL__INVESTIGA_INTERROG` (`ID_INTERROGATOR`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `medical_checkup`
--

INSERT INTO `medical_checkup` (`ID_MED`, `DATE_MED`, `ID_INTERROGATOR`, `PATIENT_IDENTIFIER`, `LOGIN`, `HOSPITAL`, `PHYSICIAN`, `SAMPLER`, `ANIMAL_AROUND`, `POSSIBLE_HUMAN_HOSTS`, `CLINICAL_STATE`, `LESPOSSS`, `GENDESC`) VALUES
('96547852', '2016-01-21', '11111111', 'TNCHU888', 'normal', 'CHU', 'KIILER', 'JIN', 'DOGS', 'FAMILY', 'HIGH BLOOD PRESSURE', '40,7', NULL),
('1236', '2016-01-25', '11111111', 'TNCHU00316', 'normal', 'CHU', 'CHJ', 'JUL', 'DOGS,RODENTS', 'HOUSEHOLD', 'HIGH BLOOD PRESSURE', '5,6,4', 'BIG'),
('HJ452', '2016-02-06', '11111111', 'TN4578', 'normal', 'CHU', 'J.R', 'H.A', 'DOGS', 'FAMILY', 'NtR', '10', NULL),
('0562', '2016-02-15', '22222222', 'TNCHU001/02', 'normal', 'CHU', 'ALI', 'ALI', 'RODENTS,CATS', 'NEIGHBOR', 'HIGH BLOOD PRESSURE', '5,40,13', 'WET'),
('01364', '2016-02-28', '11111111', 'TNCHU05002', 'normal', 'CHU', 'CHU', 'ALI', 'RODENTS', 'FAMILY', 'HIGH BLOOD PRESSURE', '40,42', 'BIG'),
('JKHBHKJ', '2016-03-18', '11111111', 'TN', 'normal', 'CHU', 'KIL', 'MUY', 'DOGS', 'FAMILY', 'NtR', '6,7,13', NULL),
('JKGYUJ', '2016-03-27', '11111111', 'TNCHU010', 'normal', 'CHU', 'HIL', 'LIN', 'DOGS,CATS', 'FAMILY', 'NtR', '3,4', NULL),
('HRDRH', '2016-04-04', '11111111', 'TNCHU9991', 'normal', 'CHU', 'JHTF', 'FDSGD', 'DOGS', 'FRIEND', 'ALLERGY', '9,10,10', NULL),
('KHGLKLL', '2016-04-20', '22222222', 'TNCHU999', 'normal', 'CHU', 'JILL', 'LAM', 'DOGS', 'COLLEAGUE', 'DIABETES', '30,3', NULL),
('YFUFUU', '2016-05-13', '11111111', 'TNCHU00000000LYGUH', 'normal', 'UIUI', 'KULI', 'LHI', 'CATS', 'FAMILY', 'NtR', '26,25', NULL),
('MIUHO', '2016-05-19', '11111111', 'TNYYY5846HGJ', 'normal', 'CHU', 'KLKULMI', 'ILOO', 'DOGS', 'FAMILY', 'NtR', '1,2,5,7', NULL),
('KYFFYH', '2016-05-23', '11111111', 'TNYYY111', 'normal', 'YYY', 'JKLI', 'KJH', 'DOGS', 'HOUSEHOLDS', 'NtR', '3,4,16', NULL),
('kjd52', '2016-06-22', '11111111', 'TNCHU000002222', 'normal', 'CHU', 'K;L', 'L.D', 'NONE', 'COLLEAGUE', 'NtR', '10,33', NULL),
('THCTYJBKN', '2016-06-22', '22222222', 'TNCHU000011111KJGJ', 'normal', 'GHJ', 'GK', 'JNK', 'OVINS', 'FAMILY', 'NtR', '30,34', NULL),
('LKNKJNJIN', '2016-07-22', '11111111', 'TNYYY07052', 'normal', 'HJL', 'JL', 'H', 'RODENTS', 'NEIGHBOR', 'NtR', '25,26,16,10,1,7', NULL),
('NCLLLDL', '2016-08-11', '11111111', 'TNYYY00000000008', 'normal', NULL, NULL, NULL, 'DOGS', 'FAMILY', 'NtR', '30', NULL),
('KBHH', '2016-08-14', '22222222', 'TNCHU080547', 'normal', 'KLNIN', 'KBJ/K', 'NLN', 'HARES', 'HOUSEHOLD', 'NtR', '28', NULL),
('DDUJUH', '2016-08-17', '11111111', 'TNYYY000000000084', 'normal', 'L.MM', 'NKL', 'LNL', 'RODENTS', 'FRIEND', 'NtR', '9', NULL),
('JHVD', '2016-09-05', '11111111', 'TNCHU091', 'normal', 'YYY', 'YYYTKKJB', 'KJ', 'RODENTS', 'HOUSEHOLD', 'NtR', '3', NULL),
('HJUF52', '2016-09-13', '22222222', 'TNYYY09066', 'normal', 'CHU', 'J.L', 'M.P', 'RODENTS', 'FRIEND', 'NtR', '15,16,13', NULL),
('HJU52', '2016-09-15', '11111111', 'TNCHU09077', 'normal', 'CHU', 'K.M', 'L.HK', 'HARES', 'FAMILY', 'NtR', '33', NULL),
('GH521', '2016-09-20', '11111111', 'TNCHU09077', 'normal', 'CHU', 'K.L', 'H.L', 'CATS', 'FRIEND', 'NtR', '27', NULL),
('GJGJ', '2016-09-21', '22222222', 'TNCHU090517', 'normal', 'CHU', 'KFI', 'K.J', 'RODENTS', 'NEIGHBOR', 'NtR', '22', NULL),
('GFHHG4K', '2016-10-10', '11111111', 'TNCHU0101111116', 'normal', 'CHU', 'J.L', 'Y.M', 'RODENTS', 'FAMILY', 'NtR', '9', NULL),
('GH852', '2016-10-10', '22222222', 'TNCHU01011119', 'normal', 'CHU', 'B.L', 'J.L', 'NONE', 'NONE', 'NtR', '3', NULL),
('H41K', '2016-10-11', '22222222', 'TNCHU01011111122', 'normal', 'CHU', 'H.M', 'F.P', 'NONE', 'NONE', 'NtR', '40', NULL),
('LKJ45', '2016-10-13', '11111111', 'TNCHU01011111117', 'normal', 'CHU', 'J.M', 'S.L', 'RODENTS', 'NONE', 'NtR', '15', NULL),
('KLJ76', '2016-10-16', '11111111', 'TNCHU01011111112', 'normal', 'CHU', 'K.L', 'L.M', 'FOXES', 'FAMILY', 'NtR', '7', NULL),
('HJB41', '2016-10-23', '11111111', 'TNCHU01011118', 'normal', 'CHU', 'J.L', 'M.L', 'DOGS', 'NONE', 'NtR', '14', NULL),
('YTJ85HGHCC', '2016-10-23', '11111111', 'tnchu010111111111111111', 'normal', 'CHU', 'H.L', 'G.P', 'CATS', 'HOUSEHOLD', 'NtR', '1', NULL),
('GHGN42', '2016-10-28', '22222222', 'TNCHU011111113', 'normal', 'CHIU', 'J.L', 'O.M', 'CATS', 'FAMILY', 'NtR', '10', NULL),
('JK71KL', '2016-10-30', '11111111', 'TNCHU01011111117', 'normal', 'CHU', 'H.M', 'F.M', 'NONE', 'NONE', 'NtR', '5', NULL),
('KL71J', '2016-11-01', '22222222', 'TNCHUL111', 'normal', 'CHU', 'L.K', 'B.L', 'NONE', 'NONE', 'NtR', '4', NULL),
('987415', '2016-11-16', '11111111', 'TNCHU777', 'normal', 'CHU', 'JINY', 'LAURA', 'DOGS', 'FAMILY', 'NtR', '5,40', NULL),
('YRSRDKF', '2016-11-17', '11111111', 'TNCHUOMJ', 'normal', NULL, NULL, NULL, 'CATS', 'FAMILY', 'DIABETES', '3,7', NULL),
('JKN426', '2016-11-19', '11111111', 'TNCHUL112', 'normal', 'CHU', 'J.K', 'G.N', 'NONE', 'NONE', 'NtR', '5', NULL),
('9999', '2016-12-18', '11111111', 'TNCHU666', 'normal', 'CHU', 'CHU', 'JILL', 'DOGS', 'FAMILY', 'HIGH BLOOD PRESSURE', '4,7,16', NULL),
('jk412', '2016-12-18', '11111111', 'TNCHU01011111112', 'normal', 'CHU', 'H.M', 'S.L', 'DOGS', 'NONE', 'NtR', '4', NULL),
('1247', '2016-12-19', '22222222', 'TNCHU555', 'normal', 'CHU', 'NINA', 'KILLY', 'DOGS,RODENTS', 'FAMILY', 'HIGH BLOOD PRESSURE', '5,6', 'DRY');

-- --------------------------------------------------------

--
-- Structure de la table `molecularl_test`
--

CREATE TABLE IF NOT EXISTS `molecularl_test` (
  `TEST` char(20) NOT NULL,
  `LOGIN` char(100) NOT NULL,
  `TEST_TYPE` char(20) DEFAULT NULL,
  PRIMARY KEY (`TEST`),
  KEY `FK_MOLECULA_ADDMOLTES_USER` (`LOGIN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `molecularl_test`
--

INSERT INTO `molecularl_test` (`TEST`, `LOGIN`, `TEST_TYPE`) VALUES
('Direct Examination', 'super', 'Existence'),
('PA-LF', 'super', 'Identification'),
('PCR', 'super', 'Existence'),
('PCR ITS', 'super', 'Identification'),
('qPCR', 'super', 'Identification');

-- --------------------------------------------------------

--
-- Structure de la table `patient`
--

CREATE TABLE IF NOT EXISTS `patient` (
  `PATIENT_IDENTIFIER` char(50) NOT NULL,
  `LOGIN` char(100) NOT NULL,
  `MEDICAL_FILE_NUMBER` int(11) DEFAULT NULL,
  `FIRST_NAME` char(20) DEFAULT NULL,
  `LAST_NAME` char(20) DEFAULT NULL,
  `BIRTH_DATE` date DEFAULT NULL,
  `NATIONALITY` char(3) DEFAULT NULL,
  `GENDER` char(10) DEFAULT NULL,
  `CONSENT` char(3) DEFAULT NULL,
  `PHONE_NUMBER` int(11) DEFAULT NULL,
  PRIMARY KEY (`PATIENT_IDENTIFIER`),
  KEY `FK_PATIENT_ADDPATT_USER` (`LOGIN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `patient`
--

INSERT INTO `patient` (`PATIENT_IDENTIFIER`, `LOGIN`, `MEDICAL_FILE_NUMBER`, `FIRST_NAME`, `LAST_NAME`, `BIRTH_DATE`, `NATIONALITY`, `GENDER`, `CONSENT`, `PHONE_NUMBER`) VALUES
('TN', 'normal', 3016, 'JIL', 'LIN', '1995-06-12', 'TUN', 'FEMALE', 'YES', NULL),
('TN4578', 'normal', 423971, 'K.L', 'M.D', '2016-08-15', 'TUN', 'MALE', 'YES', NULL),
('TNCHU00000000LYGUH', 'normal', 50749, 'HTYJ', 'TJYFG', '1975-08-01', 'LIB', 'MALE', 'YES', NULL),
('TNCHU000002222', 'normal', 60340, 'JYUG', 'HJYY', '1995-09-23', 'TUN', 'FEMALE', 'YES', NULL),
('TNCHU000011111KJGJ', 'normal', 608746, 'FDWGB', 'NHVGVJ', '1997-11-13', 'TUN', 'FEMALE', 'YES', NULL),
('TNCHU001/02', 'normal', 102, 'ALI', 'ALI', '1990-05-16', 'TUN', 'MALE', 'NO', 11223322),
('TNCHU00316', 'normal', 316, 'ALI', 'ALI', '1993-05-06', 'TUN', 'MALE', 'YES', 44552211),
('TNCHU010', 'normal', 3017, 'HILL', 'PAN', '1993-06-16', 'TUN', 'FEMALE', 'YES', 11442237),
('TNCHU01011111111110', 'normal', 10548, 'H.L', 'H.N', '1995-12-15', 'TUN', 'FEMALE', 'YES', NULL),
('tnchu010111111111111111', 'normal', 10864, 'kj', 'lk', '2011-01-01', 'TUN', 'FEMALE', 'YES', NULL),
('TNCHU01011111112', 'normal', 10562, 'JH', 'JV', '2010-09-20', 'TUN', 'MALE', 'YES', NULL),
('TNCHU01011111117', 'normal', 10579346, 'H.M', 'I.M', '2016-10-01', 'TUN', 'MALE', 'YES', NULL),
('TNCHU01011111122', 'normal', 105482, 'K.L', 'F.N', '2007-09-20', 'TUN', 'MALE', 'YES', NULL),
('TNCHU0101111116', 'normal', 103485, 'H.L', 'K.M', '2012-07-16', 'TUN', 'FEMALE', 'YES', NULL),
('TNCHU01011118', 'normal', 10142, 'H.L', 'S.H', '1997-09-11', 'TUN', 'FEMALE', 'YES', NULL),
('TNCHU01011119', 'normal', 1054, 'J.L', 'P.M', '2012-09-11', 'TUN', 'FEMALE', 'YES', NULL),
('TNCHU0102643', 'normal', 10346827, 'H.L', 'O.L', '2000-09-18', 'TUN', 'FEMALE', 'YES', NULL),
('TNCHU011111113', 'normal', 102546, 'H.L', 'P.M', '2005-11-17', 'TUN', 'MALE', 'YES', NULL),
('TNCHU05002', 'normal', 5002, 'ALI', 'ALI', '1999-03-25', 'TUN', 'MALE', 'YES', 56232525),
('TNCHU080547', 'normal', 80584, 'VJK', 'UGL', '1999-08-10', 'TUN', 'MALE', 'YES', NULL),
('TNCHU09024', 'normal', 9024, 'H.L', 'U.M', '2004-08-15', 'TUN', 'FEMALE', 'YES', NULL),
('TNCHU090517', 'normal', 90517, 'NIL', 'JIN', '2005-08-08', 'TUN', 'MALE', 'YES', NULL),
('TNCHU09077', 'normal', 9077, 'J.J', 'L.M', '2010-08-07', 'TUN', 'MALE', 'YES', NULL),
('TNCHU091', 'normal', 905, 'JKN.K', 'LIN', '2010-08-08', 'TUN', 'FEMALE', 'YES', NULL),
('TNCHU555', 'normal', 816, 'ALI', 'BILL', '1986-09-23', 'TUN', 'MALE', 'NO', 44113366),
('TNCHU666', 'normal', 216, 'JILL', 'DINA', '2001-03-13', 'TUN', 'MALE', 'YES', 52254566),
('TNCHU777', 'normal', 116, 'JIN', 'KILLY', '2010-05-21', 'TUN', 'MALE', 'YES', 4558877),
('TNCHU888', 'normal', 416, 'LIL', 'TOM', '1949-07-17', 'TUN', 'FEMALE', 'YES', NULL),
('TNCHU999', 'normal', 40782, 'HIL', 'KIL', '1970-06-16', 'TUN', 'MALE', 'YES', NULL),
('TNCHU9991', 'normal', 4067, 'JYG', 'HRDT', '1998-04-16', 'TUN', 'FEMALE', 'YES', 22554411),
('TNCHUL111', 'normal', 11964, 'J.M', 'L.N', '2009-09-13', 'TUN', 'MALE', 'YES', NULL),
('TNCHUL112', 'normal', 11846, 'J.L', 'M.K', '2010-09-29', 'TUN', 'MALE', 'YES', NULL),
('TNCHUOMJ', 'normal', 40981, 'KLJB', 'LBI', '2009-04-17', 'TUN', 'FEMALE', 'YES', NULL),
('TNYYY00000000008', 'normal', 8027, 'JH', 'LIOH', '1985-08-15', 'TUN', 'MALE', 'YES', NULL),
('TNYYY000000000084', 'normal', 8095, 'JKOLIN', 'JKN', '1967-08-07', 'TUN', 'MALE', 'YES', NULL),
('TNYYY07052', 'normal', 7052, 'KHJ', 'LK', '1967-08-23', 'LIB', 'MALE', 'YES', NULL),
('TNYYY09066', 'normal', 9066, 'K.L', 'L.L', '2001-08-16', 'TUN', 'MALE', 'YES', NULL),
('TNYYY111', 'normal', 5111, 'JHV', 'NHT', '2004-09-13', 'TUN', 'FEMALE', 'YES', NULL),
('TNYYY5846HGJ', 'normal', 50562, 'GFF', 'HG', '1940-06-06', 'TUN', 'MALE', 'YES', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `region`
--

CREATE TABLE IF NOT EXISTS `region` (
  `CITY` char(20) NOT NULL,
  `COUNTRY_` char(20) DEFAULT NULL,
  `GOVERNORATE` char(20) DEFAULT NULL,
  `LONGITUDE` decimal(15,0) DEFAULT NULL,
  `LATTITUDE` decimal(15,0) DEFAULT NULL,
  PRIMARY KEY (`CITY`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `region`
--

INSERT INTO `region` (`CITY`, `COUNTRY_`, `GOVERNORATE`, `LONGITUDE`, `LATTITUDE`) VALUES
('Mahdia', 'Tunisia', 'Mahdia', NULL, NULL),
('Paris', 'France', 'Paris', NULL, NULL),
('Sousse', 'Tunisia', 'Sousse', '112233', '52648'),
('TATAOUINE', 'Tunisia', 'TATAOUINE', NULL, NULL),
('Tunis', 'Tunisia', 'Tunis', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `sample`
--

CREATE TABLE IF NOT EXISTS `sample` (
  `ID_SAMPLE` char(50) NOT NULL,
  `PATIENT_IDENTIFIER` char(50) NOT NULL,
  `SPECIES` char(100) NOT NULL,
  `LOGIN` char(100) NOT NULL,
  `LESION_SITE_SAMPLED` char(20) DEFAULT NULL,
  `SAMPLING_METHOD` char(20) DEFAULT NULL,
  `TYPE_OF_SAMPLE_SUPPORT_` char(20) DEFAULT NULL,
  `DIRECT_EXAMINATION` char(20) DEFAULT NULL,
  `ABUDANCE_ON_THE_SMEAR` char(6) DEFAULT NULL,
  `LESION_AGE` date DEFAULT NULL,
  `DIAMETRE` int(11) DEFAULT NULL,
  `LOCALISATION` char(6) DEFAULT NULL,
  `DESCRIPTION` mediumtext,
  PRIMARY KEY (`ID_SAMPLE`),
  KEY `FK_SAMPLE_ADDSAMPL_USER` (`LOGIN`),
  KEY `FK_SAMPLE_CONTAIN_LEISHMAN` (`SPECIES`),
  KEY `FK_SAMPLE_EXTRACT_PATIENT` (`PATIENT_IDENTIFIER`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `sample`
--

INSERT INTO `sample` (`ID_SAMPLE`, `PATIENT_IDENTIFIER`, `SPECIES`, `LOGIN`, `LESION_SITE_SAMPLED`, `SAMPLING_METHOD`, `TYPE_OF_SAMPLE_SUPPORT_`, `DIRECT_EXAMINATION`, `ABUDANCE_ON_THE_SMEAR`, `LESION_AGE`, `DIAMETRE`, `LOCALISATION`, `DESCRIPTION`) VALUES
('JKKLNLKN', 'TNYYY000000000084', 'L.Tropica', 'normal', 'BODY', 'SCRAPPING', 'SALINE', '+', '++', '2017-07-30', 0, '9', 'WET'),
('SAMPLE1', 'TNCHU05002', 'L.Infantum', 'normal', 'FACE', 'SWAB', 'SALINE', '+', '++', '2016-01-29', 1, '42', 'WET,INFECTED'),
('SAMPLE10', 'TNCHU999', 'L.Tropica', 'normal', 'BODY', 'BIOPSY', 'SALINE', '+', '+++', '2016-02-28', 0, '30', 'PSEUDOTUMORAL'),
('SAMPLE11', 'TNCHU9991', 'L.Tropica', 'normal', 'BODY', 'SCRAPPING', 'SALINE', '+', '++++++', '2016-03-01', 2, '9', 'PSEUDOTUMORAL'),
('SAMPLE12', 'TNCHUOMJ', '.Major', 'normal', 'ARMS', 'SCRAPPING', 'SALINE', '+', '++++++', '2016-03-15', 2, '3', 'DRY'),
('SAMPLE13', 'TNYYY111', 'L.Infantum', 'normal', 'LEGS', 'SCRAPPING', 'TE', '+', '++++++', '2016-04-01', 8, '16', 'PSEUDOTUMORAL'),
('SAMPLE14', 'TNYYY5846HGJ', 'L.Infantum', 'normal', 'BODY', 'SCRAPPING', 'SALINE', '+', '++++++', '2016-04-20', 7, '5', 'WET'),
('SAMPLE15', 'TNCHU00000000LYGUH', 'L.Tropica', 'normal', 'BODY', 'SWAB', 'SALINE', '+', '++', '2016-04-01', 4, '26', 'PSEUDOTUMORAL'),
('SAMPLE16', 'TNCHU000011111KJGJ', 'L.Tropica', 'normal', 'BODY', 'SWAB', 'SLIDE', '+', '+++', '2016-01-13', 0, '30', 'WET'),
('SAMPLE17', 'TNCHU000002222', 'L.Infantum', 'normal', 'BODY', 'SCRAPPING', 'TE', '+', '++', '2016-03-30', 6, '10', 'PSEUDOTUMORAL'),
('SAMPLE18', 'TNYYY07052', 'L.Tropica', 'normal', 'BODY', 'SCRAPPING', 'SALINE', '+', '+', '2016-06-25', 0, '25', 'WET'),
('SAMPLE2', 'TNCHU001/02', 'L.Infantum', 'normal', 'FACE', 'BIOPSY', 'SALINE', '+', '+', '2016-01-04', 0, '40', 'WET'),
('SAMPLE20', 'TNYYY00000000008', '.Major', 'normal', 'FACE', 'SCRAPPING', 'SLIDE', '+', '++', '2016-08-01', 2, '30', 'DRY'),
('SAMPLE21', 'TNCHU080547', 'L.Infantum', 'normal', 'ARMS', 'SCRAPPING', 'TE', '+', '+++++', '2016-07-19', 8, '28', 'PSEUDOTUMORAL'),
('SAMPLE24', 'TNCHU090517', '.Major', 'normal', 'FACE', 'SCRAPPING', 'SALINE', '+', '++', NULL, 2, '22', 'DRY'),
('SAMPLE25', 'TNYYY09066', 'L.Infantum', 'normal', 'LEGS', 'SCRAPPING', 'SLIDE', '+', '+++++', '2016-08-30', 8, '13', 'PSEUDOTUMORAL'),
('SAMPLE26', 'TNCHU09077', 'L.Tropica', 'normal', 'ARMS', 'SCRAPPING', 'SALINE', '+', '++++++', '2016-09-02', 0, '27', 'WET'),
('SAMPLE27', 'TNCHU09024', '.Major', 'normal', 'LEGS', 'SCRAPPING', 'SALINE', '+', '+++', '2016-07-20', 1, '33', 'DRY'),
('SAMPLE2é', 'TNCHU091', 'L.Infantum', 'normal', 'ARMS', 'SCRAPPING', 'TE', '+', '++++', '2017-08-30', 5, '3', 'PEUDOTUMORAL'),
('SAMPLE3', 'TNCHU00316', '.Major', 'normal', 'BODY', 'SCRAPPING', 'SLIDE', '+', '++++++', '2016-01-01', 1, '6', 'VERY BIG'),
('SAMPLE4', 'TNCHU555', '.Major', 'normal', 'BODY', 'DENTAL BROCH', 'SLIDE', '+', '++++++', '2016-01-01', 1, '6', 'DRY'),
('SAMPLE5', 'TNCHU666', '.Major', 'normal', 'BODY', 'SCRAPPING', 'SLIDE', '+', '++++++', '2016-01-04', 1, '5', 'BIG'),
('SAMPLE6', 'TNCHU777', '.Major', 'normal', 'BODY', 'SCRAPPING', 'FILTER PAPER', '+', '+++++', '2016-01-01', 0, '5', 'DRY,INFECTED'),
('SAMPLE7', 'TNCHU888', '.Major', 'normal', 'BODY', 'SCRAPPING', 'RNA LATER', '+', '++++++', '2016-01-03', 1, '7', 'DRY'),
('SAMPLE8', 'TN', '.Major', 'normal', 'LEGS', 'SRAPPING', 'SALINE', '+', '+++++', '2016-01-16', 3, '13', 'DRY'),
('SAMPLE9', 'TNCHU010', '.Major', 'normal', 'ARMS', 'SCRAPPING', 'SLIDE', '+', '+++++', '2016-02-15', 2, '4', 'DRY');

-- --------------------------------------------------------

--
-- Structure de la table `travel_residency`
--

CREATE TABLE IF NOT EXISTS `travel_residency` (
  `PATIENT_IDENTIFIER` char(50) NOT NULL,
  `CITY` char(20) NOT NULL,
  `FROMDate` date NOT NULL,
  `TODate` date NOT NULL,
  `BYTENOT` char(15) DEFAULT NULL,
  `RESIDENCY` char(10) DEFAULT NULL,
  PRIMARY KEY (`PATIENT_IDENTIFIER`,`CITY`,`FROMDate`),
  KEY `FK_TRAVEL_R_TRAVEL_RE_REGION` (`CITY`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `travel_residency`
--

INSERT INTO `travel_residency` (`PATIENT_IDENTIFIER`, `CITY`, `FROMDate`, `TODate`, `BYTENOT`, `RESIDENCY`) VALUES
('TN', 'Sousse', '2013-08-08', '2017-03-18', 'NO', 'YES'),
('TNCHU00000000LYGUH', 'Sousse', '2013-08-09', '2016-05-13', 'YES', 'YES'),
('TNCHU001/02', 'Sousse', '1991-08-09', '2016-03-11', 'NO', 'YES'),
('TNCHU00316', 'Sousse', '1993-08-15', '2016-01-25', 'NO', 'YES'),
('TNCHU010', 'Mahdia', '2011-08-09', '2016-03-27', 'YES', 'YES'),
('TNCHU555', 'Mahdia', '1986-09-18', '2016-01-16', 'NO', 'YES'),
('TNCHU666', 'Sousse', '2001-08-01', '2016-01-18', 'NO', 'YES'),
('TNCHU777', 'Tunis', '2012-08-09', '2016-01-16', 'YES', 'YES'),
('TNCHU888', 'Sousse', '2016-01-01', '2016-01-21', 'NO', 'YES'),
('TNCHU9991', 'Tunis', '2000-08-09', '2016-04-14', 'NO', 'YES'),
('TNYYY111', 'TATAOUINE', '2010-08-15', '2016-05-23', 'YES', 'YES'),
('TNYYY5846HGJ', 'TATAOUINE', '2010-08-08', '2016-05-19', 'YES', 'YES');

-- --------------------------------------------------------

--
-- Structure de la table `treatment`
--

CREATE TABLE IF NOT EXISTS `treatment` (
  `TREATMENT_TYPE` char(20) NOT NULL,
  `LOGIN` char(100) NOT NULL,
  PRIMARY KEY (`TREATMENT_TYPE`),
  KEY `FK_TREATMEN_ADDDTREAT_USER` (`LOGIN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `treatment`
--

INSERT INTO `treatment` (`TREATMENT_TYPE`, `LOGIN`) VALUES
('Antibiotics', 'super'),
('Glucantime', 'super');

-- --------------------------------------------------------

--
-- Structure de la table `treatmenthistory`
--

CREATE TABLE IF NOT EXISTS `treatmenthistory` (
  `PATIENT_IDENTIFIER` char(50) NOT NULL,
  `TREATMENT_TYPE` char(20) NOT NULL,
  `PRESCRIBEDFOR` char(20) DEFAULT NULL,
  `START_DATE` date NOT NULL DEFAULT '0000-00-00',
  `POSOLOGY` char(100) DEFAULT NULL,
  `ADMINROUTE` char(100) DEFAULT NULL,
  `INJECTION_NUMBER` int(11) DEFAULT NULL,
  `DURATIONN` char(20) DEFAULT NULL,
  `HEALING_DATE` char(50) DEFAULT NULL,
  PRIMARY KEY (`PATIENT_IDENTIFIER`,`TREATMENT_TYPE`,`START_DATE`),
  KEY `FK_TREATMEN_TREATMENT_TREATMEN` (`TREATMENT_TYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `treatmenthistory`
--

INSERT INTO `treatmenthistory` (`PATIENT_IDENTIFIER`, `TREATMENT_TYPE`, `PRESCRIBEDFOR`, `START_DATE`, `POSOLOGY`, `ADMINROUTE`, `INJECTION_NUMBER`, `DURATIONN`, `HEALING_DATE`) VALUES
('TN', 'Antibiotics', 'YES', '2016-03-20', '2', '3', 0, '3', NULL),
('TN', 'Glucantime', 'Leishmania', '2017-08-02', '', '', 0, 'NA', '2017-10-16'),
('TNCHU001/02', 'Antibiotics', 'NO', '1999-11-05', '2', '5', 0, '1', NULL),
('TNCHU001/02', 'Glucantime', 'YES', '2016-02-15', '1', '1', 15, '7', NULL),
('TNCHU00316', 'Glucantime', 'YES', '2016-01-22', '1', '1', 6, '4', NULL),
('TNCHU05002', 'Glucantime', 'YES', '2016-02-29', '1', '2', 10, '10', '10'),
('TNCHU09024', 'Antibiotics', NULL, '2016-09-15', '2', '2', 0, '3', NULL),
('TNCHU090517', 'Antibiotics', 'YES', '2016-09-21', '2', '2', 0, '4', NULL),
('TNCHU09077', 'Antibiotics', 'YES', '2017-09-23', '2', '2', 0, '3', NULL),
('TNCHU555', 'Antibiotics', 'YES', '2016-01-20', '1', '1', 0, '4', NULL),
('TNCHU666', 'Glucantime', NULL, '2016-01-18', '1', '1', 4, '4', NULL),
('TNCHU777', 'Glucantime', 'YES', '2013-02-22', '1', '1', 8, '4', '2013-03-25'),
('TNCHU888', 'Glucantime', 'YES', '2016-01-30', '1', '1', 10, '6', NULL),
('TNCHU999', 'Antibiotics', 'YES', '2016-04-20', '2', '2', 0, '3', NULL),
('TNCHUOMJ', 'Glucantime', 'YES', '2016-04-17', '1', '1', 10, '3', NULL),
('TNYYY09066', 'Glucantime', 'YES', '2016-09-28', '1', '1', 14, '3', NULL),
('TNYYY5846HGJ', 'Glucantime', 'YES', '2016-05-19', '1', '1', 14, '3', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `LOGIN` char(100) NOT NULL,
  `MOTDPASS` char(100) DEFAULT NULL,
  `LEVELSECURE` char(10) DEFAULT NULL,
  `FROMINST` char(100) DEFAULT NULL,
  `Super` char(100) NOT NULL,
  PRIMARY KEY (`LOGIN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `user`
--

INSERT INTO `user` (`LOGIN`, `MOTDPASS`, `LEVELSECURE`, `FROMINST`, `Super`) VALUES
('normal', 'normal', 'normal', 'CHU', 'Super'),
('super', 'super', 'super', 'IPT', 'super'),
('user', 'user', 'normal', 'IPT', 'super');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
