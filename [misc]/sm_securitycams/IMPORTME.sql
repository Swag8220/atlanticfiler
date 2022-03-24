INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('secworker', 'Overvågnings teknikker', 1)
;
INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('secworker', 'Overvågnings teknikker', 1)
;
INSERT INTO `items` (`name`, `label`) VALUES
	('camtablet', 'Overvågnings Tablet')
;
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('secworker', 'Overvågnings teknikker', 1)
;
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES
	('secworker', 0, 'recruit', 'Arbejder', 2500),
	('secworker', 1, 'boss', 'Chef', 4500)
;
CREATE TABLE `securitycams` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`identifier` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
	`camname` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`camgroup` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`camid` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`model` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
	`coords` LONGTEXT NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
	`heading` LONGTEXT NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
	`mods` VARCHAR(200) NULL DEFAULT '{}' COLLATE 'utf8mb4_general_ci',
	`status` INT(11) NULL DEFAULT '1',
	`ownername` VARCHAR(255) NOT NULL DEFAULT 'Unknown' COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1
;