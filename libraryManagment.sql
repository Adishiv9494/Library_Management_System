use library;
CREATE TABLE BBA_students (
    crn VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100),
    course VARCHAR(50),
    contact VARCHAR(20)
);
select*from Ptech_students;
CREATE TABLE BCA_students (
    crn VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100),
    course VARCHAR(50),
    contact VARCHAR(20)
);
CREATE TABLE MBA_students (
    crn VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100),
    course VARCHAR(50),
    contact VARCHAR(20)
);
CREATE TABLE MCA_students (
    crn VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100),
    course VARCHAR(50),
    contact VARCHAR(20)
);
CREATE TABLE BTech_students (
    crn VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100),
    course VARCHAR(50),
    contact VARCHAR(20)
);
CREATE TABLE BTech_students (
    crn VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100),
    course VARCHAR(50),
    contact VARCHAR(20)
);
show tables;
CREATE TABLE booksData (
    accession_number INT PRIMARY KEY,
    book_name VARCHAR(100) NOT NULL,
    author VARCHAR(100) NOT NULL,
    publisher VARCHAR(100) NOT NULL,
    edition VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);
select*from booksData;	
CREATE TABLE  book_issues (
    id INT AUTO_INCREMENT PRIMARY KEY,
    crn VARCHAR(20) NOT NULL,
    accession_no VARCHAR(20) NOT NULL,
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE NULL,
    status ENUM('issued', 'returned', 'overdue') DEFAULT 'issued',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (crn) REFERENCES students(crn),
    FOREIGN KEY (accession_no) REFERENCES booksData(accession_no)
);
CREATE TABLE book_issues (
    issue_id INT AUTO_INCREMENT PRIMARY KEY,
    crn VARCHAR(20) NOT NULL,
    accession_number INT NOT NULL,
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
      FOREIGN KEY (accession_number) REFERENCES booksData(accession_number)
);
select*from book_issues;
-- Book Issues Table (updated to include all required fields)
CREATE TABLE book_issues (
    issue_id INT AUTO_INCREMENT PRIMARY KEY,
    crn VARCHAR(20) NOT NULL,
    student_name VARCHAR(100) NOT NULL,
    contact VARCHAR(20) NOT NULL,
    course VARCHAR(50) NOT NULL,
    accession_number INT NOT NULL,
    book_title VARCHAR(100) NOT NULL,
    author VARCHAR(100) NOT NULL,
    edition VARCHAR(50) NOT NULL,
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    fine_amount DECIMAL(10,2) DEFAULT 0,
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    FOREIGN KEY (accession_number) REFERENCES booksData(accession_number),
    INDEX idx_status (status),
    INDEX idx_due_date (due_date)
);
select*from book_issues;
drop table book_issues;
DELIMITER //

CREATE PROCEDURE UpdateBookIssueStatuses()
BEGIN
    -- Calculate days overdue for all pending/issued books
    DECLARE days_overdue INT;
    
    -- Update to 'OVERDUE' when current date > due date and status is PENDING
    UPDATE book_issues 
    SET status = 'OVERDUE'
    WHERE status = 'PENDING' 
    AND due_date < CURDATE()
    AND return_date IS NULL;
    
    -- Update to 'DEFAULTER' when overdue for more than 21 days (3 weeks)
    UPDATE book_issues 
    SET status = 'DEFAULTER'
    WHERE status = 'OVERDUE'
    AND due_date < DATE_SUB(CURDATE(), INTERVAL 21 DAY)
    AND return_date IS NULL;
    
    -- Calculate and update fine amount for overdue books (example: ₹10 per day)
    UPDATE book_issues
    SET fine_amount = DATEDIFF(CURDATE(), due_date) * 10
    WHERE status IN ('OVERDUE', 'DEFAULTER')
    AND return_date IS NULL
    AND fine_amount = 0;
    
    -- For books that have been returned but still show as PENDING/OVERDUE
    UPDATE book_issues
    SET status = 'RETURNED'
    WHERE return_date IS NOT NULL
    AND status IN ('PENDING', 'OVERDUE', 'DEFAULTER');
END //

