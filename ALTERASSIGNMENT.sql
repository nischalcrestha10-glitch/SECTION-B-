SHOW DATABASES;
USE demp;
CREATE TABLE dept (
    DEPTINO INT PRIMARY KEY,
    DNAME VARCHAR(50),
    LOC VARCHAR(50)
);

-- Rename table
ALTER TABLE dept
RENAME TO department;
-- Add column
ALTER TABLE department
ADD PINCODE VARCHAR(10) NOT NULL;

-- Drop column
ALTER TABLE department
DROP COLUMN PINCODE;

-- Rename column
ALTER TABLE department
RENAME COLUMN DNAME TO DEPT_NAME;

-- Modify column datatype
ALTER TABLE department
MODIFY LOC CHAR(10);

-- Delete table
DROP TABLE department;




