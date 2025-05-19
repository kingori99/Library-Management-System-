-- Database: LibraryManagementSystem

-- Drop existing tables if they exist to start fresh
DROP TABLE IF EXISTS book_authors;
DROP TABLE IF EXISTS book_genres;
DROP TABLE IF EXISTS library_branches;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS loans;

-- -----------------------------------------------------
-- Table `library_branches`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS library_branches (
    branch_id INT AUTO_INCREMENT PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL
);

-- -----------------------------------------------------
-- Table `members`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(20),
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- -----------------------------------------------------
-- Table `authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

-- -----------------------------------------------------
-- Table `genres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(50) NOT NULL UNIQUE
);

-- -----------------------------------------------------
-- Table `books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(20) NOT NULL UNIQUE,
    title VARCHAR(255) NOT NULL,
    publication_year INT,
    publisher VARCHAR(100),
    branch_id INT NOT NULL,
    genre_id INT NOT NULL,
    FOREIGN KEY (branch_id) REFERENCES library_branches(branch_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

-- -----------------------------------------------------
-- Table `book_authors` (Many-to-Many relationship between books and authors)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS book_authors (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

-- -----------------------------------------------------
-- Table `book_genres` (Initially thought of this, but integrated genre directly into books table for simplicity in this initial design)
-- Keeping the CREATE TABLE statement here as a reminder of potential alternative designs.
-- -----------------------------------------------------
-- CREATE TABLE IF NOT EXISTS book_genres (
--     book_id INT,
--     genre_id INT,
--     PRIMARY KEY (book_id, genre_id),
--     FOREIGN KEY (book_id) REFERENCES books(book_id),
--     FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
-- );

-- -----------------------------------------------------
-- Table `loans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    loan_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    due_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- -----------------------------------------------------
-- Sample Data Insertion (Optional, for testing)
-- -----------------------------------------------------

-- Insert into library_branches
INSERT INTO library_branches (branch_name, address) VALUES
('Main Library', '123 Main St, Anytown'),
('Downtown Branch', '456 Oak Ave, Anytown');

-- Insert into members
INSERT INTO members (first_name, last_name, email, phone_number) VALUES
('Alice', 'Smith', 'alice.smith@email.com', '123-456-7890'),
('Bob', 'Johnson', 'bob.johnson@email.com', '987-654-3210');

-- Insert into authors
INSERT INTO authors (first_name, last_name) VALUES
('J.R.R.', 'Tolkien'),
('Jane', 'Austen'),
('George', 'Orwell');

-- Insert into genres
INSERT INTO genres (genre_name) VALUES
('Fantasy'),
('Romance'),
('Science Fiction'),
('Classic');

-- Insert into books
INSERT INTO books (isbn, title, publication_year, publisher, branch_id, genre_id) VALUES
('978-0618260274', 'The Hobbit', 1937, 'Houghton Mifflin', 1, 1),
('978-0141439518', 'Pride and Prejudice', 1813, 'Penguin Classics', 1, 2),
('978-0451524935', 'Nineteen Eighty-Four', 1949, 'Signet Classics', 2, 3),
('978-0553809371', 'A Game of Thrones', 1996, 'Bantam Books', 2, 1);

-- Insert into book_authors
INSERT INTO book_authors (book_id, author_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 1);

-- Insert into loans
INSERT INTO loans (book_id, member_id, due_date) VALUES
(1, 1, '2025-05-26'),
(2, 2, '2025-05-29');
