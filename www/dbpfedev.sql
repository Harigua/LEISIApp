-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 13, 2018 at 03:32 PM
-- Server version: 5.7.23-0ubuntu0.16.04.1
-- PHP Version: 7.0.30-0ubuntu0.16.04.1

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
  `ID_SAMPLE` char(50) NOT NULL,
  `DIAGNOSIS_DATE` date DEFAULT NULL,
  `QUANTITE` decimal(5,0) DEFAULT NULL,
  `RESULT` char(10) DEFAULT NULL,
  `LEISHSUSPECT` char(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `diognosis`
--

INSERT INTO `diognosis` (`IDDIAGNOSIS`, `TEST`, `LABORATORY_NAME`, `ID_SAMPLE`, `DIAGNOSIS_DATE`, `QUANTITE`, `RESULT`, `LEISHSUSPECT`) VALUES
('Diagnosis1', 'PCR ITS', 'IPM', 'PER620147-45', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis4', 'PCR ITS', 'IPM', 'PER620132-48', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis2', 'PCR ITS', 'IPM', 'PER620122-46', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis3', 'PCR ITS', 'IPM', 'PER620123-47', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis5', 'PCR ITS', 'IPM', 'PER620160-49', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis6', 'PCR ITS', 'IPM', 'PER620133-50', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis7', 'PCR ITS', 'IPM', 'PER620161-52', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis8', 'PCR ITS', 'IPM', 'PER620158-53', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis9', 'PCR ITS', 'IPM', 'PER620159-54', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis10', 'PCR ITS', 'IPM', 'PER620143-51', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis11', 'PCR ITS', 'IPM', 'PER620163-60', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis12', 'PCR ITS', 'IPM', 'PER620151-55', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis13', 'PCR ITS', 'IPM', 'PER620135-56', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis14', 'PCR ITS', 'IPM', 'PER620141-58', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis15', 'PCR ITS', 'IPM', 'PER620129-59', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis16', 'PCR ITS', 'IPM', 'PER620152-61', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis17', 'PCR ITS', 'IPM', 'PER620127-62', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis18', 'PCR ITS', 'IPM', 'PER620148-63', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis19', 'PCR ITS', 'IPM', 'PER620125-64', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis20', 'PCR ITS', 'IPM', 'PER620150-65', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis21', 'PCR ITS', 'IPM', 'PER620156-66', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis22', 'PCR ITS', 'IPM', 'PER620124-67', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis23', 'PCR ITS', 'IPM', 'PER620138-68', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis24', 'PCR ITS', 'IPM', 'PER620154-69', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis25', 'PCR ITS', 'IPM', 'PER620145-70', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis26', 'PCR ITS', 'IPM', 'PER620155-71', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis27', 'PCR ITS', 'IPM', 'PER620164-72', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis28', 'PCR ITS', 'IPM', 'PER620140-73', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis29', 'PCR ITS', 'IPM', 'PER620136-74', '1900-01-01', '0', '+', 'L.Major'),
('Diagnosis30', 'PCR ITS', 'IPM', 'PER620134-75', '1900-01-01', '0', '+', 'L.Major');

-- --------------------------------------------------------

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
-- Dumping data for table `interrogator`
--

INSERT INTO `interrogator` (`ID_INTERROGATOR`, `LOGINUSER`, `FIRST_NAME_INTERROGATOR`, `LAST_NAME_INTERROGATOR`, `QUALITY`) VALUES
('RHO001', 'zeineb', 'Oussaima', 'El Dbouni', 'Doctor'),
('LBP001', 'zeineb', 'Pierre', 'Abi Hanna', 'Doctor'),
('HFH001', 'zeineb', 'Fathallah', 'Ahlem', 'Technicien'),
('HFH002', 'zeineb', 'Lazzem', 'Moez', 'Resident doctor'),
('HFH003', 'zeineb', 'Ben Salah', 'Azer', 'Doctor'),
('HFH004', 'zeineb', 'Hazgui', 'Olfa', 'Resident doctor'),
('HFH005', 'zeineb', 'Khammari', 'Imene', 'Doctor'),
('HFH006', 'zeineb', 'Abdelkhalek', 'Sana', 'Technicien'),
('HLR001', 'zeineb', 'Jemel', 'Sana', 'Doctor'),
('HLR002', 'zeineb', 'Boudaouara', 'Yosr', 'Resident doctor'),
('CST001', 'zeineb', 'Daoui', 'Othmane', 'Researcher');

-- --------------------------------------------------------

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
('L.Major', NULL),
('L.Infantum', NULL),
('L.Tropica', NULL),
('Other', NULL),
('N/A', NULL);

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
-- Dumping data for table `medical_checkup`
--

INSERT INTO `medical_checkup` (`ID_MED`, `DATE_MED`, `ID_INTERROGATOR`, `PATIENT_IDENTIFIER`, `LOGINUSER`, `HOSPITAL`, `PHYSICIAN`, `SAMPLER`, `ANIMAL_AROUND`, `POSSIBLE_HUMAN_HOSTS`, `LINK_HUMAN_HOSTS`, `CLINICAL_STATE`, `LESNUM`, `LESPOSSS`, `GENDESC`) VALUES
('Medical-check3', '2017-11-15', 'RHO001', 'PER520110', 'zeineb', 'RHOH', 'O. El Dbouni', 'O. El Dbouni', 'No', 'No', 'N/A', 'N/A', 3, 'Upper limbs,  Lower limbs', NULL),
('Medical-check2', '2017-11-08', 'RHO001', 'PER520106', 'zeineb', 'RHO', 'O. El Dbouni', 'O. El Dbouni', 'Bovines', 'Family', 'N/A', 'N/A', 2, 'Upper limbs', NULL),
('Medical-check1', '2017-08-16', 'RHO001', 'PER520118', 'zeineb', 'RHO', 'O. El Dbouni', 'O. El Dbouni', 'Bovines', 'No', 'N/A', 'Nothing to Report', 1, 'Face', NULL),
('Medical-check4', '2017-11-15', 'RHO001', 'PER520111', 'zeineb', 'RHOH', 'O. El Dbouni', 'O. El Dbouni', 'No', 'No', 'N/A', 'N/A', 0, 'Upper limbs', NULL),
('Medical-check5', '2017-11-23', 'RHO001', 'PER520101', 'zeineb', 'RHOH', 'O. El Dbouni', '', 'No', 'Family', 'N/A', 'N/A', 1, 'Upper limbs', NULL),
('Medical-check6', '2017-11-29', 'RHO001', 'PER520105', 'zeineb', 'RHOH', 'O. El Dbouni', 'O. El Dbouni', 'No', 'Family', 'N/A', 'N/A', 1, 'Upper limbs', NULL),
('Medical-check7', '2017-12-13', 'RHO001', 'PER520116', 'zeineb', 'RHOH', 'O. El Dbouni', 'O. El Dbouni', 'No', 'Family', '	 N/A', 'N/A', 1, 'Face', NULL),
('Medical-check8', '2018-03-07', 'RHO001', 'PER520104', 'zeineb', 'RHOH', 'O. El Dbouni', 'O. El Dbouni', 'No', 'N/A', 'N/A', 'N/A', 1, 'Face', NULL),
('Medical-check9', '2018-04-04', 'RHO001', 'PER520119', 'zeineb', 'RHOH', 'O. EL Dbouni', 'O. EL Dbouni', 'No', 'Family', 'N/A', 'Nothing to Report', 1, 'Face', NULL),
('Medical-check10', '2018-04-18', 'RHO001', 'PER520114', 'zeineb', 'RHOH', 'O. El Dbouni', 'O. El Dbouni', 'No', 'Family', 'N/A', 'Nothing to Report', 1, 'Face', NULL),
('Medical-check11', '2018-04-18', 'RHO001', 'PER520109', 'zeineb', 'RHOH', 'O. El Dbouni', 'O. El Dbouni', 'No', 'Family', 'N/A', 'N/A', 2, 'Face', NULL),
('Medical-check12', '2017-09-05', 'LBP001', 'PER520108', 'zeineb', 'LBP', 'Pierre Abi Hanna', '', 'N/A', 'Family', 'N/A', 'N/A', 1, 'Upper limbs', NULL),
('Medical-check13', '2017-09-05', 'LBP001', 'PER520115', 'zeineb', 'LBP', '', '', 'N/A', 'Family', 'N/A', 'Nothing to Report', 2, 'Face, Upper limbs', NULL),
('Medical-check14', '2017-10-31', 'LBP001', 'PER520113', 'zeineb', 'LBP', 'Pierre Abi Hanna', '', 'N/A', 'No', 'N/A', 'N/A', 1, 'Upper limbs', NULL),
('Medical-check15', '2017-01-01', 'LBP001', 'PER520107', 'zeineb', 'LBP', 'Pierre Abi Hanna', '', 'No', 'No', 'N/A', 'N/A', 1, 'Lower limbs', NULL),
('Medical-check16', '2018-01-27', 'HFH002', 'PER340088', 'zeineb', 'HFH', 'Dr Lahoual', 'Hinda', 'No', 'Family', 'N/A', 'Nothing to Report', 1, 'Upper limbs', NULL),
('Medical-check17', '2018-01-18', 'HFH002', 'PER340098', 'zeineb', 'HFH', 'Dr Sana M', 'Dr Saghrouni Fatma', 'Bovines, Ovins, Cats', 'No', 'N/A', 'Nothing to Report', 1, 'Face', NULL),
('Medical-check18', '2017-01-17', 'HFH002', 'PER340078', 'zeineb', 'HFH', 'Dr Ksiaa', 'Sana Abdelkhalek', 'No', 'No', 'N/A', 'Nothing to Report', 1, 'Upper limbs', NULL),
('Medical-check19', '2018-01-04', 'HFH001', 'PER340097', 'zeineb', 'HFH', 'N/A', 'Tech Sana', 'Cats, Dogs, Other rodents', 'No', 'N/A', 'High blood pressure', 1, 'Lower limbs', NULL),
('Medical-check20', '2017-11-09', 'HFH005', 'PER340099', 'zeineb', 'HFH', 'R Gammoudi', 'Hinda', 'Bovines, Ovins, Cats, Dogs, Other rodents', 'No', 'N/A', 'Nothing to Report', 2, 'Upper limbs', NULL),
('Medical-check21', '2017-11-24', 'HFH004', 'PER340100', 'zeineb', 'HFH', 'N/A', 'N/A', 'Bovines, Ovins, Caprins, Dogs', 'Family', 'N/A', 'Nothing to Report', 4, 'Lower limbs', NULL),
('Medical-check22', '2017-11-30', 'HFH003', 'PER340094', 'zeineb', 'HFH', 'Resident Amer', 'N/A', 'Ovins, Dogs', 'N/A', 'N/A', 'Nothing to Report', 4, 'Upper limbs', NULL),
('Medical-check23', '2017-12-04', '', 'PER340073', 'zeineb', 'HFH', 'Amara', 'Sana', 'No', 'No', 'N/A', 'Nothing to Report', 1, 'Lower limbs', NULL),
('Medical-check24', '2017-07-08', '', 'PER340071', 'zeineb', 'HFH', 'Dr Denguezli', 'Technicien Sana', 'No', 'N/A', 'N/A', 'Nothing to Report', 3, 'Upper limbs Lower limbs', NULL),
('Medical-check25', '2017-11-14', 'HFH001', 'PER340062', 'zeineb', 'HFH', 'Dr Kenani', 'Sana', 'Hares, Cats, Dogs, Other rodents', 'N/A', 'N/A', 'Nothing to Report', 1, 'Lower limbs', NULL),
('Medical-check26', '2017-11-14', 'HFH001', 'PER340064', 'zeineb', 'HFH', 'Resident doctor Maghfour', 'Sana', 'Hares, Cats, Dogs', 'Family', 'N/A', 'Nothing to Report', 2, 'Lower limbs', NULL),
('Medical-check27', '2017-11-16', 'HFH001', 'PER340086', 'zeineb', 'HFH', 'Resident doctor Maghfour', 'Technicien Lamia', 'No', 'No', 'N/A', 'Nothing to Report', 4, 'Upper limbs Lower limbs', NULL),
('Medical-check28', '2018-01-04', 'HFH001', 'PER340084', 'zeineb', 'HFH', 'Dr Nouira Rafiaa', 'Tech Sana', 'No', 'No', 'N/A', 'Nothing to Report', 3, 'Upper limbs', NULL),
('Medical-check29', '2018-01-27', 'HFH002', 'PER340063', 'zeineb', 'HFH', 'Dr Nouira', 'Tech Hinda', 'No', 'No', 'N/A', 'Diabetes', 2, 'Upper limbs', NULL),
('Medical-check30', '2018-01-20', 'HFH002', 'PER340076', 'zeineb', 'HFH', '', 'Sana Abdelkhalek', 'Bovines, Ovins, Cats, Dogs', 'No', 'N/A', 'Other', 6, 'Upper limbs', NULL),
('Medical-check44', '2018-01-19', 'HLR002', 'PER570058', 'zeineb', 'HLR', 'N/A', 'N/A', 'Cats, Dogs', 'N/A', 'N/A', 'Pregnancy', 5, 'Upper limbs, Lower limbs', NULL),
('Medical-check32', '2018-01-12', 'HFH001', 'PER340095', 'zeineb', 'HFH', '', 'Tech Sana', 'No', 'No', 'N/A', 'Nothing to Report', 1, 'Face', NULL),
('Medical-check33', '2018-01-05', 'HFH001', 'PER340065', 'zeineb', 'HFH', 'Dr Chebil Faten', 'Tech Sana', 'Cats, Dogs, Other rodents', 'Family', 'N/A', 'Pregnancy', 2, 'Upper limbs', NULL),
('Medical-check34', '2018-01-11', 'HFH002', 'PER340066', 'zeineb', 'HFH', 'Dr Badday Bouraoui', 'Dr Saghrouni', 'Bovines, Cats, Dogs', 'No', 'N/A', 'Allergy', 5, 'Upper limbs', NULL),
('Medical-check35', '2017-11-22', 'HFH001', 'PER340060', 'zeineb', 'HFH', 'Dr Ktat Mongi', 'Tech Sana', 'No', 'No', 'N/A', 'Nothing to Report', 2, 'Lower limbs', NULL),
('Medical-check36', '2017-11-27', 'HFH006', 'PER340068', 'zeineb', 'HFH', 'Dr Khribi Kaouthar', 'Tech Hend', 'No', 'N/A', 'N/A', 'N/A', 1, 'Face', NULL),
('Medical-check37', '2017-12-06', 'HFH001', 'PER340096', 'zeineb', 'HFH', 'Guelich Sana', 'Tech Sana', 'Cats, Dogs, Other rodents', 'Family', 'N/A', 'Nothing to Report', 2, 'Face', NULL),
('Medical-check38', '2017-12-07', 'HFH006', 'PER340067', 'zeineb', 'HFH', 'Maalaoui Hounaida', 'Tech Henda', 'Hares, Cats, Dogs', 'No', 'N/A', 'N/A', 6, 'Upper limbs, Lower limbs', NULL),
('Medical-check39', '2017-12-16', 'HFH001', 'PER340090', 'zeineb', 'HFH', 'Dr Hadj Ibrahim', 'Tech Sana', 'Other rodents', 'No', 'N/A', 'Diabetes, Allergy', 1, 'Lower limbs', NULL),
('Medical-check40', '2017-12-16', 'HFH001', 'PER340075', 'zeineb', 'HFH', 'N/A', 'Tech Sana', 'Other rodents', 'N/A', 'N/A', 'Nothing to Report', 2, 'Upper limbs', NULL),
('Medical-check41', '2018-01-12', 'HFH002', 'PER340091', 'zeineb', 'HFH', 'N/A', 'N/A', 'No', 'No', 'N/A', 'Nothing to Report', 1, 'Lower limbs', NULL),
('Medical-check42', '2018-01-16', 'HFH006', 'PER340089', 'zeineb', 'HFH', 'N/A', 'Tech Henda', 'Hares, Cats, Dogs', 'No', 'N/A', 'Nothing to Report', 1, 'Face', NULL),
('Medical-check43', '2017-01-01', 'HFH005', 'PER340074', 'zeineb', 'HFH', 'N/A', 'N/A', 'Cats, Dogs, Foxs, Gondis', 'Family', 'N/A', 'Nothing to Report', 1, 'Lower limbs', NULL),
('Medical-check44', '2018-01-12', 'HLR001', 'PER570052', 'zeineb', 'HLR', 'N/A', 'N/A', 'Dogs', 'No', 'N/A', 'Nothing to Report', 2, 'Upper limbs, Lower limbs', NULL),
('Medical-check46', '2017-12-20', 'CST001', 'PER620122', 'zeineb', 'Centre de sante Tinzouline', 'NA', 'NA', 'Dogs, Other rodents, Cats', 'No', 'No', 'N/A', 3, 'Upper limbs', NULL),
('Medical-check45', '2017-12-19', 'CST001', 'PER620147', 'zeineb', 'Centre de santé Tinzouline', 'NA', 'NA', 'Dogs, Other rodents, Cats, Hedgehogs', 'Family, Neighbour', 'N/A', 'N/A', 5, 'Upper limbs', NULL),
('Medical-check47', '2017-12-20', 'CST001', 'PER620123', 'zeineb', 'Centre de sante Tinezouline', 'NA', 'NA', 'N/A', 'N/A', 'N/A', 'N/A', 3, 'Face', NULL),
('Medical-check48', '2017-12-20', 'CST001', 'PER620132', 'zeineb', 'Centre de sante Tinzouline', 'NA', 'NA', 'Other rodents, Cats, Hares', 'N/A', 'N/A', 'N/A', 20, 'Upper limbs, Lower limbs', NULL),
('Medical-check49', '2017-12-20', 'CST001', 'PER620160', 'zeineb', 'Centre de sante Tinzouline', 'NA', 'NA', 'Cats, Dogs', 'Neighbour', 'N/A', 'N/A', 15, 'Face, Upper limbs, Lower limbs', NULL),
('Medical-check50', '2017-12-20', 'CST001', 'PER620133', 'zeineb', 'Centre de sante Tinzouline', 'NA', 'NA', 'N/A', 'N/A', 'N/A', 'N/A', 10, 'Upper limbs, Lower limbs', NULL),
('Medical-check51', '2017-12-19', 'CST001', 'PER620143', 'zeineb', 'Centre de sante Tinzouline', 'NA', 'NA', 'Dogs', 'No', 'N/A', 'N/A', 3, 'Face', NULL),
('Medical-check52', '2017-12-19', 'CST001', 'PER620161', 'zeineb', 'Centre de sante Tinzouline', 'NA', 'NA', ' Cats, Dogs, Other rodents', 'Neighbour', 'N/A', 'N/A', 11, '4, 5, 6, 7, 8, 3, 1', NULL),
('Medical-check53', '2017-12-19', 'CST001', 'PER620158', 'zeineb', 'Centre de sante Tinzouline', 'NA', 'NA', 'Other rodents, Hedgehogs, Bates, Dogs', 'Family, Neighbour', 'N/A', 'N/A', 7, 'Upper limbs, Lower limbs', NULL),
('Medical-check54', '2017-12-19', 'CST001', 'PER620159', 'zeineb', 'Centre de sante Tinzouline', 'NA', 'NA', 'Dogs, Other rodents, Hedgehogs, Bates', 'N/A', 'N/A', 'N/A', 5, 'Face', NULL),
('Medical-check55', '2017-12-19', 'CST001', 'PER620151', 'zeineb', 'Centre de sante Tinzouline', 'N/A', 'N/A', 'Cats, Dogs', 'Neighbour', 'N/A', 'N/A', 1, 'Upper limbs', NULL),
('Medical-check56', '2017-12-19', 'CST001', 'PER620135', 'zeineb', 'Centre de sante Tinzouline', 'N/A', 'N/A', 'Dogs, Other rodents', 'Neighbour', 'N/A', 'N/A', 2, 'Face, Upper limbs', NULL),
('Medical-check57', '2017-12-19', 'CST001', 'PER620141', 'zeineb', 'Centre de sante Tinzouline', 'N/A', 'N/A', 'Dogs, Cats, Bates', 'Family', 'Household', 'N/A', 5, 'Upper limbs, Lower limbs', NULL),
('Medical-check58', '2017-12-19', 'CST001', 'PER620129', 'zeineb', 'Centre de sante Tinzouline', 'N/A', 'N/A', 'Dogs, Other rodents', 'Family, Neighbour', 'N/A', 'N/A', 1, 'Upper limbs', NULL),
('Medical-check59', '2017-12-19', 'CST001', 'PER620163', 'zeineb', 'Centre de sante Tinzouline', 'N/A', 'N/A', 'Dogs, Other rodents, Cats', 'Neighbour', 'N/A', 'N/A', 3, 'Upper limbs', NULL),
('Medical-check60', '2017-12-19', 'CST001', 'PER620152', 'zeineb', 'Centre de sante Tinzouline', 'N/A', 'N/A', 'Dogs, Other rodents', 'Family, Neighbour', 'N/A', 'N/A', 4, 'Upper limbs', NULL),
('Medical-check61', '2017-12-19', 'CST001', 'PER620127', 'zeineb', 'Centre de sante Tinzouline', 'N/A', 'N/A', 'Cats, Dogs, Other rodents, Hares', 'Family, Neighbour', 'N/A', 'N/A', 1, 'Upper limbs', NULL),
('Medical-check62', '2017-12-20', 'CST001', 'PER620148', 'zeineb', 'Centre de sante Tinzouline', 'N/A', 'N/A', 'Dogs, Other rodents, Cats, Hares', 'Neighbour', 'N/A', 'N/A', 5, 'Upper limbs, Lower limbs', NULL),
('Medical-check63', '2017-12-19', 'CST001', 'PER620125', 'zeineb', 'Centre de sante Tinzouline', 'N/A', 'N/A', 'Dogs, Other rodents, Hedgehogs', 'Family', 'Household', 'N/A', 9, 'Face', NULL),
('Medical-check64', '2017-12-20', 'CST001', 'PER620150', 'zeineb', 'Centre de sante Tinzouline', 'N/A', 'N/A', 'Dogs, Other rodents, Cats', 'No', 'N/A', 'N/A', 7, 'Upper limbs, Lower limbs', NULL),
('Medical-check65', '2017-12-21', 'CST001', 'PER620156', 'zeineb', 'Centre de sante Tinzouline', 'N/A', 'N/A', 'Dogs, Other rodents, Cats', 'N/A', 'N/A', 'N/A', 4, 'Face', NULL),
('Medical-check66', '2017-12-21', 'CST001', 'PER620124', 'zeineb', 'Centre de sante Tinzouline', 'N/A', 'N/A', 'Dogs, Other rodents, Cats', 'Family, Neighbour', 'N/A', 'N/A', 1, 'Upper limbs', NULL),
('Medical-check67', '2017-12-21', 'CST001', 'PER620138', 'zeineb', 'Centre de sante Tinzouline', 'N/A', 'N/A', 'Dogs, Cats', 'No', 'N/A', 'N/A', 1, 'Upper limbs', NULL),
('Medical-check68', '2017-12-21', 'CST001', 'PER620154', 'zeineb', 'Centre de sante Tinzouline', 'N/A', 'N/A', 'Dogs, Other rodents, Cats', 'Family, Neighbour', 'N/A', 'N/A', 1, 'Face', NULL),
('Medical-check69', '2017-12-21', 'CST001', 'PER620145', 'zeineb', 'Centre de sante Tinzouline', 'N/A', 'N/A', 'Dogs, Other rodents, Cats', 'Neighbour', 'N/A', 'N/A', 8, 'Face', NULL),
('Medical-check70', '2017-12-20', 'CST001', 'PER620155', 'zeineb', 'Centre de sante Tinzouline', 'N/A', 'N/A', 'N/A', 'Family', 'N/A', 'N/A', 10, 'Face, Upper limbs', NULL),
('Medical-check71', '2017-12-20', 'CST001', 'PER620164', 'zeineb', 'Centre de sante Tinzouline', 'N/A', 'N/A', 'Dogs, Other rodents', 'N/A', 'N/A', 'N/A', 5, 'Face, Upper limbs', NULL),
('Medical-check72', '2017-12-20', 'CST001', 'PER620140', 'zeineb', 'Centre de sante Tinzouline', 'N/A', 'N/A', 'Dogs, Other rodents, Cats', 'Family', 'Household', 'N/A', 9, 'Upper limbs', NULL),
('Medical-check73', '2017-12-20', 'CST001', 'PER620136', 'zeineb', 'Centre de sante Tinzouline', 'N/A', 'N/A', 'Cats, Dogs', 'Family, Neighbour', 'N/A', 'N/A', 15, 'Upper limbs, Lower limbs', NULL),
('Medical-check74', '2017-12-21', 'CST001', 'PER620134', 'zeineb', 'Centre de sante Tinzouline', 'N/A', 'N/A', 'Dogs, Other rodents, Cats', 'No', 'N/A', 'N/A', 2, 'Face', NULL);

-- --------------------------------------------------------

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
  `NATIONALITY` char(6) DEFAULT NULL,
  `GENDER` char(10) DEFAULT NULL,
  `CONSENT` char(3) DEFAULT NULL,
  `PHONE_NUMBER` char(15) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`PATIENT_IDENTIFIER`, `LOGINUSER`, `MEDICAL_FILE_NUMBER`, `FIRST_NAME`, `LAST_NAME`, `BIRTH_DATE`, `NATIONALITY`, `GENDER`, `CONSENT`, `PHONE_NUMBER`) VALUES
