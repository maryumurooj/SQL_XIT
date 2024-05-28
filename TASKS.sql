--BASIC QUERYING
SELECT * FROM Employees;

SELECT FirstName, LastName
FROM Employees
WHERE DepartmentID = (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Sales');

SELECT d.DepartmentName, COUNT(e.EmployeeID) AS TotalEmployees
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;


--DATA MANUPILATION

INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, JobTitle, DepartmentID, ManagerID, HireDate, Salary, DateOfBirth)
VALUES (5, 'Maryum', 'Urooj', 'maryum@example.com', 'Marketing Intern', 1, 2, '2024-05-20', 75000.00, '2002-05-18');

UPDATE Employees
SET Salary = Salary * 1.10
WHERE DepartmentID = (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Finance');

DELETE FROM Employees
WHERE DATEDIFF(YEAR, HireDate, GETDATE()) > 10;
--this is not working

--new apprach
-- Delete orders for employees who have been with the company for more than 10 years
DELETE FROM Orders
WHERE EmployeeID IN (
    SELECT EmployeeID
    FROM Employees
    WHERE DATEDIFF(YEAR, HireDate, GETDATE()) > 10
);

-- Delete employees who have been with the company for more than 10 years
DELETE FROM Employees
WHERE DATEDIFF(YEAR, HireDate, GETDATE()) > 10;


--JOIN OPERATIONS

SELECT e.FirstName, e.LastName, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID;

SELECT DISTINCT e.FirstName, e.LastName
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID;

SELECT e.FirstName, e.LastName, SUM(o.TotalAmount) AS TotalSales
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.FirstName, e.LastName;

--SUBQUERIES AND AGGREGATION

SELECT d.DepartmentName, COUNT(e.EmployeeID) AS TotalEmployees
FROM Departments d
LEFT JOIN Employees e ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName;

SELECT FirstName, LastName
FROM Employees
WHERE Salary = (SELECT MAX(Salary) FROM Employees);

SELECT AVG(Salary) AS AverageSalary
FROM Employees
WHERE DepartmentID = (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'IT');

--CONSTAINTS AND INDEXING

ALTER TABLE Employees
ADD CONSTRAINT UQ_Email UNIQUE (Email);

CREATE INDEX idx_LastName ON Employees(LastName);

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID);


-- STROED PROCEDURE AND FUCNTIONS

--retrieve all employees from a specified department.
CREATE PROCEDURE GetEmployeesByDepartment
    @DepartmentName NVARCHAR(50)
AS
BEGIN
    SELECT e.FirstName, e.LastName, d.DepartmentName
    FROM Employees e
    JOIN Departments d ON e.DepartmentID = d.DepartmentID
    WHERE d.DepartmentName = @DepartmentName;
END;

