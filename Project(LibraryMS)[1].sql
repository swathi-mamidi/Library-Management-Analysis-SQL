CREATE DATABASE LIB;
USE LIB;


-- Table: tbl_publisher
CREATE TABLE tbl_publisher (
    publisher_PublisherName VARCHAR(255) PRIMARY KEY,
    publisher_PublisherAddress TEXT,
    publisher_PublisherPhone VARCHAR(15)
);

-- Table: tbl_book
CREATE TABLE tbl_book (
    book_BookID INT PRIMARY KEY,
    book_Title VARCHAR(255),
    book_PublisherName VARCHAR(255),
    FOREIGN KEY (book_PublisherName) REFERENCES tbl_publisher(publisher_PublisherName)
);

-- Table: tbl_book_authors
CREATE TABLE tbl_book_authors (
    book_authors_AuthorID INT PRIMARY KEY AUTO_INCREMENT,
    book_authors_BookID INT,
    book_authors_AuthorName VARCHAR(255),
    FOREIGN KEY (book_authors_BookID) REFERENCES tbl_book(book_BookID)
);

-- Table: tbl_library_branch
CREATE TABLE tbl_library_branch (
    library_branch_BranchID INT PRIMARY KEY AUTO_INCREMENT,
    library_branch_BranchName VARCHAR(255),
    library_branch_BranchAddress TEXT
);

-- Table: tbl_book_copies
CREATE TABLE tbl_book_copies (
    book_copies_CopiesID INT PRIMARY KEY AUTO_INCREMENT,
    book_copies_BookID INT,
    book_copies_BranchID INT,
    book_copies_No_Of_Copies INT,
    FOREIGN KEY (book_copies_BookID) REFERENCES tbl_book(book_BookID),
    FOREIGN KEY (book_copies_BranchID) REFERENCES tbl_library_branch(library_branch_BranchID)
);

-- Table: tbl_borrower
CREATE TABLE tbl_borrower (
    borrower_CardNo INT PRIMARY KEY,
    borrower_BorrowerName VARCHAR(255),
    borrower_BorrowerAddress TEXT,
    borrower_BorrowerPhone VARCHAR(15)
);

-- Table: tbl_book_loans
CREATE TABLE tbl_book_loans (
    book_loans_LoansID INT PRIMARY KEY AUTO_INCREMENT,
    book_loans_BookID INT,
    book_loans_BranchID INT,
    book_loans_CardNo INT,
    book_loans_DateOut DATE,
    book_loans_DueDate DATE,
    FOREIGN KEY (book_loans_BookID) REFERENCES tbl_book(book_BookID),
    FOREIGN KEY (book_loans_BranchID) REFERENCES tbl_library_branch(library_branch_BranchID),
    FOREIGN KEY (book_loans_CardNo) REFERENCES tbl_borrower(borrower_CardNo)
);

SHOW DATABASES;
USE LIB;

SELECT * FROM tbl_publisher
LIMIT 10;

SELECT * FROM tbl_book
LIMIT 10;

SELECT * FROM tbl_book_authors
LIMIT 10;

SELECT * FROM tbl_library_branch
LIMIT 10;

SELECT * FROM tbl_book_copies;
-- limit 10;

SELECT * FROM tbl_borrower
LIMIT 10;

SELECT * FROM tbl_book_loans
LIMIT 10;

-- TASK QUESTION
/* 1. How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?*/
SELECT B.BOOK_TITLE, BR.LIBRARY_BRANCH_BRANCHNAME, BC.BOOK_COPIES_NO_OF_COPIES
FROM TBL_BOOK_COPIES BC
JOIN TBL_BOOK B ON B.BOOK_BOOKID= BC.BOOK_COPIES_COPIESID
JOIN tbl_library_branch BR ON BR.LIBRARY_BRANCH_BRANCHID = BC.BOOK_COPIES_BRANCHID
WHERE B.BOOK_TITLE = "The Lost Tribe"
AND BR.LIBRARY_BRANCH_BRANCHNAME = 'Sharpstown';