('PER520104', 'zeineb', 'RHO/008', 'Mhid Abdallh', 'Yassin', '1998-01-01', 'SY', 'Male', 'Yes', '811273714'),
('PER520116', 'zeineb', 'RHO/007', 'Nissrine', 'El Abdallah', '2000-01-01', 'SY', 'Female', 'YES', '76041307'),
('PER520105', 'zeineb', 'RHO/006', 'Hassan', 'Hammoud', '2002-01-01', 'Other', 'Male', 'YES', '711389287'),
('PER520101', 'zeineb', 'RHO/005', 'Hamud', 'Marwa', '2008-01-04', 'SY', 'Female', 'Yes', '71389287'),
('PER520111', 'zeineb', 'RHO/004', 'El Zoul', 'Wael', '2012-05-15', 'SY', 'Male', 'Yes', '711895977'),
('PER520110', 'zeineb', 'RHO/003', 'El Dika', 'Moussa', '1994-08-31', 'LB', 'Male', 'YES', ''),
('PER520106', 'zeineb', 'RHO/002', 'Alboud Hamud', 'Najem', '1973-01-01', 'SY', 'Male', 'YES', '71389287'),
('PER520118', 'zeineb', 'RHO/001', 'Alissa', 'Amal', '1993-07-12', 'SY', 'Female', 'YES', '31287667'),
('PER520119', 'zeineb', 'RHO/009', 'Salem', 'Rim', '1993-01-01', 'NA', 'Female', 'Yes', '79144379'),
('PER520114', 'zeineb', 'RHO/010', 'El Hussein', 'Ismail', '2006-01-10', 'NA', 'Male', 'YES', '701709849'),
('PER520109', 'zeineb', 'RHO/011', 'El Mostafa Elissa', 'Walaa', '2009-01-01', 'SY', 'Female', 'Yes', '811678703'),
('PER520108', 'zeineb', 'LBP4', 'El Hajj Hassen', 'Jawaher', '2007-01-01', 'SY', 'Female', 'N/A', ''),
('PER520115', 'zeineb', 'LBP3', 'Hajj Hassan', 'Mohamed', '2005-01-01', 'SY', 'Male', 'N/A', ''),
('PER520113', 'zeineb', 'LBP8', 'Anayzan', 'Chahed', '2008-04-01', 'SY', 'Female', 'N/A', ''),
('PER520107', 'zeineb', 'LBP7', 'Hindawi', 'Amira', '1966-01-01', 'SY', 'Female', 'N/A', ''),
('PER340088', 'zeineb', '29/18', '', '', '2008-08-18', 'TN', 'Male', 'Yes', ''),
('PER340098', 'zeineb', '21/18', '', '', '1978-01-01', 'TN', 'Female', 'Yes', ''),
('PER340078', 'zeineb', '18/18', '', '', '1951-01-01', 'TN', 'Male', 'Yes', ''),
('PER340097', 'zeineb', '8/18', '', '', '1960-02-21', 'TN', 'Male', 'Yes', ''),
('PER340099', 'zeineb', '130/17', '', '', '2002-01-01', 'TN', 'Male', 'Yes', ''),
('PER340100', 'zeineb', '146/17', '', '', '2005-06-15', 'TN', 'Male', 'Yes', ''),
('PER340094', 'zeineb', '154/17', '', '', '1989-06-20', 'TN', 'Male', 'Yes', ''),
('PER340073', 'zeineb', '156/17', '', '', '2003-01-01', 'TN', 'Male', 'Yes', ''),
('PER340071', 'zeineb', '129/17', '', '', '1966-01-01', 'TN', 'Female', 'Yes', ''),
('PER340062', 'zeineb', '133/17', '', '', '1993-11-02', 'TN', 'Female', 'Yes', ''),
('PER340064', 'zeineb', '132/17', '', '', '2009-06-26', 'TN', 'Female', 'Yes', ''),
('PER340086', 'zeineb', '136/17', '', '', '1995-08-14', 'TN', 'Male', 'Yes', ''),
('PER340084', 'zeineb', '6/18', '', '', '1985-10-15', 'TN', 'Male', 'Yes', ''),
('PER620122', 'zeineb', 'Z17/49', '', '', '1977-12-20', 'MA', 'Female', 'Yes', ''),
('PER340063', 'zeineb', '30/18', '', '', '1968-04-25', 'TN', 'Male', 'Yes', ''),
('PER340076', 'zeineb', '23/18', '', '', '2010-08-18', 'TN', 'Female', 'Yes', ''),
('PER340095', 'zeineb', '14/18', '', '', '1955-09-19', 'TN', 'Male', 'Yes', ''),
('PER340065', 'zeineb', '9/18', '', '', '1977-03-18', 'TN', 'Female', 'Yes', ''),
('PER340066', 'zeineb', '12/18', '', '', '1994-08-20', 'TN', 'Male', 'Yes', ''),
('PER340060', 'zeineb', '144/17', '', '', '1977-02-19', 'TN', 'Male', 'Yes', ''),
('PER340068', 'zeineb', 'LC147/17', '', '', '2011-05-02', 'TN', 'Male', 'Yes', ''),
('PER340096', 'zeineb', '157/17', '', '', '2013-08-26', 'TN', 'Female', 'Yes', ''),
('PER340067', 'zeineb', 'LC161/17', '', '', '2016-10-14', 'TN', 'Male', 'Yes', ''),
('PER340090', 'zeineb', '165/17', '', '', '1963-06-21', 'TN', 'Male', 'Yes', ''),
('PER340075', 'zeineb', '166/17', '', '', '1982-11-21', 'TN', 'Male', 'Yes', ''),
('PER340091', 'zeineb', '13/18', '', '', '1987-01-03', 'TN', 'Female', 'Yes', ''),
('PER340089', 'zeineb', '16/18', '', '', '2016-08-30', 'TN', 'Male', 'Yes', ''),
('PER340074', 'zeineb', '142/17', '', '', '1999-01-01', 'TN', 'Male', 'Yes', ''),
('PER570052', 'zeineb', 'LC05/18', '', '', '1964-08-27', 'TN', 'Female', 'Yes', ''),
('PER570058', 'zeineb', 'LC06/18', '', '', '1979-09-01', 'LB', 'Female', 'Yes', ''),
('PER620158', 'zeineb', 'Z1704', '', '', '1987-12-19', 'MA', 'Male', 'Yes', ''),
('PER620133', 'zeineb', 'Z17/60', '', '', '1977-12-20', 'MA', 'Female', 'Yes', ''),
('PER620160', 'zeineb', 'Z17/53', '', '', '1977-12-20', 'MA', 'Female', 'Yes', ''),
('PER620132', 'zeineb', 'Z17/54', '', '', '2004-12-20', 'MA', 'Female', 'Yes', ''),
('PER620159', 'zeineb', 'Z17/06', '', '', '2012-12-19', 'MA', 'Male', 'Yes', ''),
('PER620147', 'zeineb', 'Z17/07', '', '', '1967-12-19', 'MA', 'Female', 'Yes', ''),
('PER620123', 'zeineb', 'Z17/50', '', '', '2005-12-20', 'MA', 'Male', 'Yes', ''),
('PER620161', 'zeineb', 'Z17/02', '', '', '1982-12-19', 'MA', 'Female', 'Yes', ''),
('PER620143', 'zeineb', 'Z17/01', '', '', '2012-12-19', 'MA', 'Female', 'Yes', ''),
('PER620151', 'zeineb', 'Z17/08', '', '', '1900-01-01', 'MA', 'Female', 'Yes', ''),
('PER620135', 'zeineb', 'Z17/12', '', '', '1998-12-19', 'MA', 'Female', 'Yes', ''),
('PER620141', 'zeineb', 'Z17/13', '', '', '2005-12-19', 'MA', 'Female', 'Yes', ''),
('PER620129', 'zeineb', 'Z17/16', '', '', '2010-12-19', 'MA', 'Female', 'Yes', ''),
('PER620163', 'zeineb', 'Z17/19', '', '', '1992-12-19', 'MA', 'Female', 'Yes', ''),
('PER620152', 'zeineb', 'Z17/22', '', '', '2007-12-19', 'MA', 'Female', 'Yes', ''),
('PER620127', 'zeineb', 'Z17/24', '', '', '2014-12-19', 'MA', 'Female', 'Yes', ''),
('PER620148', 'zeineb', 'Z17/41', '', '', '1900-01-01', 'MA', 'Female', 'Yes', ''),
('PER620125', 'zeineb', 'Z17/37', '', '', '2010-12-19', 'MA', 'Male', 'Yes', ''),
('PER620150', 'zeineb', 'Z17/47', '', '', '1967-12-20', 'MA', 'Female', 'Yes', ''),
('PER620156', 'zeineb', 'Z17/92', '', '', '2010-12-21', 'MA', 'Female', 'Yes', ''),
('PER620124', 'zeineb', 'Z17/177', '', '', '2006-12-21', 'MA', 'Male', 'Yes', ''),
('PER620138', 'zeineb', 'Z17/101', '', '', '2003-12-21', 'MA', 'Male', 'Yes', ''),
('PER620154', 'zeineb', 'Z17/118', '', '', '2005-12-21', 'MA', 'Male', 'Yes', ''),
('PER620145', 'zeineb', 'Z17/120', '', '', '2005-12-21', 'MA', 'Male', 'Yes', ''),
('PER620155', 'zeineb', 'Z17/57', '', '', '1967-12-20', 'MA', 'Female', 'Yes', ''),
('PER620164', 'zeineb', 'Z17/63', '', '', '2010-12-20', 'MA', 'Male', 'Yes', ''),
('PER620140', 'zeineb', 'Z17/62', '', '', '1977-12-20', 'MA', 'Female', 'Yes', ''),
('PER620136', 'zeineb', 'Z17/74', '', '', '1982-12-20', 'MA', 'Female', 'Yes', ''),
('PER620134', 'zeineb', 'Z17/84', '', '', '2010-12-21', 'MA', 'Male', 'Yes', '');

