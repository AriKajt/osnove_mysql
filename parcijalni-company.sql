--Imamo tvrtku kojoj treba kreirati bazu podataka kako bi mogla voditi evidenciju o
--zaposlenicima, njihovim pozicijama i plaćama. Tvrtka ima više odjela. Svaki zaposlenik
--može raditi u više odjela, a ujedno može biti i voditelj odjela*/

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


CREATE TABLE IF NOT EXISTS dept_position(
    dept_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES departments(id),
    position_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (position_id) REFERENCES positions(id)
)ENGINE=InnoDB;

-- Positions
INSERT INTO positions (title, salary) VALUES
('Chief Executive Officer', 3000),
('Chief Financial Officer', 2800),
('Program Manager', 2500),
('Operations Manager', 2300),
('Communications Manager', 2400),
('Program Officer', 2000),
('Operations Officer', 1800),
('Communications Officer', 1900);

-- Employees
INSERT INTO employees (first_name, last_name, oib, email, address, phone, position_id, work_time, employment_date, termination_date) VALUES
('Laura', 'Moore', '78901234567', 'laura.moore@company.com', '159 Spruce St', '555-3344', 1, 0.75, '2017-07-15', '2021-09-30'),
('Michael', 'Brown', '45678901234', 'michael.brown@company.com', '321 Birch St', '555-3456', 2, 0.6, '2018-11-30', '2022-12-15'),
('Jane', 'Smith', '23456789012', 'jane.smith@company.com', '456 Oak St', '555-5678', 3, 0.8, '2019-03-22', '2023-04-01'),
('William', 'Thomas', '01234567890', 'william.thomas@company.com', '951 Cypress St', '555-9900', 4, 0.85, '2019-04-10', NULL),
('John', 'Doe', '12345678901', 'john.doe@company.com', '123 Maple St', '555-1234', 5, 1.0, '2020-01-15', NULL),
('David', 'Wilson', '67890123456', 'david.wilson@company.com', '987 Elm St', '555-1122', 6, 1.0, '2020-08-25', NULL),
('Emily', 'Jones', '34567890123', 'emily.jones@company.com', '789 Pine St', '555-9012', 7, 1.0, '2021-05-10', NULL),
('Sophia', 'Anderson', '90123456789', 'sophia.anderson@company.com', '357 Redwood St', '555-7788', 1, 1.0, '2021-09-01', NULL),
('Sarah', 'Davis', '56789012345', 'sarah.davis@company.com', '654 Cedar St', '555-7890', 2, 0.6, '2022-12-20', NULL),
('James', 'Taylor', '89012345678', 'james.taylor@company.com', '753 Fir St', '555-5566', 3, 0.8, '2023-01-05', NULL);

-- Departments
INSERT INTO departments (name, lead_id) VALUES
('Programs', 10),
('Operations', 9),
('Communications', 5);

-- Departments-Positions
INSERT INTO dept_position (dept_id, position_id) VALUES
(1, 1),
(1, 3),
(1, 5),
(1, 6),
(2, 1),
(2, 2),
(2, 4),
(2, 7),
(3, 1),
(3, 5),
(3, 8);

-- Dohvatite sve zaposlenike i njihove plaće
SELECT e.*, p.title, ROUND(p.salary*e.work_time, 2) AS Salary 
    FROM employees e
    JOIN positions p ON e.position_id = p.id;

