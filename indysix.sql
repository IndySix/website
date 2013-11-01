-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 01, 2013 at 02:13 
-- Server version: 5.6.12
-- PHP Version: 5.5.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `indysix`
--
CREATE DATABASE IF NOT EXISTS `indysix` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `indysix`;

-- --------------------------------------------------------

--
-- Table structure for table `Levels`
--

CREATE TABLE IF NOT EXISTS `Levels` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `part_id` int(10) NOT NULL,
  `order` int(3) NOT NULL,
  `title` varchar(128) NOT NULL,
  `description` text NOT NULL,
  `icon` varchar(128) NOT NULL,
  `example_movie` varchar(128) NOT NULL,
  `one_star_score` int(10) NOT NULL,
  `two_star_score` int(10) NOT NULL,
  `three_star_score` int(10) NOT NULL,
  `four_star_score` int(10) NOT NULL,
  `play_time` int(10) NOT NULL,
  `targetScore` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `Levels`
--

INSERT INTO `Levels` (`id`, `part_id`, `order`, `title`, `description`, `icon`, `example_movie`, `one_star_score`, `two_star_score`, `three_star_score`, `four_star_score`, `play_time`, `targetScore`) VALUES
(1, 1, 1, '50-50 Grind I', 'Perform a 50-50 grind for 25% of the track.<br><br><b>50-50</b><br><i>The 50-50 grind is where both trucks are on the edge.</i>', 'run.png', '50-50', 100, 200, 300, 400, 120, '{"distance":{"value":3,"required":true},"speed":{"value":20,"required":false}}'),
(2, 1, 2, 'Nose Grind I', 'Perform a Nose grind for 25% of the track.<br />\r\n<br />					<b>50-50</b><br />\r\n<i>In a Nosegrind, the skateboard''s front truck grinds a rail or edge, while the back truck is suspended over the rail/edge.</i>', '', '', 100, 200, 300, 400, 120, '');

-- --------------------------------------------------------

--
-- Table structure for table `Level_completed`
--

CREATE TABLE IF NOT EXISTS `Level_completed` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `level_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `score` int(6) NOT NULL,
  `data` text,
  `movie` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `Level_completed`
--

INSERT INTO `Level_completed` (`id`, `level_id`, `user_id`, `timestamp`, `score`, `data`, `movie`) VALUES
(1, 1, 1, '2013-10-24 09:01:49', 100, '-', '-'),
(2, 1, 1, '2013-10-24 09:06:03', 150, '-', '-'),
(3, 1, 1, '2013-10-24 09:06:03', 250, '-', '-'),
(4, 1, 2, '2013-10-29 12:27:22', 300, '', ''),
(5, 2, 1, '2013-10-29 12:39:44', 250, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `LoginSession`
--

CREATE TABLE IF NOT EXISTS `LoginSession` (
  `username` varchar(32) NOT NULL,
  `token` varchar(136) NOT NULL,
  `ip` varchar(15) NOT NULL,
  `loginDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`username`,`token`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `LoginSession`
--

INSERT INTO `LoginSession` (`username`, `token`, `ip`, `loginDate`) VALUES
('maikel', '5827f71021d39923dd0e16425328406a1e919a3b8e60812b37db0a12684508a0aab6abd606468639673f7c2090bfd42faff8ad0a64976319b75670efe4f92408b5002088', '127.0.0.1', '2013-10-15 13:18:55'),
('Jeffrey', '7e99966a9832837df02329eba55b76c618bc7570e7f7eb563609c60f4a57ae26a8db16d62835e19f61bf5506f8560b95d8da9537e3f3a84a9e14a2607f10ea0141f3e6b0', '127.0.0.1', '2013-10-30 13:45:18'),
('Vincent', 'e984c864989a2b72545631eb4745d74c14f6d3dbc352b4c1d63be21a492baaa24c1bb2cb977f3418c64eb8374ab4ada9de8d49075521c932c0237382ec994e58aa6004d4', '127.0.0.1', '2013-10-30 13:45:33'),
('Michiel', '376e1767884316ac66fa7ba0e9367ec421fe0b83dcd18b35ca3677596272ccdaaf07e86e934fdbe5e28ae2641de8b39a9f94ea9fade24e72416d742afbb7c70004bc6368', '127.0.0.1', '2013-10-30 13:45:46'),
('Joost', '916a167f6933536a234197f268d602c00fc52fa6f69fbebe9f75b42c92aa89d9211e504842835d90158f23bc45ee61c7b03fee36993d440da5899fe0a77170eaf26a7df9', '127.0.0.1', '2013-10-30 13:45:56'),
('Charlotte', '5e7bfdfd2e91f2b26dbb645aa9349599b58c1873f85157055a8ab77637b2e24ba362dc629bfcdd021f119ab00a5568adbca86a81b6902780f153148bb6d0c10fcf74e901', '127.0.0.1', '2013-10-30 13:46:05'),
('maikel', '5827f710dc98651e80263bf41d33f5016bcb984207d7e73f0113e9e3b2cb92764356e66406aadd43f35144438ed80854ffddaa3de553dbf1bdc66d6c967b70c53f9e2c46', '127.0.0.1', '2013-10-30 14:54:39');

