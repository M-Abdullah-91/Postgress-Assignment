CREATE DATABASE library_db;
CREATE TABLE books(
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    year_published INT,
    isAvailable BOOLEAN,
    price NUMERIC(10, 2),
    publication VARCHAR(255)
);

INSERT INTO books(title, author, year_published, isAvailable, price, publication)
values
    ('The Great Book', 'John Doe', 2001, TRUE, 450.00, 'XYZ'),
	('1984', 'George Orwell', 1949, TRUE, 550.00, 'Secker & Warburg'),
	('To Kill a Mockingbird', 'Harper Lee', 1960, FALSE, 320.00, 'J.B. Lippincott'),
	('The Catcher in the Rye', 'J.D. Salinger', 1951, TRUE, 290.00, 'Little, Brown'),
	('The Hobbit', 'J.R.R. Tolkien', 1937, FALSE, 499.99, 'George Allen & Unwin'),
	('The Da Vinci Code', 'Dan Brown', 2003, TRUE, 750.00, 'Doubleday'),
	('Harry Potter and the Sorcerer''s Stone', 'J.K. Rowling', 1997, FALSE, 699.00, 'Bloomsbury'),
	('The Hunger Games', 'Suzanne Collins', 2008, TRUE, 525.00, 'Scholastic'),
	('A Game of Thrones', 'George R.R. Martin', 1996, TRUE, 599.00, 'Bantam Spectra'),
	('The Fault in Our Stars', 'John Green', 2012, TRUE, 430.00, 'Dutton'),
	('The Alchemist', 'Paulo Coelho', 1988, TRUE, 350.00, 'XYZ'),
	('Inferno', 'Dan Brown', 2013, FALSE, 810.00, 'Doubleday'),
	('Gone Girl', 'Gillian Flynn', 2012, TRUE, 460.00, 'Crown Publishing'),
	('The Book Thief', 'Markus Zusak', 2005, FALSE, 390.00, 'Knopf'),
	('XYZ Science Guide', 'Jane Roe', 2021, TRUE, 580.00, 'XYZ');

SELECT * FROM books
WHERE year_published > 2000;

-- 6. Select books priced under 599.00, ordered by price descending
SELECT * FROM books
WHERE price < 599.00
ORDER BY price DESC;


-- 7. Select top 3 most expensive book
SELECT * FROM books
ORDER BY price DESC
LIMIT 3

-- 8. Select 2 books skipping first 2, ordered by year descending
SELECT * FROM books
ORDER BY year_published DESC
OFFSET 2
LIMIT 2

-- 9. Select all books from publication 'XYZ', ordered by title 
SELECT * FROM books
WHERE publication = 'XYZ'
ORDER BY title ASC;

