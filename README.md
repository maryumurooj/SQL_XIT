# SQL_XIT
## Basic Querying:
 Retrieve all columns from the &quot;Employees&quot; table.
 Retrieve the names of all employees who belong to the &quot;Sales&quot; department.
 Retrieve the total number of employees in each department.

## Data Manipulation:
 Insert a new employee into the &quot;Employees&quot; table.
 Update the salary of all employees in the &quot;Finance&quot; department by increasing
it by 10%.
 Delete all employees who have been with the company for more than 10
years.

## Join Operations:
 Retrieve the names of employees along with their department names.
 Retrieve the names of employees who have at least one order in the &quot;Orders&quot;
table.
 Retrieve the total sales amount for each employee.

## Subqueries and Aggregation:
 Retrieve the names of departments along with the total number of employees
in each department.
 Retrieve the name of the employee with the highest salary.
 Retrieve the average salary of employees in the &quot;IT&quot; department.

## Constraints and Indexing:
 Add a unique constraint on the &quot;Email&quot; column of the &quot;Employees&quot; table.
 Create an index on the &quot;LastName&quot; column of the &quot;Employees&quot; table.
 Add a foreign key constraint between the &quot;EmployeeID&quot; column of the
&quot;Orders&quot; table and the &quot;EmployeeID&quot; column of the &quot;Employees&quot; table.

## Stored Procedures and Functions:
 Create a stored procedure to retrieve all employees from a specified
department.
 Create a function to calculate the age of an employee based on their date of
birth.
 Create a stored procedure to update the salary of an employee and log the
changes in an audit table.

## Transactions and Locking:
 Wrap a series of SQL statements in a transaction to ensure atomicity.
 Use locking hints to prevent concurrent access to critical resources during an
update operation.
 Handle deadlock scenarios and implement strategies to minimize their
occurrence.

## Performance Optimization:
 Identify and optimize slow-performing queries using query execution plans
and indexing strategies.
 Rewrite complex queries to improve readability and performance.
 Monitor database performance metrics and make recommendations for
optimization based on findings.

## Backup and Restore:
 Schedule regular backups of the database and transaction logs.
 Perform a full database restore to a point-in-time using the latest backup.
 Test the backup and restore process to ensure data integrity and
recoverability.

## Security and Permissions:
 Create database users and assign appropriate permissions to access specific
tables or execute stored procedures.
 Implement row-level security to restrict access to sensitive data based on user
roles or attributes.
 Audit database activity to track changes and identify potential security threats.