-- --------------------------------------------------------

--
-- Table structure for table `Parts`
--

CREATE TABLE IF NOT EXISTS `Parts` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `img` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `Parts`
--

INSERT INTO `Parts` (`id`, `name`, `img`) VALUES
(1, 'Grind', 'grind.png');

-- --------------------------------------------------------

--
-- Table structure for table `Tokens`
--

CREATE TABLE IF NOT EXISTS `Tokens` (
  `token` varchar(32) NOT NULL,
  `username` varchar(32) NOT NULL,
  `createDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `type` varchar(16) NOT NULL,
  PRIMARY KEY (`token`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE IF NOT EXISTS `Users` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `password` varchar(136) NOT NULL,
  `email` varchar(255) DEFAULT '',
  `validEmail` tinyint(4) DEFAULT '0',
  `level` int(11) DEFAULT '0',
  `registrationDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `blocked` int(1) NOT NULL DEFAULT '0',
  `current_level_id` int(10) NOT NULL,
  `avatar` varchar(128) NOT NULL,
  `difficulty` varchar(64) NOT NULL DEFAULT 'Semi Pro skater',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`id`, `username`, `password`, `email`, `validEmail`, `level`, `registrationDate`, `blocked`, `current_level_id`, `avatar`, `difficulty`) VALUES
(1, 'maikel', '5827f710bed842c3017fcd83c034288171b600ae193cb9c7e526da2ebdb0e67e440130c3bb9b1fc5532e9dadcd509745c5134384f0ea642579ecf38d6d77dffd0cf42427', '', 0, 0, '2013-10-15 13:18:55', 0, 1, '4242.jpg', 'Pro skater'),
(2, 'Jeffrey', '7e99966a39e9f5da49e5c92d35d8d93b8104a1ee68f32fd1a6ed3978d8e9769de8290782f4d8d509dac2738b7bf67115975e04908e78c43867eee0c7af402e0891fff1d8', '', 0, 0, '2013-10-30 13:45:18', 0, 0, '', 'Semi Pro skater'),
(3, 'Vincent', 'e984c864e0397438d440840cbf2ad40dd579ebad707b19ade7b4635c8ae93152cc5e4d722c3b07fedf8eb47412b171ffbf1718865d8d22bba7ef9bc2075ccb50a65d0bcc', '', 0, 0, '2013-10-30 13:45:33', 0, 0, '', 'Semi Pro skater'),
(4, 'Michiel', '376e1767efdd6dda735498bbb04c3d92faef56173393e866e296604f46fdffd19596c68da78dcecd8df3d806e41c6568efee66ab61a3baff488b51a9caa573cf407f106b', '', 0, 0, '2013-10-30 13:45:46', 0, 0, '', 'Semi Pro skater'),
(5, 'Joost', '916a167f2efa7058740c671593437165be96d94ea44bc85d86c014fe3bcfcac677926113e76dc67dd5294baaa6af8591c08077eaa10af337a6b40788092df12bb554b4ed', '', 0, 0, '2013-10-30 13:45:56', 0, 2, 'joost.jpg', 'Rookie'),
(6, 'Charlotte', '5e7bfdfd971adcf9825486b17149da77eb3bf39976f5ea24bf22a0c3089e3082dd9906d5a1ba2b4b3d7e82028b0004f7785ce3bca5571ce4f754ec2d5df73a31721199e1', '', 0, 0, '2013-10-30 13:46:05', 0, 0, '', 'Semi Pro skater');

-- --------------------------------------------------------

--
-- Table structure for table `User_keys`
--

CREATE TABLE IF NOT EXISTS `User_keys` (
  `key` varchar(128) NOT NULL,
  `user_id` int(10) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `User_keys`
--

INSERT INTO `User_keys` (`key`, `user_id`) VALUES
('02008BAD85', 1),
('02008BB78B', 5),
('1234567890', 1);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
