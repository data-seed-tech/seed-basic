/*--------------------------------------------------------------*/
/*--			SYSTEM TABLE FOR SEED CUSTOM APPS				*/
/*--------------------------------------------------------------*/
CREATE TABLE `seed_apps` (
  `appCode` varchar(50) NOT NULL COMMENT 'Primary Key',
  `appName` varchar(100) NOT NULL,
  `appDescription` varchar(1000) NOT NULL,
  `icon` varchar(50) NOT NULL COMMENT 'UNICODE Symbol (https://unicode-table.com/en/blocks/miscellaneous-symbols-and-pictographs/)',
  PRIMARY KEY (`appCode`),
  UNIQUE KEY `appName` (`appName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='SEED Apps definitions'


/*--------------------------------------------------------------*/
/*--					INSERTING SYSTEM APPS					*/
/*--------------------------------------------------------------*/
INSERT INTO seed_apps (appCode, appName, appDescription, icon)
VALUES ('_system', 'System', 'Base App for the entire System', '&#10084;')



/*--------------------------------------------------------------*/
/*--			SYSTEM TABLE FOR APPS CUSTOM MENUS				*/
/*--------------------------------------------------------------*/
CREATE TABLE `seed_menus` (
 `menuId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
 `tableName` varchar(50) NOT NULL COMMENT 'The table that can be accessed with this menu',
 `menuText` varchar(50) NOT NULL COMMENT 'Text displayed for this menu',
 `appCode` varchar(50) NOT NULL COMMENT 'The Seed App that uses this menu. The menu will be visible when a user acess the App.',
 PRIMARY KEY (`menuId`),
 UNIQUE KEY `uniqueTableAndApp` (`tableName`,`appCode`),
 INDEX `appCodeIdx` (`appCode` ASC),
 CONSTRAINT `seed_meniuri_ibfk_1` FOREIGN KEY (`appCode`) REFERENCES `seed_apps` (`appCode`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Seed App menus configuration. A menu is a direct link for editien records for the specified tableName. The menu text is the one specified in menuText.'


INSERT INTO seed_menus (menuId, tableName, menuText, appCode)
VALUES (default, 'seed_apps', 'Seed Apps', '_system');
    


/*--------------------------------------------------------------*/
/*--		SYSTEM TABLE FOR APPS NOMENCLATURES/FILTERS	*/
/*--------------------------------------------------------------*/
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

