/*
The library issues membership cards to its members.
Books are categorized by genres.
Each book can have multiple copies.
Members can borrow books for a period, and late returns incur a fine.
Each book has a unique ISBN, but there can be multiple copies of the same book.

ER Diagram

Entities:

Member
Book
Genre
BookCopy
Borrow


Relationships:

Members can borrow multiple books.
Each book belongs to one genre.
Each book can have multiple copies.
Each borrow record is associated with one member and one book copy.

SQL za kreiranje baze knjiznica
kreirajte bazu i popunite sa proizvoljnim podacima
*/

CREATE TABLE member (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(200),
    phone VARCHAR(15),
    cardNumber VARCHAR(20)
);

CREATE TABLE genre (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE book (
    ISBN VARCHAR(13) PRIMARY KEY,
    title VARCHAR(200),
    author VARCHAR(100),
    genreID INT,
    FOREIGN KEY (genreID) REFERENCES genre(id)
);

CREATE TABLE bookCopy (
    id INT PRIMARY KEY,
    ISBN VARCHAR(13),
    availability BOOLEAN,
    FOREIGN KEY (ISBN) REFERENCES book(ISBN)
);

CREATE TABLE borrow (
    id INT PRIMARY KEY,
    memberID INT,
    copyID INT,
    borrowDate DATE,
    returnDate DATE,
    dueDate DATE,
    lateFee DECIMAL(5, 2),
    FOREIGN KEY (memberID) REFERENCES member(id),
    FOREIGN KEY (copyID) REFERENCES bookCopy(id)
);