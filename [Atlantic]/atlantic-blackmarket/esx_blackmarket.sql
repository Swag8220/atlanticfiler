USE `es_extended`;

-- Don't touch this

CREATE TABLE `blackmarket` (
	`id` int NOT NULL AUTO_INCREMENT,
	`store` varchar(100) NOT NULL,
	`item` varchar(100) NOT NULL,
	`price` int NOT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `blackmarket` (store, item, price) VALUES
	('blackmarket','drugbags',50),
	('blackmarket','hackerDevice',1000),
	('blackmarket','hammerwirecutter',250),
	('blackmarket','lockpick',100),
	('blackmarket','rolpaper',10),
	('blackmarket','strips',50),
	('blackmarket','drugItem',1000)
;
