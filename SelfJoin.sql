-- A self-join is used when you want to join a table with itself. This can be particularly
-- useful in scenarios where the table's rows have a relationship with other rows in the 
-- same table. Here are some common scenarios where a self-join is appropriate:

Hierarchical Data (e.g., Employee-Manager Relationships)
Use Case: When you have a table of employees where each employee 
might report to another employee (i.e., a manager), and you want to 
find relationships like "who reports to whom."

SELECT e1.employee_id AS EmployeeID, e1.name AS EmployeeName, e2.name AS ManagerName
FROM Employees e1
LEFT JOIN Employees e2 ON e1.reports_to = e2.employee_id;
-- In this example, we're joining the Employees table with itself, using the reports_to column as

Finding Pairs of Related Data
Use Case: When you want to find all pairs of rows in 
a table that share a certain relationship.

SELECT p1.product_name AS Product1, p2.product_name AS Product2
FROM Products p1
JOIN Products p2 ON p1.category_id = p2.category_id
WHERE p1.product_id <> p2.product_id;
-- In this example, we're joining the Products table with itself, using the category_id column as

Comparing Rows in the Same Table
Use Case: When you need to compare rows in the same table to find, 
for example, duplicates, find rows with a certain condition relative to others, etc.

SELECT e1.name AS Employee1, e2.name AS Employee2, e1.job_title
FROM Employees e1
JOIN Employees e2 ON e1.job_title = e2.job_title
WHERE e1.employee_id <> e2.employee_id;
-- In this example, we're joining the Employees table with itself, using the job_title column as

Finding Successive Rows
Use Case: When you need to find relationships between successive rows, such as finding 
an employee who joined the company immediately after another employee.

SELECT e1.name AS CurrentEmployee, e2.name AS NextEmployee
FROM Employees e1
JOIN Employees e2 ON e1.join_date < e2.join_date
ORDER BY e1.join_date, e2.join_date;