/*

+----+------------+-----------+-------------+-----------------------------+----------------+----------+-------------+-----------+-----------------+------------------+-------------------------+--------+
| id | first_name | last_name | oib         | email                       | address        | phone    | position_id | work_time | employment_date | termination_date | title                   | Salary |
+----+------------+-----------+-------------+-----------------------------+----------------+----------+-------------+-----------+-----------------+------------------+-------------------------+--------+
|  1 | Laura      | Moore     | 78901234567 | laura.moore@company.com     | 159 Spruce St  | 555-3344 |           1 |      0.75 | 2017-07-15      | 2021-09-30       | Chief Executive Officer |   2250 |
|  2 | Michael    | Brown     | 45678901234 | michael.brown@company.com   | 321 Birch St   | 555-3456 |           2 |       0.6 | 2018-11-30      | 2022-12-15       | Chief Financial Officer |   1680 |
|  3 | Jane       | Smith     | 23456789012 | jane.smith@company.com      | 456 Oak St     | 555-5678 |           3 |       0.8 | 2019-03-22      | 2023-04-01       | Program Manager         |   2000 |
|  4 | William    | Thomas    | 01234567890 | william.thomas@company.com  | 951 Cypress St | 555-9900 |           4 |      0.85 | 2019-04-10      | NULL             | Operations Manager      |   1955 |
|  5 | John       | Doe       | 12345678901 | john.doe@company.com        | 123 Maple St   | 555-1234 |           5 |         1 | 2020-01-15      | NULL             | Communications Manager  |   2400 |
|  6 | David      | Wilson    | 67890123456 | david.wilson@company.com    | 987 Elm St     | 555-1122 |           6 |         1 | 2020-08-25      | NULL             | Program Officer         |   2000 |
|  7 | Emily      | Jones     | 34567890123 | emily.jones@company.com     | 789 Pine St    | 555-9012 |           7 |         1 | 2021-05-10      | NULL             | Operations Officer      |   1800 |
|  8 | Sophia     | Anderson  | 90123456789 | sophia.anderson@company.com | 357 Redwood St | 555-7788 |           1 |         1 | 2021-09-01      | NULL             | Chief Executive Officer |   3000 |
|  9 | Sarah      | Davis     | 56789012345 | sarah.davis@company.com     | 654 Cedar St   | 555-7890 |           2 |       0.6 | 2022-12-20      | NULL             | Chief Financial Officer |   1680 |
| 10 | James      | Taylor    | 89012345678 | james.taylor@company.com    | 753 Fir St     | 555-5566 |           3 |       0.8 | 2023-01-05      | NULL             | Program Manager         |   2000 |
+----+------------+-----------+-------------+-----------------------------+----------------+----------+-------------+-----------+-----------------+------------------+-------------------------+--------+
*/


-- Dohvatite sve voditelje odjela 
SELECT e.first_name, e.last_name, p.title, d.name As Department, ROUND(p.salary*e.work_time, 2) AS Salary
    FROM employees e
    JOIN positions p ON e.position_id = p.id
    JOIN departments d ON d.lead_id = e.id;

/*
+------------+-----------+-------------------------+----------------+--------+
| first_name | last_name | title                   | Department     | Salary |
+------------+-----------+-------------------------+----------------+--------+
| James      | Taylor    | Program Manager         | Programs       |   2000 |
| Sarah      | Davis     | Chief Financial Officer | Operations     |   1680 |
| John       | Doe       | Communications Manager  | Communications |   2400 |
+------------+-----------+-------------------------+----------------+--------+
*/

--i izračunajte prosjek njihovih plaća.
SELECT ROUND(AVG(p.salary*e.work_time), 2) As 'Lead Salary Avg'
    FROM employees e
    JOIN positions p ON e.position_id = p.id
    JOIN departments d ON d.lead_id = e.id;

/*
+-----------------+
| Lead Salary Avg |
+-----------------+
|         2026.67 |
+-----------------+
*/

-- Kreirajte proceduru koja će računati prosjek plaća svih zaposlenika.

DELIMITER $$

CREATE PROCEDURE IF NOT EXISTS average_salary() 
BEGIN

SELECT ROUND(AVG(p.salary*e.work_time), 2) AS 'Average Salary'
FROM employees e
JOIN positions p ON e.position_id = p.id
WHERE e.termination_date IS NULL;

END $$ 
DELIMITER ;

CALL average_salary();

/*
+----------------+
| Average Salary |
+----------------+
|        2119.29 |
+----------------+
*/