-- --------------------------------------------------------

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
  `LESION_AGE` date DEFAULT NULL,
  `DIAMETREMax` int(5) DEFAULT NULL,
  `DIAMETREMin` int(5) DEFAULT NULL,
  `HIGHT` int(5) DEFAULT NULL,
  `LOCALISATION` varchar(20) DEFAULT NULL,
  `DESCRIPTION` mediumtext,
  `DATE_EXTRACTION` date DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sample`
--

INSERT INTO `sample` (`ID_SAMPLE`, `PATIENT_IDENTIFIER`, `SPECIES`, `LOGINUSER`, `LESION_SITE_SAMPLED`, `SAMPLING_METHOD`, `TYPE_OF_SAMPLE_SUPPORT_`, `DIRECT_EXAMINATION`, `ABUDANCE_ON_THE_SMEAR`, `LESION_AGE`, `DIAMETREMax`, `DIAMETREMin`, `HIGHT`, `LOCALISATION`, `DESCRIPTION`, `DATE_EXTRACTION`) VALUES
('PER520114-1', 'PER520114', 'Not Identified', 'zeineb', '', 'Scrapping, Swab', 'N/A', 'N/A', 'N/A', '2017-04-01', 0, 0, 0, '42', 'Ulcerative crusty', '2018-04-18'),
('PER520119-1', 'PER520119', 'Not Identified', 'zeineb', '', 'Scrapping, Swab', 'N/A', 'N/A', 'N/A', '1990-01-01', 0, 30, 0, '42', 'Ulcerative crusty, Nodules pseudosporotrichoides', '2018-04-04'),
('PER520104-1', 'PER520104', 'Not Identified', 'zeineb', '', 'N/A', 'N/A', 'N/A', 'N/A', '1990-01-01', 0, 0, 0, '42', 'N/A', '2018-03-07'),
('PER520116-1', 'PER520116', 'Not Identified', 'zeineb', '', 'Scrapping', 'N/A', 'N/A', 'N/A', '2017-02-01', 0, 0, 0, '43', 'N/A', '2017-12-13'),
('PER520105-1', 'PER520105', 'Not Identified', 'zeineb', '', 'Scrapping, Swab', 'N/A', 'N/A', 'N/A', '2017-05-01', 0, 0, 0, '27', 'Wet, Nodules pseudosporotrichoides', '2017-11-29'),
('PER520101-1', 'PER520101', 'Not Identified', 'zeineb', '', 'Scrapping, Swab', 'N/A', 'N/A', 'N/A', '2017-08-08', 0, 0, 0, '4', 'Dry, Nodules pseudosporotrichoides', '2017-11-23'),
('PER520111-1', 'PER520111', 'Not Identified', 'zeineb', '', 'Scrapping,  Swab', 'N/A', 'NA', 'N/A', '2017-02-01', 0, 0, 0, '7', 'Dry, Nodules pseudosporotrichoides', '2017-11-15'),
('PER520110-1', 'PER520110', 'Not Identified', 'zeineb', '', 'Scrapping, Swab', 'N/A', 'N/A', 'N/A', '2016-10-01', 0, 0, 0, '7', 'Ulcerative crusty, Wet, Nodules pseudosporotrichoides', '2017-11-15'),
('PER520106-1', 'PER520106', 'Not Identified', 'zeineb', '', 'Scrapping, Swab', 'Slide', 'N/A', 'N/A', '2017-04-04', 0, 0, 0, '30', 'Ulcerative crusty, Wet', '2017-11-08'),
('PER520118-1', 'PER520118', 'Not Identified', 'zeineb', '', 'Scrapping', 'N/A', 'N/A', 'N/A', '2017-06-01', 0, 0, 0, '40', 'Dry, Nodules pseudosporotrichoides', '2017-08-16'),
('PER520109-1', 'PER520109', 'Not Identified', 'zeineb', '', 'N/A', 'N/A', 'N/A', 'N/A', '1990-01-01', 0, 0, 0, '42', 'N/A', '2018-04-18'),
('PER520108-1', 'PER520108', 'Not Identified', 'zeineb', '', 'Scrapping', 'N/A', 'N/A', 'N/A', '1990-01-01', 0, 0, 0, '11', 'N/A', '2017-09-05'),
('PER520115-1', 'PER520115', 'Not Identified', 'zeineb', '', 'Scrapping', 'N/A', 'N/A', 'N/A', '2017-07-29', 0, 0, 0, '41', 'Ulcerative crusty', '2017-09-05'),
('PER520113-1', 'PER520113', 'Not Identified', 'zeineb', '', 'Scrapping', 'N/A', 'N/A', 'N/A', '2017-06-01', 0, 0, 0, '3', 'Nodules pseudosporotrichoides', '2017-10-31'),
('PER520107-1', 'PER520107', 'Not Identified', 'zeineb', '', 'Scrapping', 'N/A', 'N/A', 'N/A', '1990-01-01', 0, 0, 0, '16', 'Pseudotumoral', '2017-01-01'),
('PER340088-1', 'PER340088', 'Not Identified', 'zeineb', '', 'Scrapping', 'Slide, RNA later', 'Positive', '+++', '2018-07-11', 0, NULL, NULL, '04', 'Ulcerative crusty, Dry', '2018-01-27'),
('PER340098-1', 'PER340098', 'Not Identified', 'zeineb', '', 'N/A', 'N/A', 'N/A', 'N/A', '2017-10-01', 0, NULL, NULL, '40', 'Other', '2018-01-18'),
('PER340078-1', 'PER340078', 'Not Identified', 'zeineb', '', 'Scrapping', 'Slide, Saline', 'N/A', 'N/A', '2016-12-17', 0, NULL, NULL, '08', 'N/A', '2017-01-17'),
('PER340097-1', 'PER340097', 'Not Identified', 'zeineb', '', 'Scrapping, aspiration', 'Slide, Saline', 'N/A', 'N/A', '2017-12-16', 0, NULL, NULL, '15', 'Ulcerative crusty, Surrounded by a erythematouseruption', '2018-01-04'),
('PER340099-1', 'PER340099', 'Not Identified', 'zeineb', '', 'Scrapping, aspiration', 'Slide, Saline', 'Negative', '', '2017-10-19', 0, NULL, NULL, '35', 'Ulcerative crusty', '2017-11-09'),
('PER340100-1', 'PER340100', 'Not Identified', 'zeineb', '', 'Scrapping, aspiration', 'Slide', 'Positive', '+', '2017-10-24', 0, NULL, NULL, '15', 'Dry', '2017-11-24'),
('PER340094-1', 'PER340094', 'Not Identified', 'zeineb', '', 'Scrapping, aspiration', 'Slide, Saline', 'Positive', '++', '2017-10-30', 0, NULL, NULL, '07', 'Dry, Surrounded by a hyperpigmented rim', '2017-11-30'),
('PER340073-1', 'PER340073', 'Not Identified', 'zeineb', ' 	', 'Scrapping, aspiration', 'Slide, Saline', 'Negative', '', '2017-11-04', 0, NULL, NULL, '15', 'Ulcerative crusty, Surrounded by a erythematouseruption', '2017-12-04'),
('PER340071-1', 'PER340071', 'Not Identified', 'zeineb', '', 'Scrapping, aspiration', 'Slide, Saline', 'Positive', '+', '2017-06-08', 0, NULL, NULL, '33', 'Ulcerative crusty, Surrounded by a erythematouseruption', '2017-07-08'),
('PER340062-1', 'PER340062', 'Not Identified', 'zeineb', '', 'Scrapping, aspiration', 'Slide, Saline', 'Negative', '', '2017-10-14', 0, NULL, NULL, '13', 'Ulcerative crusty, Surrounded by a erythematouseruption', '2017-11-14'),
('PER340064-1', 'PER340064', 'Not Identified', 'zeineb', '', 'Scrapping, aspiration', 'Slide, Saline', 'Positive', 'N/A', '2017-09-14', 0, NULL, NULL, '33', 'Ulcerative crusty', '2017-11-14'),
('PER340086-1', 'PER340086', 'Not Identified', 'zeineb', '', 'Scrapping, Other', 'N/A', 'Negative', '', '2017-10-16', 0, NULL, NULL, '3', 'Ulcerative crusty, Nodules pseudosporotrichoides', '2017-11-16'),
('PER340084-1', 'PER340084', 'Not Identified', 'zeineb', '', 'Scrapping, aspiration', 'Slide', 'Positive', 'N/A', '2018-10-04', 0, NULL, NULL, '3', 'Ulcerative crusty', '2018-01-04'),
('PER340063-1', 'PER340063', 'Not Identified', 'zeineb', '', 'Scrapping', 'Slide, Saline', 'Positive', '+++', '1900-01-01', 0, NULL, NULL, '4', 'Ulcerative crusty, Wet, Infected', '2018-01-27'),
('PER340076-1', 'PER340076', 'Not Identified', 'zeineb', '', 'Scrapping', 'Slide, Saline', 'N/A', 'N/A', '2017-12-20', 0, NULL, NULL, '4', 'Ulcerative crusty, Dry', '2018-01-20'),
('PER340065-1', 'PER340065', 'Not Identified', 'zeineb', '', 'Scrapping, aspiration', 'Slide, Saline', 'N/A', 'N/A', '2017-10-05', 0, NULL, NULL, '3', 'Ulcerative crusty', '2018-01-05'),
('PER340095-1', 'PER340095', 'Not Identified', 'zeineb', '', 'Scrapping, aspiration', 'Slide, Saline', 'Negative', '', '2017-05-01', 0, NULL, NULL, '43', 'Ulcerative crusty', '2018-01-12'),
('PER340066-1', 'PER340066', 'Not Identified', 'zeineb', '', 'Scrapping, aspiration', 'Slide, Saline', 'Positive', '+', '2017-10-11', 0, NULL, NULL, '3', 'Ulcerative crusty', '2018-01-11'),
('PER340060-1', 'PER340060', 'Not Identified', 'zeineb', '', 'Scrapping, aspiration', 'Slide, Saline', 'N/A', 'N/A', '2017-09-22', 0, NULL, NULL, '14', 'Surrounded by a erythematouseruption', '2017-11-22'),
('PER340068-1', 'PER340068', 'Not Identified', 'zeineb', '', 'N/A', 'Slide, Saline', 'Positive', '+', '2017-11-06', 0, NULL, NULL, '42', 'Ulcerative crusty, Surrounded by a erythematouseruption', '2017-11-27'),
('PER340096-1', 'PER340096', 'Not Identified', 'zeineb', '', 'Scrapping, aspiration', 'Slide, Saline', 'Positive', '+', '2017-11-06', 5, NULL, NULL, '43', 'Ulcerative crusty', '2017-12-06'),
('PER340067-1', 'PER340067', 'Not Identified', 'zeineb', '', 'Scrapping', 'Slide, Saline', 'Positive', '++', '1900-01-01', 0, NULL, NULL, '24', 'Ulcerative crusty', '2017-12-07'),
('PER340090-1', 'PER340090', 'Not Identified', 'zeineb', '', 'Scrapping, aspiration', 'Slide, Saline', 'Positive', '+', '2017-11-16', 0, NULL, NULL, '16', 'Ulcerative crusty, Surrounded by a erythematouseruption', '2017-12-16'),
('PER340075-1', 'PER340075', 'Not Identified', 'zeineb', '', 'Scrapping, aspiration', 'Slide, Saline', 'Negative', '', '2017-12-01', 0, NULL, NULL, '7', 'Other', '2017-12-16'),
('PER340091-1', 'PER340091', 'Not Identified', 'zeineb', '', 'Scrapping', 'Slide, Saline', 'Negative', '', '2017-06-12', 0, NULL, NULL, '15', 'Ulcerative crusty', '2018-01-12'),
('PER340089-1', 'PER340089', 'Not Identified', 'zeineb', '', 'Scrapping, aspiration', 'Slide, Saline', 'Negative', '', '2017-12-16', 0, NULL, NULL, '40', 'Ulcerative crusty', '2018-01-16'),
('PER340074-1', 'PER340074', 'Not Identified', 'zeineb', '', 'Scrapping, aspiration', 'Slide, Saline', 'N/A', 'N/A', '2016-12-15', 0, NULL, NULL, '15', 'Ulcerative crusty, Infected', '2017-01-01'),
('PER570058-44', 'PER570058', 'Not Identified', 'zeineb', '', 'Scrapping', 'Slide', 'Positive', '+', '2017-09-19', 30, 20, NULL, '27', 'Ulcerative crusty, Surrounded by a erythematouseruption', '2018-01-19'),
('PER570052-44', 'PER570052', 'Not Identified', 'zeineb', '', 'N/A', 'N/A', 'Negative', '', '2017-12-13', 20, NULL, NULL, '8', 'Ulcerative crusty, Surrounded by a erythematouseruption, Wet', '2018-01-12'),
('PER620132-48', 'PER620132', 'L.Major', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '+++', '1900-01-01', 0, 0, 0, '8', 'Ulcerative crusty', '2017-12-20'),
('PER620123-47', 'PER620123', 'L.Major', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '+', '1900-01-01', 0, 0, 0, '40', 'Ulcerative crusty, Dry', '2017-12-20'),
('PER620147-45', 'PER620147', 'L.Major', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '+++', '1900-01-01', 0, 0, 0, '4', 'Nodules pseudosporotrichoides', '2017-12-19'),
('PER620122-46', 'PER620122', 'L.Major', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '++', '1900-01-01', 0, 0, 0, '7', 'Ulcerative crusty, Dry', '2017-12-20'),
('PER620160-49', 'PER620160', 'L.Major', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '++', '1900-01-01', 0, 0, 0, '7', 'Ulcerative crusty, Dry', '2017-12-20'),
('PER620133-50', 'PER620133', 'L.Major', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '++', '1900-01-01', 0, 0, 0, '8', 'Ulcerative crusty, Dry', '2017-12-20'),
('PER620143-51', 'PER620143', 'Not Identified', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '+++', '1900-01-01', 0, 0, 0, '45', 'Ulcerative crusty, Dry', '2017-12-19'),
('PER620161-52', 'PER620161', 'L.Major', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '++', '1900-01-01', 0, 0, 0, '7', 'Dry, Ulcerative crusty', '2017-12-19'),
('PER620158-53', 'PER620158', 'Not Identified', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '+++', '2017-10-18', 0, 0, 0, '8', 'Nodules pseudosporotrichoides', '2017-12-19'),
('PER620159-54', 'PER620159', 'L.Major', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '+++', '1900-01-01', 0, 0, 0, '41', 'Ulcerative crusty, Dry', '2017-12-19'),
('PER620151-55', 'PER620151', 'Not Identified', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '+', '2017-10-18', 0, 0, 0, '8', 'N/A', '2017-12-19'),
('PER620135-56', 'PER620135', 'Not Identified', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '++', '1900-01-01', 0, 0, 0, '7', 'Nodules pseudosporotrichoides', '2017-12-19'),
('PER620135-57', 'PER620135', 'Not Identified', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '++', '1900-01-01', 0, 0, 0, '7', 'Nodules pseudosporotrichoides', '2017-12-19'),
('PER620141-58', 'PER620141', 'Not Identified', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '+', '1900-01-01', 0, 0, 0, '7', 'Nodules pseudosporotrichoides', '2017-12-19'),
('PER620129-59', 'PER620129', 'Not Identified', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '+', '1900-01-01', 0, 0, 0, '7', 'Ulcerative crusty', '2017-12-15'),
('PER620163-60', 'PER620163', 'Not Identified', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '+', '1900-01-01', 0, 0, 0, '8', 'N/A', '2017-12-19'),
('PER620152-61', 'PER620152', 'Not Identified', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '+', '1900-01-01', 0, 0, 0, '8', 'Nodules pseudosporotrichoides', '2017-12-15'),
('PER620127-62', 'PER620127', 'Not Identified', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '+', '2017-12-19', 0, 0, 0, '8', 'Ulcerative crusty', '2017-12-19'),
('PER620148-63', 'PER620148', 'Not Identified', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '+++', '2017-12-20', 0, 0, 0, '7', 'Nodules pseudosporotrichoides', '2017-12-20'),
('PER620125-64', 'PER620125', 'Not Identified', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '++', '1900-01-01', 0, 0, 0, '43', 'Ulcerative crusty', '2017-12-19'),
('PER620150-65', 'PER620150', 'Not Identified', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '+', '1900-01-01', 0, 0, 0, '7', 'Ulcerative crusty, Dry', '2017-12-20'),
('PER620156-66', 'PER620156', 'Not Identified', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '++', '1900-01-01', 0, 0, 0, '45', 'Ulcerative crusty', '2017-12-21'),
('PER620124-67', 'PER620124', 'Not Identified', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '++', '1900-01-01', 0, 0, 0, '3', 'Ulcerative crusty', '2017-12-21'),
('PER620138-68', 'PER620138', 'Not Identified', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '+++', '1900-01-01', 0, 0, 0, '8', 'Ulcerative crusty, Dry', '2017-12-21'),
('PER620154-69', 'PER620154', 'Not Identified', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '++', '1900-01-01', 0, 0, 0, '8', 'Nodules pseudosporotrichoides', '2017-12-21'),
('PER620145-70', 'PER620145', 'Not Identified', 'zeineb', '', 'Scrapping', 'TE, Slide', 'N/A', 'N/A', '1900-01-01', 0, 0, 0, '40', 'Ulcerative crusty, Dry', '2017-12-21'),
('PER620155-71', 'PER620155', 'Not Identified', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '++', '1900-01-01', 0, 0, 0, '7', 'Nodules pseudosporotrichoides', '2017-12-20'),
('PER620164-72', 'PER620164', 'Not Identified', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '+++', '1900-01-01', 0, 0, 0, '40', 'Ulcerative crusty', '2017-12-20'),
('PER620140-73', 'PER620140', 'Not Identified', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '+++', '1900-01-01', 0, 0, 0, '7', 'Nodules pseudosporotrichoides', '2017-12-20'),
('PER620136-74', 'PER620136', 'Not Identified', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '++', '1900-01-01', 0, 0, 0, '3', 'Ulcerative crusty, Dry', '2017-12-20'),
('PER620134-75', 'PER620134', 'Not Identified', 'zeineb', '', 'Scrapping', 'TE, Slide', 'Positive', '++', '1900-01-01', 0, 0, 0, '41', 'Nodules pseudosporotrichoides', '2017-12-21');

-- --------------------------------------------------------

--
-- Table structure for table `travel_residency`
--

CREATE TABLE `travel_residency` (
  `IDMVT` char(20) NOT NULL,
  `CITY` char(40) NOT NULL,
  `LOGINUSER` char(100) NOT NULL,
  `PATIENT_IDENTIFIER` char(50) NOT NULL,
  `FROMDATE` date DEFAULT NULL,
  `TODATE` int(10) DEFAULT NULL,
  `BYTENOT` char(15) DEFAULT NULL,
  `RESIDENCY` char(10) DEFAULT NULL,
  `TYPE` char(5) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `travel_residency`
--

INSERT INTO `travel_residency` (`IDMVT`, `CITY`, `LOGINUSER`, `PATIENT_IDENTIFIER`, `FROMDATE`, `TODATE`, `BYTENOT`, `RESIDENCY`, `TYPE`) VALUES
('PER520116-9', 'Syria, Aleppo, NA', 'zeineb', 'PER520116', '2000-01-01', NULL, 'N/A', 'No', 'N/A'),
('PER520116', 'Lebanon, Beirut, NA', 'zeineb', 'PER520116', '2017-03-01', NULL, 'N/A', 'Yes', 'N/A'),
('PER520105-7', 'Lebanon, NA, Jiyyeh', 'zeineb', 'PER520105', '2016-05-01', NULL, 'N/A', 'Yes', 'N/A'),
('PER520105-6', 'Syria, Aleppo, NA', 'zeineb', 'PER520105', '2016-01-01', NULL, 'N/A', 'No', 'N/A'),
('PER520101-5', 'Lebanon, NA, Jiyyeh', 'zeineb', 'PER520101', '2016-12-05', NULL, 'N/A', 'Yes', 'N/A'),
('PER5250111-4', 'Lebanon, NA, Fanar', 'zeineb', 'PER5250111', '2017-09-01', NULL, 'N/A', 'Yes', 'N/A'),
('PER520110-3', 'Syria, Aleppo, NA', 'zeineb', 'PER520110', '2016-10-01', NULL, 'N/A', 'N/A', 'N/A'),
('PER520106-2', 'Lebanon, NA, Jiyyeh', 'zeineb', 'PER520106', '2016-05-01', NULL, 'No', 'Yes', 'N/A'),
('PER520118-1', 'Lebanon, Beirut, NA', 'zeineb', 'PER520118', '2017-01-01', NULL, 'No', 'Yes', 'N/A'),
('PER520104-10', 'Syria, Aleppo, NA', 'zeineb', 'PER520104', '2017-03-01', NULL, 'N/A', 'No', 'N/A'),
('PER520119-11', 'Syria, NA, Rakka', 'zeineb', 'PER520119', '2016-01-01', NULL, 'N/A', 'No', 'N/A'),
('PER520114-12', 'Syria, Aleppo, NA', 'zeineb', 'PER520114', '2017-04-01', NULL, 'N/A', 'N/A', 'N/A'),
('PER520109-13', 'Syria, Aleppo, NA', 'zeineb', 'PER520109', '2017-09-01', NULL, 'N/A', 'N/A', 'N/A'),
('PER520108-14', 'Syria, Aleppo, NA', 'zeineb', 'PER520108', '2007-01-01', NULL, 'No', 'No', 'N/A'),
('PER520108-15', 'Lebanon, Beirut, Sabra', 'zeineb', 'PER520108', '2017-05-01', NULL, 'No', 'Yes', 'N/A'),
('PER520115-16', 'Syria, Aleppo, NA', 'zeineb', 'PER520115', '2005-01-01', NULL, 'No', 'No', 'N/A'),
('PER520115-17', 'Lebanon, Beirut, Sabra', 'zeineb', 'PER520115', '2017-05-01', NULL, 'No', 'Yes', 'N/A'),
('PER520113-18', 'Syria, NA, Hamma', 'zeineb', 'PER520113', '2008-04-01', NULL, 'No', 'Yes', 'N/A'),
('PER520107-19', 'Syria, NA, Edleb', 'zeineb', 'PER520107', '1966-01-01', NULL, 'Yes', 'No', 'N/A'),
('PER520107-20', 'Lebanon, NA, Ajaltoun', 'zeineb', 'PER520107', '2017-01-01', NULL, 'Yes', 'Yes', 'N/A'),
('PER340088-21', 'Tunisia, Sidi Bouzid, NA', 'zeineb', 'PER340088', '2017-09-01', NULL, 'No', 'No', 'N/A'),
('PER340098-22', 'Tunisia, Gafsa,NA', 'zeineb', 'PER340098', '2017-08-01', NULL, 'No', 'No', 'N/A'),
('PER340078-23', 'Tunisia, Kasserine, Chaanbi', 'zeineb', 'PER340078', '2017-09-01', NULL, 'No', 'No', 'N/A'),
('PER340097-24', 'Tunisia, Mahdia, Hebira', 'zeineb', 'PER340097', '2017-12-01', NULL, 'No', 'No', 'N/A'),
('PER340099-25', 'Tunisia, Sousse, Tafela', 'zeineb', 'PER340099', '2002-11-09', NULL, 'Yes', 'Yes', 'N/A'),
('PER340100-26', 'Tunisia, Mahdia, Mharza', 'zeineb', 'PER340100', '2017-11-01', 4, 'Yes', 'No', 'N/A'),
('PER340094-27', 'Tunisia, Kairouan, NA', 'zeineb', 'PER340094', '2016-12-01', NULL, 'No', 'No', 'N/A'),
('PER340094-28', 'Tunisia, Mahdia, Ould chemk', 'zeineb', 'PER340094', '2017-07-01', 2, 'No', 'No', 'N/A'),
('PER340073-29', 'Tunisia, Sidi Bouzid, Centre', 'zeineb', 'PER340073', '2017-06-01', NULL, 'No', 'No', 'N/A'),
('PER340071-30', 'Tunisia, Mahdia, Sidi hassin', 'zeineb', 'PER340071', '2017-06-01', NULL, 'No', 'Yes', 'N/A'),
('PER340062-31', 'Tunisia, Kairouan, Chebika', 'zeineb', 'PER340062', '2017-09-14', NULL, 'No', 'No', 'N/A'),
('PER340064-32', 'Tunisia, Sidi Bouzid, Mazuna', 'zeineb', 'PER340064', '2017-06-01', NULL, 'N/A', 'No', 'N/A'),
('PER340086-33', 'Tunisia, Medenine, Ben Gardane', 'zeineb', 'PER340086', '2017-06-01', 1, 'No', 'No', 'N/A'),
('PER340084-34', 'Tunisia, Gabes, Hama', 'zeineb', 'PER340084', '2017-10-04', NULL, 'No', 'No', 'N/A'),
('PER340063-35', 'Tunisia, Gafsa, Mitlaoui', 'zeineb', 'PER340063', '2017-09-01', 1, 'No', 'No', 'N/A'),
('PER340076-36', 'Tunisia, Kairouan, Nasrallah', 'zeineb', 'PER340076', '2017-08-01', 2, 'No', 'No', 'N/A'),
('PER340066-37', 'Tunisia, Sidi Bouzid, NA', 'zeineb', 'PER340066', '2017-10-01', NULL, 'No', 'No', 'N/A'),
('PER340068-38', 'Tunisia, Kairouan, Nasrallah', 'zeineb', 'PER340068', '2017-09-01', 1, 'Yes', 'No', 'N/A'),
('PER340067-39', 'Tunisia, Sidi Bouzid, Jelma', 'zeineb', 'PER340067', '2017-09-01', 2, 'Yes', 'No', 'N/A'),
('PER340090-40', 'Tunisia, Mahdia, Hbira', 'zeineb', 'PER340090', '1963-06-21', NULL, 'Yes', 'Yes', 'N/A'),
('PER340075-41', 'Tunisia, Mahdia, Chorbene', 'zeineb', 'PER340075', '2017-12-01', 2, 'No', 'No', 'N/A'),
('PER340091-42', 'Tunisia, Sousse, Hay riadh', 'zeineb', 'PER340091', '1987-01-03', NULL, 'Yes', 'Yes', 'N/A'),
('PER340089-43', 'Tunisia, Kairouan, Hajb laayoun', 'zeineb', 'PER340089', '2017-09-01', NULL, 'No', 'No', 'N/A'),
('PER620161-56', 'Morocco, NA, NA', 'zeineb', 'PER620161', '1982-12-19', NULL, 'N/A', 'Yes', 'N/A'),
('PER570052-45', 'Tunisia, Tataouine, Tala', 'zeineb', 'PER570052', '1964-08-27', NULL, 'Yes', 'Yes', 'N/A'),
('PER620160-52', 'Morocco, NA, NA', 'zeineb', 'PER620160', '1977-12-20', NULL, 'N/A', 'Yes', 'N/A'),
('PER570058-47', 'Libya, Tripoli, NA', 'zeineb', 'PER570058', '2017-09-01', NULL, 'No', 'No', 'N/A'),
('PER620132-51', 'Morocco, NA, NA', 'zeineb', 'PER620132', '2004-12-20', NULL, 'N/A', 'Yes', 'N/A'),
('PER620122-49', 'Morocco, NA, NA', 'zeineb', 'PER620122', '1977-12-20', NULL, 'N/A', 'Yes', 'N/A'),
('PER570058-83', 'Tunisia, Tunis, NA', 'zeineb', 'PER570058', '1979-09-01', 0, 'N/A', 'Yes', 'N/A'),
('PER620143-55', 'Morocco, NA, Zagora', 'zeineb', 'PER620143', '1990-01-01', 0, 'N/A', 'N/A', 'N/A'),
('PER620158-57', 'Morocco,  NA, NA', 'zeineb', 'PER620158', '1987-12-19', NULL, 'N/A', 'Yes', 'N/A'),
('PER620159-58', 'Morocco, NA, NA', 'zeineb', 'PER620159', '2012-12-19', NULL, 'N/A', 'Yes', 'N/A'),
('PER620147-48', 'Morocco, NA, NA', 'zeineb', 'PER620147', '1967-12-19', NULL, 'N/A', 'Yes', 'N/A'),
('PER620133-53', 'Morocco, NA, Na', 'zeineb', 'PER620133', '1977-12-20', NULL, 'N/A', 'Yes', 'N/A'),
('PER620123-50', 'Morocco, NA, NA', 'zeineb', 'PER620123', '2010-12-20', NULL, 'N/A', 'Yes', 'N/A'),
('PER620143-54', 'Morocco, NA,  Tinzouline', 'zeineb', 'PER620143', '2012-12-19', 0, 'N/A', 'Yes', 'N/A'),
('PER5250111', 'Syria, Aleppo, NA', 'zeineb', 'PER520111', '2012-05-15', NULL, 'N/A', 'No', 'N/A'),
('PER520104', 'Lebanon, NA, Bir hasan', 'zeineb', 'PER520104', '2017-03-01', NULL, 'N/A', 'Yes', 'N/A'),
('PER520119-2', 'Lebanon, NA, Bourj Hammoud', 'zeineb', 'PER520119', '2016-01-01', NULL, 'N/A', 'Yes', 'N/A'),
('PER340088-62', 'Tunisia, Sousse, Cite olympique', 'zeineb', 'PER340088', '2008-08-18', 0, 'No', 'Yes', 'N/A'),
('PER340098-63', 'Tunisia, Kasserine, NA', 'zeineb', 'PER340098', '1978-01-01', 0, 'No', 'Yes', 'N/A'),
('PER340078-64', 'Tunisia, Sousse, Tafala', 'zeineb', 'PER340078', '1951-01-01', 0, 'No', 'Yes', 'N/A'),
('PER340097-65', 'Tunisia, Sousse, Sahloul', 'zeineb', 'PER340097', '1960-02-21', NULL, 'No', 'Yes', 'N/A'),
('PER340100-66', 'Tunisia, Mahdia, Souassi', 'zeineb', 'PER340100', '2005-06-15', NULL, 'Yes', 'Yes', 'N/A'),
('PER340094-67', 'Tunisia, Sousse, Sousse', 'zeineb', 'PER340094', '1989-06-20', NULL, 'No', 'Yes', 'N/A'),
('PER340073-68', 'Tunisia, Sousse, Thrayet', 'zeineb', 'PER340073', '2003-01-01', 0, 'N/A', 'Yes', 'N/A'),
('PER340071-69', 'Tunisia, Sousse, Hay riadh', 'zeineb', 'PER340071', '1966-01-01', 0, 'No', 'Yes', 'N/A'),
('PER340062-70', 'Tunisia, Sousse, Hay riadh', 'zeineb', 'PER340062', '1993-11-02', 0, 'No', 'Yes', 'N/A'),
('PER340064-71', 'Tunisia, Sousse, kala sghira', 'zeineb', 'PER340064', '2009-06-26', 0, 'N/A', 'Yes', 'N/A'),
('PER340086-72', 'Tunisia, Sousse, Msaken', 'zeineb', 'PER340086', '1995-08-14', 0, 'No', 'Yes', 'N/A'),
('PER340084-73', 'Tunisia, Monastir, Sahline', 'zeineb', 'PER340084', '1985-10-15', 0, 'N/A', 'Yes', 'N/A'),
('PER340084-74', 'Tunisia, Sousse, Hamam Sousse', 'zeineb', 'PER340084', '1985-10-15', 0, 'N/A', 'Yes', 'N/A'),
('PER340076-75', 'Tunisia, Sousse, NA', 'zeineb', 'PER340076', '2010-08-18', 0, 'N/A', 'Yes', 'N/A'),
('PER340095-76', 'Tunisia, Sousse, Sahloul', 'zeineb', 'PER340095', '1955-09-19', 0, 'N/A', 'Yes', 'N/A'),
('PER340065-77', 'Tunisia, Sidi Bouzid, NA', 'zeineb', 'PER340065', '1977-03-18', 0, 'N/A', 'Yes', 'N/A'),
('PER340066-78', 'Tunisia, Kairouan, Hajb laayoun', 'zeineb', 'PER340066', '1994-08-20', 0, 'N/A', 'Yes', 'N/A'),
('PER340060-79', 'Tunisia, Sousse, Kala Kbira', 'zeineb', 'PER340060', '1977-02-19', 0, 'N/A', 'Yes', 'N/A'),
('PER340068-80', 'Tunisia, Sousse, Sousse', 'zeineb', 'PER340068', '2011-05-02', 0, 'N/A', 'Yes', 'N/A'),
('PER340096-81', 'Tunisia, Mahdia, Hebira', 'zeineb', 'PER340096', '2013-08-26', 0, 'No', 'Yes', 'N/A'),
('PER340067-82', 'Tunisia, Sousse, Sousse', 'zeineb', 'PER340067', '2016-10-14', 0, 'N/A', 'Yes', 'N/A'),
('PER340075-83', 'Tunisia, Monastir, Ksar hellal', 'zeineb', 'PER340075', '1982-11-21', 0, 'N/A', 'Yes', 'N/A'),
('PER340075-84', 'Tunisia, Mahdia, Chorbene', 'zeineb', 'PER340075', '1982-11-21', 0, 'No', 'Yes', 'N/A'),
('PER620151-84', 'Morocco, NA, NA', 'zeineb', '	  PER620151', '1900-01-01', NULL, 'N/A', 'Yes', 'N/A'),
('PER620135-85', 'Morocco, NA, Zaouia Amadagh', 'zeineb', '', '1998-12-19', NULL, 'N/A', 'Yes', 'N/A'),
('PER620141-86', 'Morocco, NA, NA', 'zeineb', '', '2005-12-19', NULL, 'N/A', 'Yes', 'N/A'),
('PER620129-87', 'Morocco, NA,  Kasba', 'zeineb', '', '2010-12-15', NULL, 'N/A', 'Yes', 'N/A'),
('PER620163-88', 'Morocco, NA, NA', 'zeineb', '', '1992-12-19', NULL, 'N/A', 'Yes', 'N/A'),
('PER620152-89', 'Morocco, NA, NA', 'zeineb', '', '2007-12-15', NULL, 'N/A', 'Yes', 'N/A'),
('PER620127-90', 'Morocco, NA, Kasba', 'zeineb', '', '2014-12-19', NULL, 'N/A', 'Yes', 'N/A'),
('PER620148-91', 'Morocco, NA,  Tanzouline', 'zeineb', '', '1900-01-01', NULL, 'N/A', 'Yes', 'N/A'),
('PER620125-92', 'Morocco, NA, NA', 'zeineb', '', '2010-12-19', NULL, 'N/A', 'Yes', 'N/A'),
('PER620150-93', 'Morocco, NA, NA', 'zeineb', '', '1967-12-20', NULL, 'N/A', 'Yes', 'N/A'),
('PER620156-94', 'Morocco, NA, NA', 'zeineb', '', '2010-12-21', NULL, 'N/A', 'Yes', 'N/A'),
('PER620124-95', 'Morocco, NA, NA', 'zeineb', '', '2006-12-21', NULL, 'N/A', 'Yes', 'N/A'),
('PER620138-96', 'Morocco, NA, NA', 'zeineb', '', '2003-12-21', NULL, 'N/A', 'Yes', 'N/A'),
('PER620154-97', 'Morocco, NA, NA', 'zeineb', '', '2005-12-21', NULL, 'N/A', 'Yes', 'N/A'),
('PER620145-98', 'Morocco, NA, NA', 'zeineb', '', '2005-12-21', NULL, 'N/A', 'Yes', 'N/A'),
('PER620155-99', 'Morocco, NA, NA', 'zeineb', '', '1967-12-20', NULL, 'N/A', 'Yes', 'N/A'),
('PER620164-100', 'Morocco, NA, NA', 'zeineb', '', '2010-12-20', NULL, 'N/A', 'Yes', 'N/A'),
('PER620140-101', 'Morocco, NA, Amerdoul', 'zeineb', '', '1977-12-20', NULL, 'N/A', 'Yes', 'N/A'),
('PER620136-102', 'Morocco, NA, NA', 'zeineb', '', '1982-12-20', NULL, 'N/A', 'Yes', 'N/A'),
('PER620134-103', 'Morocco, NA, NA', 'zeineb', '', '2010-12-21', NULL, 'N/A', 'Yes', 'N/A');

-- --------------------------------------------------------

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
-- Dumping data for table `treatmenthistory`
--

INSERT INTO `treatmenthistory` (`IDTREATMENT`, `PATIENT_IDENTIFIER`, `TREATMENT_TYPE`, `PRESCRIBEDFOR`, `START_DATE`, `POSOLOGY`, `ADMINROUTE`, `INJECTION_NUMBER`, `DURATIONN`, `HEALING_DATE`) VALUES
('Treatment2', 'PER520106', 'Glucantime', 'Leishmania', '2017-10-10', '0', 'N/A', 1, '0', ''),
('Treatment1', 'PER520118', 'Glucantime', 'Leishmania', '2017-08-16', '7.2 cc', 'IL', 7, '16', ''),
('Treatment3', 'PER520110', 'N/A', 'N/A', '2017-11-15', '0', 'N/A', 0, '0', ''),
('Treatment4', 'PER520111', 'Glucantime', 'Leishmania', '2017-09-01', '0', 'N/A', 10, '12', ''),
('Treatment5', 'PER520101', 'Glucantime', 'Leishmania', '2017-11-23', '0', '	 N/A', 2, '0', ''),
('Treatment6', 'PER520105', 'Glucantime', 'Leishmania', '2017-11-29', '0', 'N/A', 1, '1', ''),
('Treatment7', 'PER520116', 'Glucantime', 'Leishmania', '2017-12-13', '0', 'N/A', 0, '0', ''),
('Treatment8', 'PER520104', 'Glucantime', 'Leishmania', '2018-03-07', '0', 'N/A', 0, '0', ''),
('Treatment9', 'PER520119', 'N/A', 'Leishmania', '2018-04-04', '0', 'N/A', 0, '0', ''),
('Treatment10', 'PER520114', 'Glucantime', 'Leishmania', '2018-02-01', '0', 'N/A', 4, '0', ''),
('Treatment11', 'PER520113', 'Glucantime', 'Leishmania', '2017-10-31', '0', 'N/A', 0, '0', ''),
('Treatment12', 'PER520107', 'Antibiotics', 'N/A', '2017-01-01', '0', 'N/A', 0, '0', ''),
('Treatment13', 'PER340098', 'Glucantime', 'Leishmania', '2017-10-01', '0', 'IM', 14, '3', ''),
('Treatment14', 'PER340078', 'Other', 'N/A', '1990-01-01', '0', 'Topical', 0, '1', ''),
('Treatment15', 'PER340097', 'Antibiotics', 'N/A', '1990-01-01', '0', 'N/A', 0, '2', ''),
('Treatment16', 'PER340073', 'Antibiotics', 'N/A', '1990-01-01', '0', 'N/A', 0, '1', ''),
('Treatment17', 'PER340071', 'Antibiotics', 'N/A', '1990-01-01', '0', 'N/A', 0, '2', ''),
('Treatment18', 'PER340086', 'Antibiotics', 'N/A', '1990-01-01', '0', 'N/A', 0, '1', ''),
('Treatment19', 'PER340063', 'Antibiotics', 'N/A', '1900-01-01', '0', 'N/A', 0, '4', ''),
('Treatment20', 'PER340076', 'Antibiotics', 'N/A', '2018-01-10', '0', 'N/A', 0, '1', ''),
('Treatment21', 'PER340095', 'Antibiotics', 'N/A', '1900-01-01', '0', 'N/A', 0, '2', ''),
('Treatment22', 'PER340065', 'N/A', 'N/A', '1900-01-01', '0', 'Topical', 0, 'NA', ''),
('Treatment23', 'PER340066', 'Other', 'Other', '2018-01-06', '0', 'N/A', 0, '1', ''),
('Treatment24', 'PER340068', 'Antibiotics', 'N/A', '2017-11-11', '0', 'N/A', 0, '1', ''),
('Treatment25', 'PER340096', 'Other', 'N/A', '1900-01-01', '0', 'Topical', 0, 'NA', ''),
('Treatment26', 'PER340067', 'Other', 'N/A', '2017-11-01', '0', 'Topical', 0, '2', ''),
('Treatment27', 'PER340090', 'Other', 'N/A', '1900-01-01', '0', 'Topical', 0, 'NA', ''),
('Treatment28', 'PER340075', 'Antibiotics', 'N/A', '1900-01-01', '0', 'N/A', 0, '1', ''),
('Treatment29', 'PER340091', 'Antibiotics', 'N/A', '2017-12-15', '0', 'N/A', 0, '2', ''),
('Treatment30', 'PER340089', 'N/A', 'N/A', '1900-01-01', '0', 'N/A', 0, 'NA', ''),
('Treatment31', 'PER340074', 'Antibiotics, Glucantime', 'N/A', '2016-12-15', '0', 'N/A', 0, '2', ''),
('Treatment45', 'PER620161', 'Glucantime', 'Leishmania', '2017-12-11', '0', 'N/A', 1, '1', '1900-01-01'),
('Treatment33', 'PER570058', 'Other', 'Other', '1900-01-01', '0', 'N/A', 0, '0', ''),
('Treatment37', 'PER620160', 'Glucantime', 'Leishmania', '2017-12-20', '0', 'N/A', 0, '0', ''),
('Treatment34', 'PER620147', 'Other', 'N/A', '1900-01-01', '0', 'N/A', 0, '0', ''),
('Treatment36', 'PER620132', 'Glucantime', 'Leishmania', '2017-12-20', '0', 'N/A', 0, '0', ''),
('Treatment35', 'PER620122', 'Glucantime', 'Leishmania', '2017-12-20', '0', 'N/A', 0, '0', ''),
('Treatment38', 'PER620133', 'Antibiotics', 'N/A', '1900-01-01', '0', 'N/A', 0, '0', ''),
('Treatment39', 'PER620133', 'Glucantime', 'Leishmania', '2017-12-20', '0', 'N/A', 0, '0', ''),
('Treatment40', 'PER620143', 'Glucantime', 'Leishmania', '2017-12-11', '0', 'N/A', 2, '1', ''),
('Treatment41', 'PER620143', 'Glucantime', 'Leishmania', '2017-12-19', '0', 'N/A', 0, '0', ''),
('Treatment42', 'PER620158', 'Glucantime', 'Leishmania', '2017-12-19', '0', 'N/A', 0, '0', ''),
('Treatment02', 'PER520106', 'Glucantime', 'Leishmania', '2017-11-08', '0', 'N/A', 0, '0', ''),
('Treatment04', 'PER520111', 'Glucantime', 'Leishmania', '2017-11-15', '1 cc\r\n', 'IL', 0, '0', ''),
('Treatment-010', 'PER520114', 'Glucantime', 'Leishmania', '2018-04-18', '0', 'N/A', 0, '0', ''),
('Treatment46', 'PER620135', 'Glucantime', 'Leishmania', '2017-12-19', '0', 'N/A', 0, '0', '1900-01-01'),
('Treatment47', 'PER620135', 'Glucantime', 'Leishmania', '2017-12-19', '0', 'N/A', 0, '0', '1900-01-01'),
('Treatment48', 'PER620141', 'Glucantime', 'Leishmania', '2017-12-19', '0', 'N/A', 0, '0', '1900-01-01'),
('Treatment49', 'PER620129', 'Glucantime', 'Leishmania', '2017-12-19', '0', 'N/A', 0, '0', '1900-01-01'),
('Treatment50', 'PER620152', 'Glucantime', 'Leishmania', '2017-12-19', '0', 'N/A', 0, '0', '1900-01-01'),
('Treatment51', 'PER620127', 'Glucantime', 'Leishmania', '2017-12-19', '0', 'N/A', 0, '0', '1900-01-01'),
('Treatment52', 'PER620148', 'Glucantime', 'Leishmania', '2017-12-20', '0', 'N/A', 0, '0', '1900-01-01'),
('Treatment53', 'PER620150', 'Glucantime', 'Leishmania', '2017-12-20', '0', 'N/A', 0, '0', '1900-01-01'),
('Treatment54', 'PER620156', 'Other', 'N/A', '1900-01-01', '0', 'N/A', 0, '0', '1900-01-01'),
('Treatment55', 'PER620156', 'Glucantime', 'Leishmania', '2017-12-21', '0', 'N/A', 0, '0', '1900-01-01'),
('Treatment56', 'PER620124', 'Antibiotics', 'N/A', '1900-01-01', '0', 'N/A', 0, '0', '1900-01-01'),
('Treatment57', 'PER620124', 'Glucantime', 'Leishmania', '2017-12-21', '0', 'N/A', 0, '0', '1900-01-01'),
('Treatment58', 'PER620138', 'Glucantime', 'Leishmania', '2017-12-21', '0', 'N/A', 0, '0', '1900-01-01'),
('Treatment59', 'PER620154', 'Glucantime', 'Leishmania', '2017-12-21', '0', 'N/A', 0, '0', '1900-01-01'),
('Treatment60', 'PER620145', 'Glucantime', 'Leishmania', '2017-12-21', '0', 'N/A', 0, '0', '1900-01-01'),
('Treatment61', 'PER620155', 'Other', 'N/A', '1900-01-01', '0', 'N/A', 0, '0', '1900-01-01'),
('Treatment62', 'PER620155', 'Glucantime', 'Leishmania', '2017-12-20', '0', 'N/A', 0, '0', '1900-01-01'),
('Treatment63', 'PER620164', 'Glucantime', 'Leishmania', '2017-12-20', '0', 'N/A', 0, '0', '1900-01-01'),
('Treatment64', 'PER620140', 'Other', 'N/A', '1900-01-01', '0', 'N/A', 0, '0', '1900-01-01'),
('Treatment65', 'PER620140', 'Glucantime', 'Leishmania', '2017-12-20', '0', 'N/A', 0, '0', '1900-01-01'),
('Treatment66', 'PER620136', 'Antibiotics', 'N/A', '1900-01-01', '0', 'N/A', 0, '0', '1900-01-01'),
('Treatment67', 'PER620136', 'Glucantime', 'Leishmania', '2017-12-20', '0', 'N/A', 0, '0', '1900-01-01'),
('Treatment68', 'PER620134', 'Glucantime', 'Leishmania', '2017-12-21', '0', 'N/A', 0, '0', '1900-01-01');

-- --------------------------------------------------------

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
('super', 'super', 'super1234', 'super', 'IPT'),
('emna', 'super', 'emna', 'normal', 'IPT'),
('zeineb', 'super', 'zeineb', 'normal', 'IPT'),
('maaoui', 'super', 'maaoui', 'normal', 'ISI');

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
  ADD KEY `FK_TREATMEN_ADDTREATM_PATIENT` (`PATIENT_IDENTIFIER`),
  ADD KEY `FK_TREATMEN_USETREATM_TREATMEN` (`TREATMENT_TYPE`);

--
-- Indexes for table `userdata`
--
ALTER TABLE `userdata`
  ADD PRIMARY KEY (`LOGINUSER`),
  ADD KEY `FK_USERDATA_CREATER_USERDATA` (`USE_LOGINUSER`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
