--------------------------------------------------------------
--				SYSTEM TABLE FOR SEED MODULES				--
--------------------------------------------------------------
CREATE TABLE `seed_modules` (
  `moduleName` varchar(50) NOT NULL COMMENT 'Unique module name. Should not be edited by client',
  `moduleDescription` varchar(500) NOT NULL,
  `installed` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`moduleName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Available modules. Should not be edited by client';


INSERT INTO seed_modules (moduleName, moduleDescription, installed)
VALUES ('AppReporting', 'AppReporting module allows creation of custom reports per App. These reports can be defined by customer and may be used to display alerts when specific values does not meet defined criteria. If Jobs module is installed, then these alerts may be send by email.', '0');



--------------------------------------------------------------
--			SYSTEM TABLE FOR SEED CUSTOM APPS				--
--------------------------------------------------------------
CREATE TABLE `seed_apps` (
  `appCode` varchar(50) NOT NULL COMMENT 'Primary Key',
  `appName` varchar(100) NOT NULL,
  `appDescription` varchar(1000) NOT NULL,
  `icon` varchar(50) NOT NULL COMMENT 'UNICODE Symbol (https://unicode-table.com/en/blocks/miscellaneous-symbols-and-pictographs/)',
  PRIMARY KEY (`appCode`),
  UNIQUE KEY `appName` (`appName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='SEED Apps definitions';


--------------------------------------------------------------
--					INSERTING SYSTEM APPS					--
--------------------------------------------------------------
INSERT INTO seed_apps (appCode, appName, appDescription, icon)
VALUES ('_system', 'System', 'Base App for the entire System', '&#10084;');



--------------------------------------------------------------
--			SYSTEM TABLE FOR APPS CUSTOM MENUS				--
--------------------------------------------------------------
CREATE TABLE `seed_menus` (
 `menuId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
 `tableName` varchar(50) NOT NULL COMMENT 'The table that can be accessed with this menu',
 `menuText` varchar(50) NOT NULL COMMENT 'Text displayed for this menu',
 `appCode` varchar(50) NOT NULL COMMENT 'The Seed App that uses this menu. The menu will be visible when a user acess the App.',
 PRIMARY KEY (`menuId`),
 UNIQUE KEY `uniqueTableAndApp` (`tableName`,`appCode`),
 INDEX `appCodeIdx` (`appCode` ASC),
 CONSTRAINT `seed_meniuri_ibfk_1` FOREIGN KEY (`appCode`) REFERENCES `seed_apps` (`appCode`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Seed App menus configuration. A menu is a direct link for editien records for the specified tableName. The menu text is the one specified in menuText.';



INSERT INTO seed_menus (menuId, tableName, menuText, appCode)
VALUES (default, 'seed_apps', 'Seed Apps', '_system');
    


--------------------------------------------------------------
--		SYSTEM TABLE FOR APPS NOMENCLATURES/FILTERS			--
--------------------------------------------------------------
CREATE TABLE `seed_nomenclatures` (
  `nomenclatureId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `tableName` varchar(50) NOT NULL COMMENT 'The table that can be references this nomenclature',
  `filterText` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT 'Text displayed for the filter menu created automatically',
  `appCode` varchar(50) NOT NULL COMMENT 'The Seed App that uses this nomenclature - it is seen also as a filter menu item.',
  PRIMARY KEY (`nomenclatureId`),
  UNIQUE KEY `nomenclatures` (`tableName`),
  KEY `appCode` (`appCode`),
  CONSTRAINT `seed_nomenclatures_ibfk_1` FOREIGN KEY (`appCode`) REFERENCES `seed_apps` (`appCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Seed App nomenclatures configuration. A nomenclature contains the values that infrequent changed and are used as external reference. Examples: countries, currencies etc. In Seed, nomenclatures are automatically used as filters also.';




/*
---------------------------------------------------
-- NEEDED FOR AppReporting MODULE
---------------------------------------------------
CREATE TABLE `seed_priorities` (
  `priorityId` smallint(6) NOT NULL,
  `priority` char(10) COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`priorityId`),
  UNIQUE KEY `priority` (`priority`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='SEED: priorities nomenclature for report alerts or tasks'

INSERT INTO seed_priorities (priorityId, priority)
VALUES ('1', 'PRIO 1'),
('2', 'PRIO 2'),
('3', 'PRIO 3'),
('4', 'PRIO 4'),
('5', 'PRIO 5');


CREATE TABLE `seed_app_reports` (
  `reportId` varchar(50) NOT NULL,
  `appCode` varchar(50) DEFAULT NULL COMMENT 'Seed App for which the report is created',
  `reportName` varchar(300) NOT NULL,
  `reportDescription` varchar(1000) NOT NULL,
  `sqlReport` varchar(10000) DEFAULT NULL COMMENT 'Report SQL select',
  `activationCriteria` varchar(5000) NOT NULL COMMENT 'Generally it is in a form of a count().',
  `sqlMinCondition` varchar(1000) NOT NULL COMMENT 'Condition to make the report result an alert if activationCriteria is lower than sqlMinCondition',
  `sqlMaxCondition` varchar(100) NOT NULL COMMENT 'Condition to make the report result an alert if activationCriteria is higher than sqlMaxCondition',
  `slowExecution` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Those with slowExecution = 1 are not automatically run on the main page',
  `priority` smallint(6) NOT NULL COMMENT 'Priority of the alert created in case of activationCriteria is lower than sqlMinCondition of higher than sqlMaxCondition. Possible values: 1,2,3,4,5, where 1 is maximum priority',
  `linkAddress` varchar(250) NOT NULL,
  `linkId` varchar(100) NOT NULL,
  `linkDetails` varchar(100) NOT NULL,
  PRIMARY KEY (`reportId`),
  UNIQUE KEY `reportName` (`reportName`),
  KEY `priority` (`priority`),
  KEY `appCode` (`appCode`),
  CONSTRAINT `seed_reports_ibfk_1` FOREIGN KEY (`priority`) REFERENCES `seed_priorities` (`priorityId`),
  CONSTRAINT `seed_reports_ibfk_2` FOREIGN KEY (`appCode`) REFERENCES `seed_apps` (`appCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Seed reportts'
*/
