TRUNCATE TABLE artists RESTART IDENTITY CASCADE;


INSERT INTO "public"."artists" ("id", "name", "genre") VALUES
(1, 'Pixies', 'Rock'),
(2, 'ABBA', 'Pop'),
(3, 'Taylor Swift', 'Pop'),
(4, 'Nina Simone', 'Pop'),
(5, 'Massive Attack', 'Dance'),
(12, 'The Prodigy', 'Dance');

INSERT INTO "public"."albums" ("id", "title", "release_year", "artist_id") VALUES
(1, 'Bold As Love', 1967, 1),
(2, 'Surfer Rosa', 1988, 1),
(3, 'Waterloo', 1972, 2),
(4, 'Super Trouper', 1980, 2),
(5, 'Bossanova', 1990, 1),
(6, 'Lover', 2019, 3),
(7, 'Folklore', 2020, 3),
(8, 'I Put a Spell on You', 1965, 4),
(9, 'Baltimore', 1978, 4),
(10, 'Here Comes the Sun', 1971, 4),
(11, 'Fodder on My Wings', 1982, 4),
(13, 'Mezzanine', 1998, 5),
(14, 'Music for a Jilted Generation', 1994, 12);