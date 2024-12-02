#PART 1:
#=======

CREATE database LibraryDB;
use LibraryDB;

Create TABLE Books(
	BookID int	primary KEY,
    Title varchar(100) not null,
    Author varchar(100),
    ISBN varchar(13) unique,
    PublisherYear int,
    CopiesAvailable int
);

Create TABLE Members(
	MemberID int primary KEY,
    FirstName varchar(50),
    LastName varchar(50),
    MembershipDate date
);

Create TABLE Loans(
	LoanID int	primary KEY,
    MemberID int,
    BookID int,
	foreign KEY (MemberID) REFERENCES Members(MemberID),
	foreign KEY (BookID) REFERENCES Books(BookID) ,
	LoanDate date,
    ReturnDate date
    );

#----------------------------------------------------------------------------------------------------------------------------------------
#PART2:
#======
INSERT INTO Books (BookID, Title, Author, ISBN, PublisherYear, CopiesAvailable) 
VALUES 
    (1, 'The Great Gatsby', 'F. Scott Fitzgerald', '9780743273565', 1925, 10),
    (2, '1984', 'George Orwell', '9780451524935', 1949, 15),
    (3, 'To Kill a Mockingbird', 'Harper Lee', '9780061120084', 1960, 12),
    (4, 'Pride and Prejudice', 'Jane Austen', '9780199535569', 1813, 8),
    (5, 'Moby Dick', 'Herman Melville', '9781503280786', 1851, 5);

INSERT INTO Members (MemberID, FirstName, LastName, MembershipDate) 
VALUES 
    (1, 'Alice', 'Johnson', '2024-01-15'),
    (2, 'Bob', 'Smith', '2024-02-20'),
    (3, 'Charlie', 'Brown', '2024-03-05');

INSERT INTO Loans (LoanID, MemberID, BookID, LoanDate, ReturnDate) 
VALUES 
    (1, 1, 2, '2024-11-15', '2024-12-01'),  
    (2, 2, 4, '2024-11-20', '2024-12-10');  

#----------------------------------------------------------------------------------------------------------------------------------------
#PART3:
#======
select * from Books;
select * from Members where MembershipDate > '2024-01-23';
select * from Books where CopiesAvailable > 5;

#----------------------------------------------------------------------------------------------------------------------------------------
#PART4:
#======
UPDATE Books
SET CopiesAvailable = CopiesAvailable - 1
WHERE BookID = 2; 

DELETE FROM Members
WHERE MemberID NOT IN (SELECT DISTINCT MemberID FROM Loans);

#----------------------------------------------------------------------------------------------------------------------------------------
#PART5:
#======
select FirstName, LastName , Books.title
from Members
Join Loans ON Members.MemberID=Loans.MemberID
Join Books ON Loans.BookID=Books.BookID;

SELECT 
    Members.FirstName,
    Members.LastName,
    COUNT(Loans.LoanID) AS BooksBorrowed
FROM 
    Members
LEFT JOIN Loans ON Members.MemberID = Loans.MemberID
GROUP BY 
    Members.MemberID;
