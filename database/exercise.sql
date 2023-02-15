CREATE TABLE `customers` (
  `customerId` int NOT NULL AUTO_INCREMENT,
  `customerName` varchar(50) NOT NULL,
  PRIMARY KEY (`customerId`),
  UNIQUE KEY `uniqueCustomer` (`customerName`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4 COMMENT='Customers table for invoicing App exercise';

INSERT INTO customers (customerId, customerName)
VALUES (default, 'AAA. Inc.'), (default, 'BBB Inc.');


CREATE TABLE `invoices` (
  `id` int NOT NULL AUTO_INCREMENT,
  `invoiceNumber` varchar(10) NOT NULL,
  `InvoiceDate` date NOT NULL,
  `customerId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `customer` (`customerId`),
  CONSTRAINT `invoices_ibfk_1` FOREIGN KEY (`customerId`) REFERENCES `customers` (`customerId`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4 COMMENT='Invoices table for invoicing App exercise';


INSERT INTO invoices (id, invoiceNumber, InvoiceDate, customerId)
VALUES (default, '123', '2021-08-15', '1'), (default, '234', '2021-08-15', '2');



CREATE TABLE `invoice_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `invoiceId` int NOT NULL,
  `productName` varchar(100) NOT NULL,
  `quantity` decimal(10,0) NOT NULL,
  `price` decimal(10,0) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice` (`invoiceId`),
  CONSTRAINT `invoice_details_ibfk_1` FOREIGN KEY (`invoiceId`) REFERENCES `invoices` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4 COMMENT='Invoices table for invoicing App exercise';


INSERT INTO invoice_details (id, invoiceId, productName, quantity, price)
VALUES (default, '1', 'Computer', '1', '1000'), (default, '2', 'Printer', '1', '500');



INSERT INTO seed_apps (appCode, appName, appDescription, icon)
VALUES ('invoicing', 'Invoicing', 'Exercise: Creating invoicing App', '&#128209;');


INSERT INTO seed_menus (menuId, tableName, menuText, appCode)
VALUES (default, 'invoices', 'Invoices', 'invoicing'),
(default, 'customers', 'Customers', 'invoicing');


INSERT INTO seed_nomenclatures (nomenclatureId, tableName, filterText, appCode)
VALUES (default, 'customers', 'Customers', 'invoicing');