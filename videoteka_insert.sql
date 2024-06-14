INSERT INTO zanrovi (ime)
VALUES
('Action'),
('Comedy'),
('Drama');

INSERT INTO filmovi (naslov, godina, zanr_id)
VALUES
('Inception', '2010', 1),
('The Hangover', '2009', 2),
('The Godfather', '1972', 1);

INSERT INTO cjenik (tip_filma, cijena, zakasnina_po_danu)
VALUES
('Hit', 3.00, 1.50),
('Regular', 2.00, 1.00),
('Old', 1.00, 0.50);

INSERT INTO mediji (tip, koeficijent)
VALUES
('kazeta', 1),
('DVD', 1.2),
('BluRay', 1.5);

INSERT INTO clanovi (ime, adresa, telefon, email, clanski_broj)
VALUES
('John Doe', '123 Elm Street', '555-1234', 'a@b.com', 'V001'),
('Jane Smith', '456 Oak Street', '555-5678', 'c@d.com', 'V002'),
('Alice Johnson', '789 Pine Road', '555-9012', 'a@b.com', 'V003');

INSERT INTO posudba (datum_posudbe, datum_povrata, film_id, clan_id, medij_id)
VALUES
('2024-06-09', DATE_SUB(NOW(), INTERVAL 2 DAY), 1, 5, 3),
(DATE_SUB(NOW(), INTERVAL 2 DAY), NULL, 2, 5, 3), /* had to make the return date nullable in table plus for this */
(DATE_SUB(NOW(), INTERVAL 3 DAY), DATE_SUB(NOW(), INTERVAL 1 DAY), 3, 4, 1);

INSERT INTO film_medij
VALUES
(1,3,16),
(2,3,12),
(2,2,10),
(3,1,8);
/*question: how does the pivot table work if we add the same combo again: movie 1, media 3, and add another 10 copies?
when we look it up, do we have 16+10 (26) copies, or does it find them both separately, or only the 1st instance?
especially since the pivot table doesn't have an id, how can it know the right movie-media combo?*/