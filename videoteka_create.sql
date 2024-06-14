CREATE TABLE IF NOT EXISTS zanrovi (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    ime VARCHAR(100) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS filmovi (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    naslov VARCHAR(100) NOT NULL,
    godina CHAR(4) NOT NULL,
    zanr_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (zanr_id) REFERENCES zanrovi(id)
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS cjenik (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    tip_filma VARCHAR(30) NOT NULL,
    cijena DECIMAL(10,2) NOT NULL,--10 znamenki ispred zareza, 2 iza zareza
    zakasnina_po_danu DECIMAL(10,2) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS mediji (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    tip VARCHAR(100) NOT NULL,
    zaliha INT NOT NULL,
    koeficijent FLOAT NOT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS clanovi (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    ime VARCHAR(100) NOT NULL,
    adresa VARCHAR(100),
    telefon VARCHAR(20),
    email VARCHAR(50) NOT NULL UNIQUE,
    clanski_broj CHAR(14) NOT NULL UNIQUE
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS posudba (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    datum_posudbe DATE NOT NULL,
    datum_povrata DATE NOT NULL,
    film_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (film_id) REFERENCES filmovi(id),
    clan_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (clan_id) REFERENCES clanovi(id),
    cjenik_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (cjenik_id) REFERENCES cjenik(id),
    medij_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (medij_id) REFERENCES mediji(id)
)ENGINE=InnoDB;

ALTER TABLE mediji DROP COLUMN zaliha;

CREATE TABLE IF NOT EXISTS film_medij (
    film_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (film_id) REFERENCES filmovi(id),
    medij_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (medij_id) REFERENCES mediji(id),
    zaliha INT NOT NULL,
)ENGINE=InnoDB;

/* cjenik should be povezan s filmom a ne s posudbom - 
treba bit unesen u tablici filma kao foreign key da se moze povezati tip filma,
jer ce sigurno brzo "hit" postati "regular" i onda kasnije "old", 
sto ne odlucujemo tj. ne updejtamo kod svake posudbe*/

ALTER TABLE posudba DROP FOREIGN KEY posudba_ibfk_3;
ALTER TABLE posudba DROP COLUMN cjenik_id;

ALTER TABLE filmovi ADD COLUMN cjenik_id INT UNSIGNED NOT NULL;/*had to then change values of already inserted movies, 
da cjenik_id bude npr 1, jer je inicializirano na 0 sto ne moze onda mapirati na id u tablici cjenik 
jer tu su id-evi od 1 nadalje, dakle 0 ne postoji*/
ALTER TABLE filmovi ADD FOREIGN KEY (cjenik_id) REFERENCES cjenik(id);
