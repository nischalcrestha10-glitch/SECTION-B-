
-- 1. Create Database
CREATE DATABASE IF NOT EXISTS assignment1;

-- Use Database
USE assignment1;

-- 2. Drop Tables if They Exist
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Persons;
DROP TABLE IF EXISTS Students;

-- 3. Create Persons Table

CREATE TABLE Persons (
    PersonID INT PRIMARY KEY,
    LastName VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255) NOT NULL,
    Address VARCHAR(255),
    HomeCity VARCHAR(255)
);

-- Insert Sample Data into Persons
INSERT INTO Persons (PersonID, LastName, FirstName, Address, HomeCity)
VALUES 
(1, 'Shrestha', 'Nischal', 'Kathmandu Street', 'Kathmandu'),
(2, 'Acharya', 'Anuz', 'Pokhara Street', 'Pokhara'),
(3, 'Gurung', 'Ram', 'Lalitpur Street', 'Lalitpur');


-- 4. Create Orders Table

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    PersonID INT,
    ProductName VARCHAR(100),
    FOREIGN KEY (PersonID) REFERENCES Persons(PersonID)
);

-- Insert Sample Data into Orders
INSERT INTO Orders (OrderID, PersonID, ProductName)
VALUES 
(1, 1, 'Laptop'),
(2, 1, 'Mobile'),
(3, 2, 'Tablet'),
(4, 4, 'Headphones');  -- PersonID 4 does not exist (to test JOINs)


-- 5. Create Students Table (Constraints)

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT CHECK (Age >= 18),
    Email VARCHAR(100) UNIQUE
);

-- 6. Operators Examples

-- Comparison Operator (=)
SELECT * FROM Persons WHERE PersonID = 1;

-- Greater Than (>)
SELECT * FROM Persons WHERE PersonID > 1;

-- Not Equal (!=)
SELECT * FROM Persons WHERE HomeCity != 'Pokhara';

-- Logical Operator (AND)
SELECT * FROM Persons WHERE PersonID > 1 AND HomeCity = 'Pokhara';

-- Logical Operator (OR)
SELECT * FROM Persons WHERE HomeCity = 'Pokhara' OR HomeCity = 'Biratnagar';

-- BETWEEN Operator
SELECT * FROM Persons WHERE PersonID BETWEEN 1 AND 2;

-- IN Operator
SELECT * FROM Persons WHERE HomeCity IN ('Pokhara', 'Biratnagar');

-- LIKE Operator
SELECT * FROM Persons WHERE LastName LIKE 'S%';

-- Arithmetic Operators
SELECT 10 + 5 AS Addition_Result;
SELECT 20 - 7 AS Subtraction_Result;
SELECT PersonID, PersonID + 5 AS Added_Value FROM Persons;
SELECT PersonID, PersonID - 1 AS Subtracted_Value FROM Persons;

-- JOINS 

-- INNER JOIN
SELECT Persons.PersonID, Persons.FirstName, Orders.ProductName
FROM Persons
INNER JOIN Orders
ON Persons.PersonID = Orders.PersonID;

-- LEFT JOIN
SELECT Persons.PersonID, Persons.FirstName, Orders.ProductName
FROM Persons
LEFT JOIN Orders
ON Persons.PersonID = Orders.PersonID;

-- RIGHT JOIN
SELECT Persons.PersonID, Persons.FirstName, Orders.ProductName
FROM Persons
RIGHT JOIN Orders
ON Persons.PersonID = Orders.PersonID;

-- FULL OUTER JOIN 
SELECT Persons.PersonID, Persons.FirstName, Orders.ProductName
FROM Persons
LEFT JOIN Orders
ON Persons.PersonID = Orders.PersonID
UNION
SELECT Persons.PersonID, Persons.FirstName, Orders.ProductName
FROM Persons
RIGHT JOIN Orders
ON Persons.PersonID = Orders.PersonID;
