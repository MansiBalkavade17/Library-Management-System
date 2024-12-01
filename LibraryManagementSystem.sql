create database LibraryDB;
USE LibraryDB;
drop database LibraryDB;
CREATE TABLE Books (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(100) NOT NULL,
    Author NVARCHAR(100) NOT NULL,
    ISBN NVARCHAR(20) NOT NULL,
    PublishedDate DATE NOT NULL
);
INSERT INTO Books (Title, Author, ISBN, PublishedDate)
VALUES 
('The Great Gatsby', 'F. Scott Fitzgerald', '9780743273565', '1925-04-10'),
('To Kill a Mockingbird', 'Harper Lee', '9780060935467', '1960-07-11'),
('1984', 'George Orwell', '9780451524935', '1949-06-08'),
('Pride and Prejudice', 'Jane Austen', '9780141439518', '1813-01-28'),
('The Catcher in the Rye', 'J.D. Salinger', '9780316769488', '1951-07-16');


CREATE TABLE Members (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(15) NOT NULL
);
INSERT INTO Members (Name, Email, Phone)
VALUES 
('John Doe', 'johndoe@example.com', '1234567890'),
('Jane Smith', 'janesmith@example.com', '9876543210'),
('Michael Brown', 'michaelbrown@example.com', '4561237890'),
('Emily Davis', 'emilydavis@example.com', '7894561230'),
('William Johnson', 'williamjohnson@example.com', '3216549870');



CREATE TABLE BorrowRecords (
    Id INT PRIMARY KEY IDENTITY(1,1),
    BookId INT NOT NULL,
    MemberId INT NOT NULL,
    BorrowDate DATE NOT NULL,
    ReturnDate DATE,
    FOREIGN KEY (BookId) REFERENCES Books(Id),
    FOREIGN KEY (MemberId) REFERENCES members(Id)
);

INSERT INTO BorrowRecords (BookId, MemberId, BorrowDate, ReturnDate)
VALUES
(1, 2, '2024-11-01', '2024-11-15'),
(3, 1, '2024-11-05', '2023-10-23'),
(2, 4, '2024-11-10', '2024-11-20'),
(5, 3, '2024-11-12', '2034-09-04'),
(4, 5, '2024-11-14', '2024-11-24');
select *from BorrowRecords;

SELECT br.Id, br.BookId, br.MemberId, br.BorrowDate, br.ReturnDate,
       b.Title AS BookTitle, -- Verify this alias matches
       m.Name AS MemberName  -- Verify this alias matches
FROM BorrowRecords br
INNER JOIN Books b ON br.BookId = b.Id
INNER JOIN Members m ON br.MemberId = m.Id;


SELECT br.*
FROM BorrowRecords br
LEFT JOIN Books b ON br.BookId = b.Id
LEFT JOIN Members m ON br.MemberId = m.Id
WHERE b.Id IS NULL OR m.Id IS NULL;



drop table Books;
drop table Members;
drop table BorrowRecords;
