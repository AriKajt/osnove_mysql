DROP DATABASE IF EXISTS tvrtka; /*obrisi je ako postoji*/
CREATE DATABASE IF NOT EXISTS tvrtka DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE tvrtka;


CREATE TABLE IF NOT EXISTS poslovnice(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    ime VARCHAR(20) NOT NULL,
    adresa VARCHAR(255) NOT NULL,
    broj_telefona VARCHAR(15),
    grad VARCHAR(20)
)ENGINE=InnoDB;

ALTER TABLE poslovnice DROP COLUMN broj_telefona;
ALTER TABLE poslovnice DROP COLUMN grad;

ALTER TABLE poslovnice ADD COLUMN voditelj_id INT UNSIGNED NOT NULL AFTER adresa;/*nije nuzno jer automatski stavlja na zadnje mjesto, 
al da smo htjeli npr da je na drugom mjestu, mogli smo to definirat - samo sto je obicaj staviti foreign keys na kraj*/
ALTER TABLE poslovnice ADD COLUMN grad_id INT UNSIGNED NOT NULL;

ALTER TABLE poslovnice DROP FOREIGN KEY poslovnice_ibfk_1;
ALTER TABLE poslovnice DROP COLUMN voditelj_id;

CREATE TABLE IF NOT EXISTS grad(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    ime VARCHAR(20) NOT NULL,
    zip VARCHAR(5) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS zaposlenici(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    ime VARCHAR(50) NOT NULL,
    adresa VARCHAR(255) NOT NULL,
    poslovnica_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (poslovnica_id) REFERENCES poslovnice(id),
    grad_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (grad_id) REFERENCES grad(id) /*paziti na raspored, dakle gradove kreirati prije nego ih ovdje referiramo*/
)ENGINE=InnoDB;

ALTER TABLE poslovnice ADD FOREIGN KEY (voditelj_id) REFERENCES zaposlenici(id);
ALTER TABLE poslovnice ADD FOREIGN KEY (grad_id) REFERENCES grad(id);