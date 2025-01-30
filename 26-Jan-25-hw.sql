CREATE TABLE languages (
	"language_id"	INTEGER NOT NULL UNIQUE,
	"language_name"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("language_id" AUTOINCREMENT)
);

CREATE TABLE countries (
	"country_id"	INTEGER NOT NULL UNIQUE,
	"country_capital"	TEXT NOT NULL UNIQUE,
	"country_language_id"	INTEGER NOT NULL,
	"country_name"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("country_id" AUTOINCREMENT)
	FOREIGN KEY("country_language_id") REFERENCES languages("language_id") ON DELETE CASCADE  ON UPDATE CASCADE
);


CREATE TABLE song_details (
	"song_id"	INTEGER NOT NULL UNIQUE,
	"singer_name"	TEXT NOT NULL,
	"singer_country_id"	INTEGER NOT NULL,
	"singer_language_id" INTEGER NOT NULL,
	"song_name" TEXT NOT NULL,
	PRIMARY KEY("song_id" AUTOINCREMENT)
	FOREIGN KEY("singer_country_id") REFERENCES countries (country_id) ON DELETE CASCADE  ON UPDATE CASCADE
	FOREIGN KEY("singer_language_id") REFERENCES languages("language_id") ON DELETE CASCADE  ON UPDATE CASCADE
);

CREATE TABLE eurovision (
	"eurovision_id"	INTEGER NOT NULL UNIQUE,
	"competition_year"	INTEGER NOT NULL UNIQUE,
	"hosting_country_id"	INTEGER NOT NULL,
	"song_id" INTEGER NOT NULL,
	PRIMARY KEY("eurovision_id" AUTOINCREMENT)
	FOREIGN KEY("song_id") REFERENCES song_details (song_id) ON DELETE CASCADE  ON UPDATE CASCADE
	FOREIGN KEY("hosting_country_id") REFERENCES countries("country_id") ON DELETE CASCADE  ON UPDATE CASCADE
	
);

INSERT INTO languages (language_name) VALUES 
('German'),
('Swedish'),
('Ukrainian'),
('Italian'),
('Dutch'),
('Hebrew'),
('Portuguese'),
('Azerbaijani'),
('Danish'),
('English')
;


INSERT INTO countries (country_capital,country_language_id,country_name) VALUES 
('Bern',1, 'Switzerland');

INSERT INTO countries (country_capital,country_language_id,country_name) 
VALUES ('Stockholm',2,'Sweden');

INSERT INTO countries (country_capital,country_language_id,country_name)
VALUES ('Kyiv',3,'Ukraine');

INSERT INTO countries (country_capital,country_language_id,country_name)
VALUES ('Rome',4,'Italy');

INSERT INTO countries (country_capital,country_language_id,country_name)
VALUES('Amsterdam',5,'Netherlands');

INSERT INTO countries (country_capital,country_language_id,country_name)
VALUES('Jerusalem',6,'Israel');

INSERT INTO countries (country_capital,country_language_id,country_name)
VALUES ('Lisbon',7,'Portugal');

INSERT INTO countries (country_capital,country_language_id,country_name)
VALUES ('Vienna',1,'Austria');

INSERT INTO countries (country_capital,country_language_id,country_name)
VALUES ('Copenhagen',9,'Denmark');

INSERT INTO countries (country_capital,country_language_id,country_name)
VALUES ('London',10,'United Kingdom');
INSERT INTO countries (country_capital,country_language_id,country_name)
VALUES ('Baku',8,'Azerbaijan');

INSERT INTO song_details ( singer_name, singer_country_id, singer_language_id, song_name)
VALUES ( 'Nemo', 1, 10, 'The code');

INSERT INTO song_details
( singer_name, singer_country_id, singer_language_id, song_name)
VALUES ( 'Loreen', 2, 10, 'Tatto');

INSERT INTO song_details
(singer_name, singer_country_id, singer_language_id, song_name)
VALUES ( 'Kalush Orchestra', 3, 3, 'Stefania');

INSERT INTO song_details
( singer_name, singer_country_id, singer_language_id, song_name)
VALUES ( 'Måneskin', 4, 4, 'Zitti e buoni');

INSERT INTO song_details
( "singer_name", singer_country_id, singer_language_id, song_name)
VALUES ( 'Duncan Laurence', 5, 10, 'Arcade');

INSERT INTO song_details
( singer_name, singer_country_id, singer_language_id, song_name)
VALUES ( 'Netta', 6, 10, 'Toy');

INSERT INTO song_details
( singer_name, singer_country_id, singer_language_id, song_name)
VALUES ( 'Salvador Sobral', 7, 7, 'Amar pelos dois');

INSERT INTO song_details
(singer_name, singer_country_id, singer_language_id, song_name)
VALUES ( 'Jamala', 3, 10,'1944');

INSERT INTO song_details
(singer_name, singer_country_id, singer_language_id, song_name)
VALUES ( 'Måns Zelmerlöw', 2, 10,'Heroes');

INSERT INTO song_details
(singer_name, singer_country_id, singer_language_id, song_name)
VALUES ( 'Conchita Wurst', 8, 10,'Rise Like a Phoenix');

INSERT INTO song_details
(singer_name, singer_country_id, singer_language_id, song_name)
VALUES ( 'Emmelie de Forest', 9, 10,'Only Teardrops');

INSERT INTO song_details
(singer_name, singer_country_id, singer_language_id, song_name)
VALUES ( 'Loreen', 2, 10,'Euphoria');

INSERT INTO eurovision (competition_year,hosting_country_id,song_id)
VALUES ( 2024, 2, 1);

INSERT INTO eurovision (competition_year,hosting_country_id,song_id)
VALUES ( 2023, 10, 2);

INSERT INTO eurovision (competition_year,hosting_country_id,song_id)
VALUES ( 2022, 4, 3);
INSERT INTO eurovision (competition_year,hosting_country_id,song_id)
VALUES ( 2021, 5, 4);
INSERT INTO eurovision (competition_year,hosting_country_id,song_id)
VALUES ( 2019, 6, 5);
INSERT INTO eurovision (competition_year,hosting_country_id,song_id)
VALUES ( 2018, 7, 6);
INSERT INTO eurovision (competition_year,hosting_country_id,song_id)
VALUES ( 2017, 3, 7);
INSERT INTO eurovision (competition_year,hosting_country_id,song_id)
VALUES ( 2016, 2, 8);
INSERT INTO eurovision (competition_year,hosting_country_id,song_id)
VALUES ( 2015, 8,9);
INSERT INTO eurovision (competition_year,hosting_country_id,song_id)
VALUES ( 2014, 9, 10);
INSERT INTO eurovision (competition_year,hosting_country_id,song_id)
VALUES ( 2013, 2, 11);
INSERT INTO eurovision (competition_year,hosting_country_id,song_id)
VALUES ( 2012, 11, 12);

select e.competition_year,c.country_name as hosting_country,s_d.winning_country_name,s_d.country_language,s_d.song_name,s_d.song_language,s_d.country_capital,s_d.singer_name from eurovision e
join countries c on e.hosting_country_id=c.country_id
join (select  l2.language_name as country_language,l.language_name as song_language, s.song_id as song_id, c.country_name as winning_country_name,s.song_name as song_name,s.singer_name as singer_name,c.country_capital as country_capital from song_details s
join countries c on c.country_id=s.singer_country_id
join languages l on s.singer_language_id=l.language_id
join languages l2 on c.country_language_id=l2.language_id) as s_d
on e.song_id=s_d.song_id