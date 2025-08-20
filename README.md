# Library-Management-Analysis-SQL
Project Overview

The Library Management System (LMS) is a database project designed to manage books, borrowers, library branches, and book transactions efficiently.
It helps librarians and administrators track books, borrowers, due dates, availability, and authorship while ensuring data consistency using relational database principles.

Features & Functionalities

Store and manage information about books, publishers, authors, and borrowers.
Track the number of copies of books available in each library branch.
Maintain book loan records, including issue and due dates.
Retrieve details of borrowers and their borrowed books.
Identify borrowers with overdue books or those who have borrowed more than a certain number of books.
Query books by author, branch, or borrower efficiently.

Key Tables Designed

tbl_publisher → Stores publisher details.
tbl_book → Stores book details and publisher info.
tbl_book_authors → Maintains information about book authors.
tbl_library_branch → Stores branch details.
tbl_book_copies → Tracks how many copies of each book exist at each branch.
tbl_borrower → Maintains borrower details.
tbl_book_loans → Tracks book issue and return (due date).

Insights from the Project

Helps librarians know how many copies of a book are available at each branch.
Identifies borrowers with no books issued (inactive users).

Finds borrowers with more than 5 active loans.

Retrieves books authored by specific authors (e.g., Stephen King).

Tracks branch-wise book circulation for better management.

Provides due date tracking to ensure timely returns.
