USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_mechanic', 'Mekaniker', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_mechanic', 'Mekaniker', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('mechanic', 'Mekaniker')
;

INSERT INTO `job_grades` (id,job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	(50,'mechanic',0,'recrue','Lærling',12,'{}','{}'),
	(51,'mechanic',1,'novice','Arbejder',24,'{}','{}'),
	(52,'mechanic',2,'chief','Mester',48,'{}','{}')
;

INSERT INTO `items` (name, label, `limit`) VALUES
	('repairkit', 'Reparationssæt', 5)
;