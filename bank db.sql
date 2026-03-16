-- Bank & Employee Database
CREATE DATABASE IF NOT EXISTS BankDb;
USE BankDb;

-- Account Table

CREATE TABLE IF NOT EXISTS Account (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    account_holder VARCHAR(50),
    balance DECIMAL(10,2)
);

INSERT INTO Account (account_id, account_holder, balance) VALUES
(1,'Ram',50000),
(2,'Nischal',100000),
(3,'Sita',200000);

-- Transaction Example
START TRANSACTION;
UPDATE Account SET balance = balance - 5000 WHERE account_id = 1;
UPDATE Account SET balance = balance + 5000 WHERE account_id = 2;
COMMIT;

-- ROLLBACK Example
START TRANSACTION;
UPDATE Account SET balance = balance - 10000 WHERE account_id = 2;
UPDATE Account SET balance = balance + 10000 WHERE account_id = 1;
ROLLBACK;

-- SAVEPOINT Example
START TRANSACTION;
UPDATE Account SET balance = balance - 2000 WHERE account_id = 1;
SAVEPOINT sp1;
UPDATE Account SET balance = balance + 2000 WHERE account_id = 2;
ROLLBACK TO sp1;
COMMIT;

SELECT * FROM Account;

-- Employees Table

CREATE TABLE IF NOT EXISTS employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10,2)
);

CREATE TABLE IF NOT EXISTS salary_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Triggers

DELIMITER $$

-- Prevent salary < 10000
CREATE TRIGGER check_salary
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary < 10000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary must be at least 10000';
    END IF;
END$$

CREATE TRIGGER log_salary_update
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO salary_log(emp_id, old_salary, new_salary)
    VALUES (OLD.emp_id, OLD.salary, NEW.salary);
END$$

DELIMITER ;

-- 1. Get all employees
DELIMITER $$
CREATE PROCEDURE getEmployees()
BEGIN
    SELECT * FROM employees;
END$$
DELIMITER ;

CALL getEmployees();

-- 2. Add new employee
DELIMITER $$
CREATE PROCEDURE addEmployee(
    IN p_id INT,
    IN p_name VARCHAR(100),
    IN p_salary DECIMAL(10,2)
)
BEGIN
    INSERT INTO employees VALUES(p_id,p_name,p_salary);
END$$
DELIMITER ;

CALL addEmployee(1,'Hari',20000);

-- 3. Update employee salary
DELIMITER $$
CREATE PROCEDURE update_salary(
    IN empID INT,
    IN newSalary DECIMAL(10,2)
)
BEGIN
    UPDATE employees
    SET salary = newSalary
    WHERE emp_id = empID;
END$$
DELIMITER ;

-- 4. Transfer money between accounts safely
DELIMITER $$
CREATE PROCEDURE transfer_money(
    IN fromAccount INT,
    IN toAccount INT,
    IN amount DECIMAL(10,2)
)
BEGIN
    DECLARE fromBalance DECIMAL(10,2);

    START TRANSACTION;

    -- Check sender's balance
    SELECT balance INTO fromBalance
    FROM Account
    WHERE account_id = fromAccount;

    IF fromBalance < amount THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Insufficient balance';
    ELSE
        UPDATE Account SET balance = balance - amount WHERE account_id = fromAccount;
        UPDATE Account SET balance = balance + amount WHERE account_id = toAccount;
        COMMIT;
    END IF;
END$$
DELIMITER ;

CALL transfer_money(1,2,5000);


SELECT * FROM Account;