DELIMITER ;
CREATE EVENT IF NOT EXISTS daily_status_update
ON SCHEDULE EVERY 1 DAY
STARTS TIMESTAMP(CURRENT_DATE, '00:05:00')  -- Runs at 12:05 AM daily
DO
CALL UpdateBookIssueStatuses();
SET GLOBAL event_scheduler = ON;
DELIMITER //

CREATE TRIGGER after_book_issue
AFTER INSERT ON book_issues
FOR EACH ROW
BEGIN
    -- Update the book status to 'ISSUED' in booksData table
    UPDATE booksData
    SET status = 'ISSUED'
    WHERE accession_number = NEW.accession_number;
END //

DELIMITER ;
DELIMITER //

CREATE TRIGGER after_book_return
AFTER UPDATE ON book_issues
FOR EACH ROW
BEGIN
    IF NEW.return_date IS NOT NULL AND OLD.return_date IS NULL THEN
        -- Update the book status to 'AVAILABLE' in booksData table
        UPDATE booksData
        SET status = 'AVAILABLE'
        WHERE accession_number = NEW.accession_number;
        
        -- Update the status to 'RETURNED' in book_issues table
        UPDATE book_issues
        SET status = 'RETURNED'
        WHERE issue_id = NEW.issue_id;
    END IF;
END //

DELIMITER ;
CREATE VIEW overdue_books AS
SELECT * FROM book_issues 
WHERE status = 'OVERDUE' 
ORDER BY due_date;
CREATE VIEW defaulter_students AS
SELECT crn, student_name, contact, course, 
       COUNT(*) AS overdue_books,
       SUM(fine_amount) AS total_fine
FROM book_issues 
WHERE status = 'DEFAULTER'
GROUP BY crn, student_name, contact, course;

CREATE TABLE book_issues (
    issue_id INT AUTO_INCREMENT PRIMARY KEY,
    crn VARCHAR(20) NOT NULL,
    student_name VARCHAR(100) NOT NULL,
    contact VARCHAR(20) NOT NULL,
    course VARCHAR(50) NOT NULL,
    accession_number INT NOT NULL unique,
    book_title VARCHAR(100) NOT NULL,
    author VARCHAR(100) NOT NULL,
    edition VARCHAR(50) NOT NULL,
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    fine_amount DECIMAL(10,2) DEFAULT 0,	
    status varchar(20) default 'PENDING',
    FOREIGN KEY (accession_number) REFERENCES booksData(accession_number)
);
show tables;
select*from book_issues;
CREATE TABLE book_issues (
    issue_id INT AUTO_INCREMENT PRIMARY KEY,
    crn VARCHAR(20) NOT NULL,
    student_name VARCHAR(100) NOT NULL,
    contact VARCHAR(20) NOT NULL,
    course VARCHAR(50) NOT NULL,
    accession_number INT NOT NULL,
    book_title VARCHAR(100) NOT NULL,
    author VARCHAR(100) NOT NULL,
    edition VARCHAR(50) NOT NULL,
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    fine_amount DECIMAL(10,2) DEFAULT 0.00,
    status ENUM('ISSUED', 'RETURNED', 'OVERDUE', 'LOST') DEFAULT 'ISSUED',
    remarks VARCHAR(255),
    FOREIGN KEY (accession_number) REFERENCES booksData(accession_number),
    INDEX idx_crn (crn),
    INDEX idx_accession (accession_number),
    INDEX idx_status (status)
);
select*from lib_loginsignup;
delete from  lib_loginsignup where user_id =3;

describe password_reset_tokens;
CREATE TABLE IF NOT EXISTS lib_loginsignup (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    contact_number VARCHAR(15) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    account_status ENUM('active','suspended','banned') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    email_verified BOOLEAN DEFAULT FALSE,
    verification_token VARCHAR(255),
    social_provider VARCHAR(20),
    social_id VARCHAR(100),
    address VARCHAR(255),
    profile_image LONGBLOB
);
drop table password_reset_tokens;
CREATE TABLE IF NOT EXISTS password_reset_tokens (
    token_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    token VARCHAR(255) NOT NULL,
    otp VARCHAR(6) NOT NULL,
    expires_at DATETIME NOT NULL,
    used BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES lib_loginsignup(user_id),
    INDEX (token),
    INDEX (otp),
    INDEX (user_id, used)
);