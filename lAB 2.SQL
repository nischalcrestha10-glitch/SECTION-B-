CREATE DATABASE Techsolution;
USE Techsolution;


CREATE TABLE DEPARTMENT (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(100) NOT NULL,
    DeptLocation VARCHAR(100)
);

-- Create Employee Table
CREATE TABLE EMPLOYEE (
    EmpID INT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Gender VARCHAR(10),
    Salary DECIMAL(10,2),
    HireDate DATE,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES DEPARTMENT(DeptID)
);

-- Create Project Table
CREATE TABLE PROJECT (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    Budget INT
);

-- Create Works_On Table
CREATE TABLE WORKS_ON (
    EmpID INT,
    ProjectID INT,
    HoursWorked INT,
    PRIMARY KEY (EmpID, ProjectID),
    FOREIGN KEY (EmpID) REFERENCES EMPLOYEE(EmpID),
    FOREIGN KEY (ProjectID) REFERENCES PROJECT(ProjectID)
);

-- Insert Department Records
INSERT INTO DEPARTMENT VALUES
(1, 'Human Resources', 'Kathmandu'),
(2, 'IT', 'Lalitpur'),
(3, 'Finance', 'Bhaktapur'),
(4, 'Marketing', 'Pokhara'),
(5, 'Customer Support', 'Biratnagar');

-- Insert Employee Records
INSERT INTO EMPLOYEE VALUES
(101, 'Ram', 'Sharma', 'Male', 50000, '2022-01-10', 2),
(102, 'Sita', 'Koirala', 'Female', 45000, '2021-03-15', 1),
(103, 'Hari', 'Thapa', 'Male', 60000, '2020-07-20', 3),
(104, 'Gita', 'Rai', 'Female', 48000, '2023-02-01', 4),
(105, 'Krishna', 'Adhikari', 'Male', 52000, '2022-11-12', 5);

-- Insert Project Records
INSERT INTO PROJECT VALUES
(201, 'Website Development', '2022-01-01', '2024-06-01', 100000),
(202, 'Mobile App', '2022-02-10', '2024-07-15', 150000),
(203, 'Accounting System', '2024-03-05', '2024-08-20', 120000),
(204, 'Marketing Campaign', '2024-04-01', '2024-09-01', 80000),
(205, 'Customer Portal', '2024-05-10', '2024-10-10', 90000);

-- Insert Works_On Records
INSERT INTO WORKS_ON VALUES
(101, 201, 40),
(102, 202, 35),
(103, 203, 50),
(104, 204, 30),
(105, 205, 45);


UPDATE EMPLOYEE
SET Salary = Salary * 1.10;

DELETE FROM PROJECT
WHERE ProjectID = 205;

SELECT *
FROM EMPLOYEE
WHERE Salary > 50000;

SELECT Firstname, Lastname, Salary
From employee
order by Salary DESC;

SELECT E.EmpID, E.FirstName, E.LastName, E.Salary, D.DeptName
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DeptID = D.DeptID
WHERE D.DeptName = 'IT';

SELECT D.DeptName, COUNT(E.EmpID) AS TotalEmployees
FROM DEPARTMENT D
LEFT JOIN EMPLOYEE E ON D.DeptID = E.DeptID
GROUP BY D.DeptName;

SELECT *
FROM EMPLOYEE
WHERE HireDate > '2022-01-01';

SELECT E.FirstName, E.LastName, D.DeptName
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DeptID = D.DeptID;

SELECT E.FirstName, E.LastName, P.ProjectName
FROM EMPLOYEE E
JOIN WORKS_ON W ON E.EmpID = W.EmpID
JOIN PROJECT P ON W.ProjectID = P.ProjectID; 

SELECT P.ProjectName, SUM(W.HoursWorked) AS TotalHours
FROM PROJECT P
JOIN WORKS_ON W ON P.ProjectID = W.ProjectID
GROUP BY P.ProjectName;

SELECT D.DeptName, AVG(E.Salary) AS AvgSalary
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DeptID = D.DeptID
GROUP BY D.DeptName;

SELECT D.DeptName, COUNT(E.EmpID) AS TotalEmployees
FROM DEPARTMENT D
JOIN EMPLOYEE E ON D.DeptID = E.DeptID
GROUP BY D.DeptName
ORDER BY TotalEmployees DESC
LIMIT 1;

SELECT *
FROM EMPLOYEE
WHERE Salary > (SELECT AVG(Salary) FROM EMPLOYEE);

CREATE VIEW HighSalaryEmployee AS
SELECT EmpID, FirstName, LastName, Salary
FROM EMPLOYEE
WHERE Salary > 60000;

CREATE INDEX idx_lastname
ON EMPLOYEE (LastName);