--calculate the age of an employee based on their date of birth
CREATE FUNCTION CalculateAge(@DateOfBirth DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(YEAR, @DateOfBirth, GETDATE()) - 
           CASE WHEN MONTH(GETDATE()) < MONTH(@DateOfBirth) OR (MONTH(GETDATE()) = MONTH(@DateOfBirth) AND DAY(GETDATE()) < DAY(@DateOfBirth)) THEN 1 ELSE 0 END;
END;

--to update the salary of an employee and log the changes in an audit table
CREATE TABLE SalaryAudit (
    AuditID INT IDENTITY PRIMARY KEY,
    EmployeeID INT,
    OldSalary DECIMAL(10, 2),
    NewSalary DECIMAL(10, 2),
    ChangeDate DATETIME DEFAULT GETDATE()
);

CREATE PROCEDURE UpdateEmployeeSalary
    @EmployeeID INT,
    @NewSalary DECIMAL(10, 2)
AS
BEGIN
    DECLARE @OldSalary DECIMAL(10, 2);
    SELECT @OldSalary = Salary FROM Employees WHERE EmployeeID = @EmployeeID;

    UPDATE Employees
    SET Salary = @NewSalary
    WHERE EmployeeID = @EmployeeID;

    INSERT INTO SalaryAudit (EmployeeID, OldSalary, NewSalary)
    VALUES (@EmployeeID, @OldSalary, @NewSalary);
END;

--TRANSACTIONS 

--atomicity
BEGIN TRANSACTION;

BEGIN TRY
    -- Your series of SQL statements here
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    -- Handle the error
END CATCH;

--locking hints to prevent concurrent access to critical resources during an update operation.
UPDATE Employees WITH (HOLDLOCK)
SET Salary = Salary * 1.05
WHERE DepartmentID = (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Sales');


--Handle deadlock scenarios
-- Example of deadlock handling with TRY...CATCH
BEGIN TRY
    BEGIN TRANSACTION;

    -- SQL operations that might cause deadlocks
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0
        ROLLBACK TRANSACTION;
    -- Log the error or take corrective actions
END CATCH;


--PERFORMANCE OPERATIONS

-- query execution plans and indexing strategies.
--not sure exactly what to do..

-- Example indexing strategy
CREATE INDEX idx_EmployeeID ON Orders(EmployeeID);



--complex queries to improve readability and performance
-- ...i just gav an eg here
-- complex query
WITH EmployeeSales AS (
    SELECT e.EmployeeID, e.FirstName, e.LastName, SUM(o.TotalAmount) AS TotalSales
    FROM Employees e
    JOIN Orders o ON e.EmployeeID = o.EmployeeID
    GROUP BY e.EmployeeID, e.FirstName, e.LastName
)

--simple
SELECT es.EmployeeID, es.FirstName, es.LastName, es.TotalSales
FROM EmployeeSales es
ORDER BY es.TotalSales DESC;

--Monitor database performance metrics and make recommendations for optimization based on findings
--im not sure what to do here

--Backup and Restore
-- Full database backup
BACKUP DATABASE empdatabase TO DISK = 'C:\Backups\YourDatabase.bak' WITH FORMAT;

-- Transaction log backup
BACKUP LOG empdatabase TO DISK = 'C:\Backups\YourDatabaseLog.trn' WITH FORMAT;

-- Restore to a test environment and verify data integrity
RESTORE DATABASE TestYourDatabase
FROM DISK = 'C:\Backups\YourDatabase.bak'
WITH MOVE 'YourDatabase_Data' TO 'C:\TestBackups\TestYourDatabase_Data.mdf',
     MOVE 'YourDatabase_Log' TO 'C:\TestBackups\TestYourDatabase_Log.ldf';


--Security and Permissions

-- Create a new user
CREATE LOGIN TestUser WITH PASSWORD = 'SecurePassword!';
CREATE USER TestUser FOR LOGIN TestUser;

-- Assign permissions
GRANT SELECT ON Employees TO TestUser;
GRANT EXECUTE ON GetEmployeesByDepartment TO TestUser;


--Implement row-level security to restrict access to sensitive data based on user roles or attributes
-- Step 1: Create the Security Predicate Function
IF OBJECT_ID('dbo.fn_securitypredicate', 'IF') IS NOT NULL
    DROP FUNCTION dbo.fn_securitypredicate;
GO

CREATE FUNCTION dbo.fn_securitypredicate(@EmployeeID INT)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN 
(
    SELECT 1 AS fn_securitypredicate_result
    WHERE @EmployeeID = USER_ID()
);
GO

-- Step 2: Create the Security Policy
IF EXISTS (SELECT * FROM sys.security_policies WHERE name = 'EmployeeSecurityPolicy')
    DROP SECURITY POLICY dbo.EmployeeSecurityPolicy;
GO

CREATE SECURITY POLICY dbo.EmployeeSecurityPolicy
ADD FILTER PREDICATE dbo.fn_securitypredicate(EmployeeID)
ON dbo.Employees
WITH (STATE = ON);
GO


--Audit database activity to track changes
-- Enable auditing
CREATE SERVER AUDIT YourAudit
TO FILE (FILEPATH = 'C:\AuditLogs\');
ENABLE AUDIT YourAudit;

-- Create an audit specification
-- not sure what to do..