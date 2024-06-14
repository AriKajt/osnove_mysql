INSERT INTO grad (ime, zip) VALUES ('Zagreb', '10000');
INSERT INTO grad (ime, zip) VALUES ('Split', '21000');
INSERT INTO grad (ime, zip) VALUES ('Pula', '52000');
INSERT INTO poslovnice (ime, adresa, grad_id)/*id ne moramo upisivati jer smo stavili da je autoinkrement, pa ce sam krenuti*/
VALUES ('Trgovina Zagreb', 'Ulica Grada Vukovara 55', 1);
INSERT INTO poslovnice (ime, adresa, grad_id) VALUES ('Trgovina Zagreb', 'Ulica Grada Vukovara 55', 1);

DELETE FROM poslovnice WHERE id=2;
INSERT INTO poslovnice (ime, adresa, grad_id) VALUES ('Trgovina Pula', 'Trg Marsala Tita 2', 3);

INSERT INTO zaposlenici (ime, adresa, poslovnica_id, grad_id) VALUES ('Ivo Ivic', 'Ulica Grada Gospica 12', 3, 3);

UPDATE poslovnice SET ime = 'Poslovnica Pula', adresa = 'Trg Marsala Tita 5' WHERE id = 3;