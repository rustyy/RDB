-- phpMyAdmin SQL Dump
-- version 3.3.9.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Erstellungszeit: 09. Juni 2012 um 13:32
-- Server Version: 5.5.9
-- PHP-Version: 5.3.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Datenbank: `rdbshop`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `category`
--

CREATE TABLE `category` (
  `category_name` varchar(45) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`category_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `category`
--

INSERT INTO `category` VALUES('Arbeitsspeicher', NULL);
INSERT INTO `category` VALUES('Eingabegeräte', NULL);
INSERT INTO `category` VALUES('Festplatten', NULL);
INSERT INTO `category` VALUES('Mainboards', NULL);
INSERT INTO `category` VALUES('Monitore', NULL);
INSERT INTO `category` VALUES('Smartphone', NULL);
INSERT INTO `category` VALUES('Tablet', NULL);
INSERT INTO `category` VALUES('TV-Geräte', NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(45) NOT NULL,
  `lastname` varchar(45) NOT NULL,
  `street` varchar(255) NOT NULL,
  `zip` int(11) NOT NULL,
  `location` varchar(255) NOT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Daten für Tabelle `customer`
--

INSERT INTO `customer` VALUES(1, 'Eugen', 'Waldschmidt', 'Sievekingsallee 177', 22111, 'Hamburg');
INSERT INTO `customer` VALUES(2, 'Felix', 'Hofmann', 'Tritauer Amtsweg 43h', 22179, 'Hamburg');
INSERT INTO `customer` VALUES(3, 'Ekaterina', 'Usakova', 'Timmendorfer Str. 53', 22147, 'Hamburg');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `manufactura`
--

CREATE TABLE `manufactura` (
  `producer_name` varchar(45) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`producer_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `manufactura`
--

INSERT INTO `manufactura` VALUES('Apple', NULL);
INSERT INTO `manufactura` VALUES('Asus', NULL);
INSERT INTO `manufactura` VALUES('Eizo', NULL);
INSERT INTO `manufactura` VALUES('Logitech', NULL);
INSERT INTO `manufactura` VALUES('OCZ', NULL);
INSERT INTO `manufactura` VALUES('Razor', NULL);
INSERT INTO `manufactura` VALUES('Samsung', NULL);
INSERT INTO `manufactura` VALUES('Sony', NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `order`
--

CREATE TABLE `order` (
  `order_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0',
  `date` datetime DEFAULT NULL,
  `payment_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`order_id`,`customer_id`,`payment_id`),
  KEY `fk_customer_id` (`customer_id`),
  KEY `fk_payment_id` (`payment_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Daten für Tabelle `order`
--

INSERT INTO `order` VALUES(1, 1, '2012-06-09 13:31:35', 1);
INSERT INTO `order` VALUES(2, 2, '2012-06-09 13:31:38', 2);
INSERT INTO `order` VALUES(3, 1, '2012-06-09 13:31:41', 2);
INSERT INTO `order` VALUES(4, 3, '2012-06-09 13:31:45', 3);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `orderitem`
--

CREATE TABLE `orderitem` (
  `product_id` int(10) unsigned NOT NULL DEFAULT '0',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0',
  `amount` varchar(45) DEFAULT '1',
  `session` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `fk_product_id` (`product_id`),
  KEY `fk_order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `orderitem`
--

INSERT INTO `orderitem` VALUES(1, 1, '2', NULL);
INSERT INTO `orderitem` VALUES(2, 2, '2', NULL);
INSERT INTO `orderitem` VALUES(3, 2, '1', NULL);
INSERT INTO `orderitem` VALUES(5, 3, '3', NULL);
INSERT INTO `orderitem` VALUES(5, 4, '1', NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `service` varchar(45) NOT NULL,
  PRIMARY KEY (`payment_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Daten für Tabelle `payment`
--

INSERT INTO `payment` VALUES(1, 'Paypal');
INSERT INTO `payment` VALUES(2, 'Lastschrift');
INSERT INTO `payment` VALUES(3, 'Nachnahme');
INSERT INTO `payment` VALUES(4, 'Rechnung');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `product`
--

CREATE TABLE `product` (
  `product_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `price` int(11) NOT NULL,
  `producer_name` varchar(45) NOT NULL,
  `details` varchar(255) DEFAULT NULL,
  `category_name` varchar(45) NOT NULL,
  PRIMARY KEY (`product_id`,`producer_name`,`category_name`),
  KEY `fk_producer_name` (`producer_name`),
  KEY `fk_category` (`category_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Daten für Tabelle `product`
--

INSERT INTO `product` VALUES(1, 'iPad', 399, 'Apple', NULL, 'Tablet');
INSERT INTO `product` VALUES(2, 'iPhone', 699, 'Apple', NULL, 'Smartphone');
INSERT INTO `product` VALUES(3, 'Naga', 79, 'Razor', NULL, 'Eingabegeräte');
INSERT INTO `product` VALUES(4, 'Rampage II Extreme', 249, 'Asus', NULL, 'Mainboards');
INSERT INTO `product` VALUES(5, 'G11', 69, 'Logitech', NULL, 'Eingabegeräte');
INSERT INTO `product` VALUES(6, 'W23', 499, 'Eizo', NULL, 'Monitore');
INSERT INTO `product` VALUES(7, 'UE46H500', 699, 'Samsung', NULL, 'TV-Geräte');

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `fk_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`payment_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `orderitem`
--
ALTER TABLE `orderitem`
  ADD CONSTRAINT `fk_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `fk_producer_name` FOREIGN KEY (`producer_name`) REFERENCES `manufactura` (`producer_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_category` FOREIGN KEY (`category_name`) REFERENCES `category` (`category_name`) ON DELETE CASCADE ON UPDATE CASCADE;
