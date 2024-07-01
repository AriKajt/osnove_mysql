/*Imamo tvrtku kojoj treba kreirati bazu podataka kako bi mogla voditi evidenciju o
zaposlenicima, njihovim pozicijama i plaćama. Tvrtka ima više odjela. Svaki zaposlenik
može raditi u više odjela, a ujedno može biti i voditelj odjela*/

CREATE DATABASE IF NOT EXISTS company DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE company;


CREATE TABLE IF NOT EXISTS positions(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    title VARCHAR(100) NOT NULL UNIQUE,
    salary DECIMAL(10,2) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS employees(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    oib CHAR(11) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    address VARCHAR(100),
    phone VARCHAR(20),
    position_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (position_id) REFERENCES positions(id),
    work_time FLOAT NOT NULL,
    employment_date DATE NOT NULL,
    termination_date DATE
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS departments(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    lead_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (lead_id) REFERENCES employees(id)
)ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS position_dept(
    position_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (position_id) REFERENCES positions(id),
    dept_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES departments(id)
)ENGINE=InnoDB;

/*
CREATE TABLE IF NOT EXISTS position_types(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    type VARCHAR(100) NOT NULL UNIQUE,
    salary_coefficient FLOAT NOT NULL
)ENGINE=InnoDB;
*/


/*
CREATE TABLE IF NOT EXISTS employments(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    employee_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(id),
    position_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (position_id) REFERENCES positions(id),
    work_time FLOAT NOT NULL
)ENGINE=InnoDB;


-- stopped here
CREATE TABLE IF NOT EXISTS employment_position(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    employee_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(id),
    position_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (position_id) REFERENCES positions(id),
    work_time FLOAT NOT NULL
)ENGINE=InnoDB;
*/