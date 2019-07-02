-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 02, 2019 at 01:13 PM
-- Server version: 5.7.26-0ubuntu0.16.04.1
-- PHP Version: 7.0.33-0ubuntu0.16.04.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbpfedev`
--

-- --------------------------------------------------------

--
-- Table structure for table `alliquot`
--

CREATE TABLE `alliquot` (
  `ID_ALLUQUOT` char(20) NOT NULL,
  `ID_SAMPLE` char(50) NOT NULL,
  `LOGINUSER` char(100) NOT NULL,
  `VOLUME` decimal(5,0) DEFAULT NULL,
  `CONSERVATION_PLACE` char(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `diognosis`
--

CREATE TABLE `diognosis` (
  `IDDIAGNOSIS` char(20) NOT NULL,
  `TEST` char(20) NOT NULL,
  `LABORATORY_NAME` char(20) NOT NULL,
  `LogInUser` char(50) NOT NULL,
  `ID_SAMPLE` char(50) NOT NULL,
  `DIAGNOSIS_DATE` date DEFAULT NULL,
  `QUANTITE` decimal(5,0) DEFAULT NULL,
  `RESULT` char(10) DEFAULT NULL,
  `LEISHSUSPECT` char(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `interrogator`
--

CREATE TABLE `interrogator` (
  `ID_INTERROGATOR` char(20) NOT NULL,
  `LOGINUSER` char(100) NOT NULL,
  `FIRST_NAME_INTERROGATOR` char(50) DEFAULT NULL,
  `LAST_NAME_INTERROGATOR` char(20) DEFAULT NULL,
  `QUALITY` char(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `laboratory`
--

CREATE TABLE `laboratory` (
  `LABORATORY_NAME` char(20) NOT NULL,
  `LOGINUSER` char(100) NOT NULL,
  `COUNTRY` char(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `laboratory`
--

INSERT INTO `laboratory` (`LABORATORY_NAME`, `LOGINUSER`, `COUNTRY`) VALUES
('IPT', 'super', 'Tunisia'),
('IPM', 'super', 'Morrocco'),
('IPA', 'super', 'Algeria'),
('Rabta', 'super', 'Tunisia-Tunis'),
('RHO', 'super', 'Lebanon'),
('FHS', 'super', 'Tunisia-Sousse'),
('Other', 'super', 'N/A'),
('N/A', 'super', 'N/A');

-- --------------------------------------------------------

--
-- Table structure for table `leishmania_species`
--

CREATE TABLE `leishmania_species` (
  `SPECIES` char(100) NOT NULL,
  `INFORMATION` char(100) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `leishmania_species`
--

INSERT INTO `leishmania_species` (`SPECIES`, `INFORMATION`) VALUES
('L.major', NULL),
('L.infantum', NULL),
('L.tropica', NULL),
('Other', NULL),
('N/A', NULL),
('L.infantum/L.tropica', ''),
('L.major/L.tropica', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `medical_checkup`
--

CREATE TABLE `medical_checkup` (
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
  `LINK_HUMAN_HOSTS` char(200) NOT NULL,
  `CLINICAL_STATE` mediumtext,
  `LESNUM` int(3) NOT NULL,
  `LESPOSSS` varchar(200) DEFAULT NULL,
  `GENDESC` char(200) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `molecularl_test`
--

CREATE TABLE `molecularl_test` (
  `TEST` char(20) NOT NULL,
  `LOGINUSER` char(100) NOT NULL,
  `TEST_TYPE` char(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `molecularl_test`
--

INSERT INTO `molecularl_test` (`TEST`, `LOGINUSER`, `TEST_TYPE`) VALUES
('PCR ITS', 'super', 'PCR ITS'),
('qPCR', 'super', 'qPCR'),
('RPA-LF', 'super', 'RPA-LF'),
('N/A', 'super', 'N/A');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `PATIENT_IDENTIFIER` char(50) NOT NULL,
  `LOGINUSER` char(100) NOT NULL,
  `MEDICAL_FILE_NUMBER` char(50) DEFAULT NULL,
  `FIRST_NAME` char(20) DEFAULT NULL,
  `LAST_NAME` char(20) DEFAULT NULL,
  `BIRTH_DATE` date DEFAULT NULL,
  `AGE` int(3) DEFAULT NULL,
  `NATIONALITY` char(6) DEFAULT NULL,
  `GENDER` char(10) DEFAULT NULL,
  `CONSENT` char(3) DEFAULT NULL,
  `PHONE_NUMBER` char(15) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `region`
--

CREATE TABLE `region` (
  `CITY` char(20) NOT NULL,
  `COUNTRY_` char(20) DEFAULT NULL,
  `GOVERNORATE` char(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sample`
