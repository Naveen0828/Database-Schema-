CREATE DATABASE LibraryDB;
USE LibraryDB;

-- Books table
CREATE TABLE Books (
    isbn VARCHAR(13) PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(50),
    category VARCHAR(30),
    rental_price DECIMAL(10,2),
    status VARCHAR(10) DEFAULT 'yes' 
);

-- Members table
CREATE TABLE Members (
    member_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100),
    join_date DATE
);

-- Employees table
CREATE TABLE Employees (
    emp_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50),
    position VARCHAR(30),
    salary DECIMAL(10,2)
);

CREATE TABLE Issued (
    issued_id VARCHAR(10) PRIMARY KEY,
    isbn VARCHAR(13),
    member_id VARCHAR(10),
    emp_id VARCHAR(10),
    issue_date DATE,
    FOREIGN KEY (isbn) REFERENCES Books(isbn),
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
);

-- Sample data
INSERT INTO Books VALUES
('978-0-553-29698-2', 'The Great Gatsby', 'F. Scott Fitzgerald', 'Classic', 5.00, 'yes'),
('978-0-375-41398-8', '1984', 'George Orwell', 'Dystopian', 7.50, 'no'),
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Harper Lee', 'Classic', 6.00, 'yes');

INSERT INTO Members VALUES
('M001', 'Ravi Kumar', 'ravi@email.com', '2025-12-01'),
('M002', 'Priya Sharma', 'priya@email.com', '2025-11-15');

INSERT INTO Employees VALUES
('E101', 'Librarian Admin', 'Librarian', 45000),
('E102', 'Assistant John', 'Assistant', 35000);

INSERT INTO Issued VALUES
('IS001', '978-0-553-29698-2', 'M001', 'E101', '2025-12-15');
