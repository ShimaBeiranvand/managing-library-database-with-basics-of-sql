-- Create the Database
CREATE DATABASE LibraryDB;
USE LibraryDB;

-- Create Books Table
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    genre VARCHAR(100),
    published_year YEAR,
    stock_quantity INT DEFAULT 0
);

-- Create Members Table
CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(15),
    join_date DATE DEFAULT CURRENT_DATE
);

-- Create Loans Table
CREATE TABLE Loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    member_id INT,
    loan_date DATE DEFAULT CURRENT_DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

-- ----------------------------------------------------------
-- Insert Sample Books
INSERT INTO Books (title, author, genre, published_year, stock_quantity) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 1925, 5),
('1984', 'George Orwell', 'Dystopian', 1949, 3),
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960, 4);

-- Insert Sample Members
INSERT INTO Members (name, email, phone) VALUES
('John Doe', 'john@example.com', '1234567890'),
('Jane Smith', 'jane@example.com', '0987654321');

-- Insert Sample Loans
INSERT INTO Loans (book_id, member_id, loan_date) VALUES
(1, 1, '2023-10-01'),  -- John Doe loans The Great Gatsby
(2, 2, '2023-10-02');  -- Jane Smith loans 1984
-- ----------------------------------------------------------
-- Sample Queries

--Find All Books by a Specific Author
SELECT * FROM Books WHERE author = 'George Orwell';

--List All Books Currently Loaned Out
SELECT b.title, m.name, l.loan_date
FROM Loans l
JOIN Books b ON l.book_id = b.book_id
JOIN Members m ON l.member_id = m.member_id
WHERE l.return_date IS NULL;

--Count Total Number of Books in Each Genre
SELECT genre, COUNT(*) AS total_books
FROM Books
GROUP BY genre;

--Retrieve Loan History for a Specific Member
SELECT b.title, l.loan_date, l.return_date
FROM Loans l
JOIN Books b ON l.book_id = b.book_id
WHERE l.member_id = 1; -- Change the member_id as needed