--

CREATE TABLE `sample` (
  `ID_SAMPLE` char(50) NOT NULL,
  `PATIENT_IDENTIFIER` char(50) NOT NULL,
  `SPECIES` char(100) NOT NULL,
  `LOGINUSER` char(100) NOT NULL,
  `LESION_SITE_SAMPLED` char(50) DEFAULT NULL,
  `SAMPLING_METHOD` char(30) DEFAULT NULL,
  `TYPE_OF_SAMPLE_SUPPORT_` char(30) DEFAULT NULL,
  `DIRECT_EXAMINATION` char(20) DEFAULT NULL,
  `ABUDANCE_ON_THE_SMEAR` char(6) DEFAULT NULL,
  `Date_First_Apeard` date DEFAULT NULL,
  `Lesion_Age` int(11) DEFAULT NULL,
  `DIAMETREMax` int(5) DEFAULT NULL,
  `DIAMETREMin` int(5) DEFAULT NULL,
  `HIGHT` int(5) DEFAULT NULL,
  `LOCALISATION` varchar(20) DEFAULT NULL,
  `DESCRIPTION` mediumtext,
  `DATE_EXTRACTION` date DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `travel_residency`
--

CREATE TABLE `travel_residency` (
  `IDMVT` char(20) NOT NULL,
  `CITY` char(40) NOT NULL,
  `LOGINUSER` char(100) NOT NULL,
  `PATIENT_IDENTIFIER` char(50) NOT NULL,
  `FROMDATE` date DEFAULT NULL,
  `TODATE` float DEFAULT NULL,
  `BYTENOT` char(15) DEFAULT NULL,
  `RESIDENCY` char(10) DEFAULT NULL,
  `TYPE` char(5) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `treatment`
--

CREATE TABLE `treatment` (
  `TREATMENT_TYPE` char(20) NOT NULL,
  `LOGINUSER` char(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `treatmenthistory`
--

CREATE TABLE `treatmenthistory` (
  `IDTREATMENT` char(40) NOT NULL,
  `PATIENT_IDENTIFIER` char(50) NOT NULL,
  `TREATMENT_TYPE` char(100) NOT NULL,
  `PRESCRIBEDFOR` char(20) DEFAULT NULL,
  `START_DATE` date DEFAULT NULL,
  `POSOLOGY` char(100) DEFAULT NULL,
  `ADMINROUTE` char(100) DEFAULT NULL,
  `INJECTION_NUMBER` int(11) DEFAULT NULL,
  `DURATIONN` char(20) DEFAULT NULL,
  `HEALING_DATE` char(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `userdata`
--

CREATE TABLE `userdata` (
  `LOGINUSER` char(100) NOT NULL,
  `USE_LOGINUSER` char(100) NOT NULL,
  `MOTDPASS` char(100) DEFAULT NULL,
  `LEVELSECURE` char(10) DEFAULT NULL,
  `FROMINST` char(100) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userdata`
--

INSERT INTO `userdata` (`LOGINUSER`, `USE_LOGINUSER`, `MOTDPASS`, `LEVELSECURE`, `FROMINST`) VALUES
('super', 'super', 'superuser', 'super', 'IPT');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alliquot`
--
ALTER TABLE `alliquot`
  ADD PRIMARY KEY (`ID_ALLUQUOT`),
  ADD KEY `FK_ALLUQUOT_ADDALL_USERDATA` (`LOGINUSER`),
  ADD KEY `FK_ALLUQUOT_GIVE_SAMPLE` (`ID_SAMPLE`);

--
-- Indexes for table `diognosis`
--
ALTER TABLE `diognosis`
  ADD PRIMARY KEY (`IDDIAGNOSIS`),
  ADD KEY `FK_DIOGNOSI_ANALYSESA_SAMPLE` (`ID_SAMPLE`),
  ADD KEY `FK_DIOGNOSI_DO_AT_LABORATO` (`LABORATORY_NAME`),
  ADD KEY `FK_DIOGNOSI_USEMOLTES_MOLECULA` (`TEST`);

--
-- Indexes for table `interrogator`
--
ALTER TABLE `interrogator`
  ADD PRIMARY KEY (`ID_INTERROGATOR`),
  ADD KEY `FK_INTERROG_ADDINTER_USERDATA` (`LOGINUSER`);

--
-- Indexes for table `laboratory`
--
ALTER TABLE `laboratory`
  ADD PRIMARY KEY (`LABORATORY_NAME`),
  ADD KEY `FK_LABORATO_ADDDLAB_USERDATA` (`LOGINUSER`);

--
-- Indexes for table `leishmania_species`
--
ALTER TABLE `leishmania_species`
  ADD PRIMARY KEY (`SPECIES`);

--
-- Indexes for table `medical_checkup`
--
ALTER TABLE `medical_checkup`
  ADD PRIMARY KEY (`DATE_MED`,`ID_MED`),
  ADD KEY `FK_MEDICAL__ADDCHECK_USERDATA` (`LOGINUSER`),
  ADD KEY `FK_MEDICAL__DO_PATIENT` (`PATIENT_IDENTIFIER`),
  ADD KEY `FK_MEDICAL__INVESTIGA_INTERROG` (`ID_INTERROGATOR`);

--
-- Indexes for table `molecularl_test`
--
ALTER TABLE `molecularl_test`
  ADD PRIMARY KEY (`TEST`),
  ADD KEY `FK_MOLECULA_ADDMOLTES_USERDATA` (`LOGINUSER`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`PATIENT_IDENTIFIER`),
  ADD KEY `FK_PATIENT_ADDPATT_USERDATA` (`LOGINUSER`);

--
-- Indexes for table `region`
--
ALTER TABLE `region`
  ADD PRIMARY KEY (`CITY`);

--
-- Indexes for table `sample`
--
ALTER TABLE `sample`
  ADD PRIMARY KEY (`ID_SAMPLE`),
  ADD KEY `FK_SAMPLE_ADDSAMPL_USERDATA` (`LOGINUSER`),
  ADD KEY `FK_SAMPLE_CONTAIN_LEISHMAN` (`SPECIES`),
  ADD KEY `FK_SAMPLE_EXTRACT_PATIENT` (`PATIENT_IDENTIFIER`);

--
-- Indexes for table `travel_residency`
--
ALTER TABLE `travel_residency`
  ADD PRIMARY KEY (`IDMVT`),
  ADD KEY `FK_TRAVEL_R_TRAVEL_PATIENT` (`PATIENT_IDENTIFIER`),
  ADD KEY `FK_TRAVEL_R_VISIT_REGION` (`CITY`),
  ADD KEY `LOGINUSER` (`LOGINUSER`);

--
-- Indexes for table `treatment`
--
ALTER TABLE `treatment`
  ADD PRIMARY KEY (`TREATMENT_TYPE`),
  ADD KEY `FK_TREATMEN_ADDDTREAT_USERDATA` (`LOGINUSER`);

--
-- Indexes for table `treatmenthistory`
--
ALTER TABLE `treatmenthistory`
  ADD PRIMARY KEY (`IDTREATMENT`),
  ADD KEY `FK_TREATMEN_ADDTREATM_PATIENT` (`PATIENT_IDENTIFIER`);

--
-- Indexes for table `userdata`
--
ALTER TABLE `userdata`
  ADD PRIMARY KEY (`LOGINUSER`),
  ADD KEY `FK_USERDATA_CREATER_USERDATA` (`USE_LOGINUSER`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
