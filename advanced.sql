-- Stored Procedure: Issue Book (check availability)
DELIMITER //
CREATE PROCEDURE IssueBook(
    IN p_issued_id VARCHAR(10),
    IN p_isbn VARCHAR(13),
    IN p_member_id VARCHAR(10),
    IN p_emp_id VARCHAR(10)
)
BEGIN
    DECLARE book_status VARCHAR(10);
    SELECT status INTO book_status FROM Books WHERE isbn = p_isbn;
    
    IF book_status = 'yes' THEN
        INSERT INTO Issued VALUES(p_issued_id, p_isbn, p_member_id, p_emp_id, CURDATE());
        UPDATE Books SET status = 'no' WHERE isbn = p_isbn;
        SELECT 'Book issued successfully' as message;
    ELSE
        SELECT 'Book not available' as message;
    END IF;
END //
DELIMITER ;

-- Usage
CALL IssueBook('IS002', '978-1-60129-456-2', 'M002', 'E102');

-- CTAS: Create overdue summary table
CREATE TABLE OverdueSummary AS
SELECT m.member_id, m.name, COUNT(*) as overdue_count,
       SUM(DATEDIFF(CURDATE(), i.issue_date) * 0.50) as total_fine
FROM Issued i JOIN Members m ON i.member_id = m.member_id
WHERE DATEDIFF(CURDATE(), i.issue_date) > 14
GROUP BY m.member_id, m.name;