/*2. How many copies of the book titled "The Lost Tribe" are owned by each library branch?*/
SELECT B.BOOK_TITLE, BR.LIBRARY_BRANCH_BRANCHNAME, BC.BOOK_COPIES_NO_OF_COPIES
FROM TBL_BOOK_COPIES BC
JOIN TBL_BOOK B ON B.BOOK_BOOKID= BC.BOOK_COPIES_COPIESID
JOIN tbl_library_branch BR ON BR.LIBRARY_BRANCH_BRANCHID = BC.BOOK_COPIES_BRANCHID
WHERE B.BOOK_TITLE = "The Lost Tribe";

/*3. Retrieve the names of all borrowers who do not have any books checked out.*/
SELECT BW.BORROWER_BORROWERNAME, L.BOOK_LOANS_CARDNO
FROM tbl_borrower BW
JOIN tbl_book_loans L ON L.BOOK_LOANS_CARDNO = BW.BORROWER_CARDNO
JOIN TBL_BOOK B ON B.BOOK_BOOKID = L.book_loans_BookID
WHERE L.BOOK_LOANS_CARDNO IS NULL;

/*4. For each book that is loaned out from the "Sharpstown" branch and whose DueDate is 2/3/18, 
retrieve the book title, the borrower's name, and the borrower's address. */
SELECT B.BOOK_TITLE, B.BOOK_BOOKID, BW.BORROWER_BORROWERNAME, BW.BORROWER_BORROWERADDRESS
FROM tbl_borrower BW
JOIN tbl_book_loans L ON  L.BOOK_LOANS_CARDNO = BW.BORROWER_CARDNO
JOIN TBL_BOOK B ON B. BOOK_BOOKID = L. book_loans_LOANSID
JOIN tbl_library_branch BR ON BR.LIBRARY_BRANCH_BRANCHID = L.book_loans_BRANCHID
WHERE BR.LIBRARY_BRANCH_BRANCHNAME = 'Sharpstown'
AND L.BOOK_LOANS_DUEDATE = '0002-03-18';

SELECT *FROM tbl_library_branch;

/* 5. For each library branch, retrieve the branch name and the 
total number of books loaned out from that branch.*/
SELECT * FROM tbl_book_loans;
SELECT * FROM tbl_book_copies;

SELECT BR.LIBRARY_BRANCH_BRANCHNAME, COUNT(L.BOOK_LOANS_BRANCHID) AS NO_OF_BOOKS_LOANED
FROM  tbl_book_loans L
JOIN tbl_library_branch BR ON BR.LIBRARY_BRANCH_BRANCHID = L.BOOK_LOANS_BRANCHID
GROUP BY BR.LIBRARY_BRANCH_BRANCHNAME;

/*6.Retrieve the names, addresses, and number of books 
checked out for all borrowers who have more than five books checked out.*/
SELECT BW.BORROWER_BORROWERNAME, BW.BORROWER_BORROWERADDRESS, COUNT(L.BOOK_LOANS_LOANSID) AS books_checked_out
FROM tbl_borrower BW
JOIN tbl_book_loans L ON BW.borrower_CardNo = L.book_loans_CardNo
GROUP BY BW.borrower_BorrowerName, BW.borrower_BorrowerAddress
HAVING COUNT(L.book_loans_LoansID) > 5;

/*7. For each book authored by "Stephen King", get title & number of copies in "Central" branch*/
SELECT b.book_Title, bc.book_copies_No_Of_Copies
FROM tbl_book b
JOIN tbl_book_authors ba ON b.book_BookID = ba.book_authors_BookID
JOIN tbl_book_copies bc ON b.book_BookID = bc.book_copies_BookID
JOIN tbl_library_branch lb ON bc.book_copies_BranchID = lb.library_branch_BranchID
WHERE ba.book_authors_AuthorName = 'Stephen King'
  AND lb.library_branch_BranchName = 'Central';













