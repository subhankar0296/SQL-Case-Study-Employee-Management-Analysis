Create table Location(Location_ID int Primary Key, City Varchar (30))

Insert into Location values (122, 'NewYork'), (123, 'Dallas'), (124, 'Chicago'), (167, 'Boston');

Create table Department(Department_Id int primary key,	Name varchar (30), 
	Location_Id int foreign key references location(Location_ID));

Insert into Department values(10, 'Accounting', 122),
(20, 'Sales', 124), (30, 'Research', 123), (40, 'Operations', 167)


Create Table Job(Job_ID int Primary key, Designation varchar(30));

Insert into Job values(667, 'Clerk'), (668, 'Staff'), (669, 'Analyst'),
(670, 'SalesPerson'), (671, 'Manager'), (672, 'President');


Create Table Employee (Employee_Id int, Last_Name varchar (20), First_Name varchar (20), Middle_Name varchar (20),
Job_Id int foreign key references  Job(Job_ID), HireDate date, Salary float, Comm float, 
Department_Id int foreign key references Department(Department_Id));

Insert into Employee values(7369, 'Smith', 'John', 'Q', 667, '1984-12-17', 800, NULL, 20),
		(7499, 'Allen', 'Kevin', 'J', 670, '1985-02-20', 1600, 300, 30),
		(755, 'Doyle', 'Jean', 'K', 671, '1985-04-04', 2850, NULL, 30),
		(756, 'Dennis', 'Lynn', 'S', 671, '1985-05-15', 2750, NULL, 30),
		(757, 'Baker', 'Leslie', 'D', 671, '1985-06-10', 2200, NULL, 40),
		(7521, 'Wark', 'Cynthia', 'D', 670, '1985-02-22', 1250, 50, 30);


 --SimpleQueries:
 --  1. Listall the employee details.
Select * from Employee;


--  2. Listall the department details.
Select * from Department;


--  3. Listall job details.
Select * from Job;


--  4. Listall the locations.
Select * from Location;


-- 5.  List out the FirstName,LastName,Salary,Commission for all Employees.
select First_Name,Last_Name,Salary,Comm from Employee;


-- 6. List out the EmployeeID,LastName,Department ID for all employees and alias
--  Employee ID as "ID of the Employee",LastNameas"Name of the Employee",Department ID as"Dep_id".
SELECT Employee_Id AS [ID of the Employee], Last_Name AS [Name of the Employee] ,Department_ID AS Dep_ID FROM Employee;


-- 7. Listout the annual salary of theemployees with their name sonly.
SELECT concat_ws(' ', First_Name, Middle_Name,Last_Name) AS Full_Name,
 (Salary * 12) AS Annual_Salary FROM Employee;


  --WHERECondition:
  --  1. List thedetailsabout"Smith".
select * from Employee where Last_Name= 'Smith'


--  2. Listout theemployeeswhoareworkingindepartment20.
select * from Employee where Department_Id=20;


--  3. Listout theemployeeswhoareearningsalariesbetween3000and4500.
select * from Employee where Salary between 3000 and 4500;


--  4. Listout theemployeeswhoareworkingindepartment10or20.
select * from Employee where Department_Id = 10 or Department_Id=20;


--  5. Findout theemployeeswhoarenotworkingindepartment10or30.
select * from Employee where Department_Id not in( 10, 30);


--  6. Listout theemployeeswhosenamestartswith'S'.
select * from Employee where First_Name like 'S%' or Last_Name like 's%'  -- Selected last_Name as well as there was noone by the name of "S"


--  7. List out the employees whose name starts with 'S' and ends with'H'.
select * from Employee where First_Name like 'S%H' or Last_Name like 'S%H'


--  8. List out the employees whose name length is 4 and start with'S'.
select * from Employee where len(First_Name) = 4 and First_Name like 'S%' or LEN(Last_Name) = 4 and Last_Name like 'S%';



--  9. List out employees who are working in department 10 and draw salariesmore than 3500
select * from Employee where Department_Id=10 and Salary > 3500

--  10.List out the employees who are not receiving commission.
select * from Employee where Comm is null or comm=0;



 --ORDERBYClause:
 -- 1.  List out the Employee ID and Last Name in ascending order based on the Employee ID.
 Select Employee_ID, Last_name from Employee order by Employee_Id;


 --  2. List out the Employee ID and Name in descending order based onsalary.
Select Employee_ID, concat_ws(' ', First_Name, Middle_Name,Last_Name) AS Name from Employee order by Salary desc;


--  3. List out the employee details according to their Last Name in ascending-order.
Select concat_ws(' ',Last_Name , Middle_Name,First_Name) AS Name from Employee order by Last_Name;


--  4. List out the employee details according to their Last Name inascending order and then Department ID in descending order.
Select * from Employee order by Last_Name, Department_Id desc;




--GROUPBY and HAVING Clause:

--  1. How many employees are in different departments in the organization?
select Department_Id, count(*) from Employee group by Department_Id;


-- 2. List out the department wise maximum salary, minimum salaryand average salary of the employees.
select D.Name, MAX(Salary) Max_Salary, MIN(Salary) Min_Salary, Avg(Salary) Avg_Salary from Employee E
Join Department D on E.Department_Id= D.Department_Id group by D.Name;


-- 3. List out the job wise maximum salary, minimum salary andaverage salary of the employees.
select J.Designation, MAX(Salary) Max_Salary, MIN(Salary) Min_Salary, Avg(Salary) Avg_Salary from Employee E
Join Job J on E.Job_Id= J.Job_ID group by J.Designation;


--  4. List out the number of employees who joined each month in ascending order.
select DATENAME(Month,HireDate) as Month_Name, COUNT(*) Number_of_Employee 
from Employee group by DATENAME(Month,hiredate) order by Month_Name;


-- 5. List out the number of employees for each month and year in ascending order based on the year and month.
select MONTH(Hiredate) Month, YEAR(hiredate) Year, COUNT(*) Number_of_Employee
From Employee group by YEAR(hiredate), MONTH(Hiredate) order by Year;


--  6. List out the Department ID having at least four employees.
Select Department_id, count(Last_Name) as Number_of_Employee 
from Employee Group by Department_Id having count(Last_Name) >=4;



--  7. How many employees joined in the month of January?
Select MONTH(hiredate) As Month, COUNT(*) Number_of_Employee from Employee
group by MONTH(Hiredate) having MONTH(hiredate) = 1;


-- 8. How many employees joined in the month of January or September?
Select Count(*) Number_of_Employee from Employee where MONTH(Hiredate) = 1 or MONTH(Hiredate) = 9;


--  9. Howmany employees joined in 1985?
Select COUNT(*) as Number_of_Employee from Employee where YEAR(Hiredate) = 1985;


--  10. How many employees joined each month in 1985?
Select MONTH(Hiredate) Hired_month, Count(*) Number_of_Employee
from Employee where YEAR(Hiredate) = 1985 group by MONTH(Hiredate)


--  11. How many employees joined in March 1985?
Select COUNT(*) Number_of_Employee from Employee where MONTH(hiredate) = 3 and YEAR(Hiredate) = 1985;


-- 12. Which is the Department ID having greater than or equal to 3 employees joining in April 1985?
Select Department_ID , Count(*) from Employee 
where MONTH(Hiredate) = 4 and YEAR(Hiredate)=1985 group by Department_Id
having COUNT(*) >= 3



--Joins:
 -- 1. List out employees with their department names.
 Select CONCAT_WS(' ',First_Name, Middle_Name, Last_Name) as Name, D.Name from Employee E
 join Department D on E.Department_Id= D.Department_Id;


 -- 2. Display employees with their designations.
select CONCAT_WS(' ',First_Name, Middle_Name, Last_Name) as Name, J.Designation
from Employee E join Job J on E.Job_Id=J.Job_ID;


--  3. Display the employees with their department names and regional groups.
Select CONCAT_WS(' ',First_Name, Middle_Name, Last_Name) as Employee_Name, D.Name as Department, L.City
from Employee E join Department D on E.Department_Id=D.Department_Id
join Location L on D.Location_Id=L.Location_ID;


-- 4. How many employees are working in different departments? Display with department names.
Select D.Name as Department, COUNT(*) Total_Employee from Employee E
join Department D on E.Department_Id=D.Department_Id group by D.Name;

--  5. How many employees are working in the sales department?
Select D.Name, COUNT(*) Total_Employee from Employee E
join Department D on E.Department_Id=D.Department_Id where D.Name='Sales' group by D.Name;


-- 6. Which is the department having greater than or equal to 5
 --employees? Display the department names in ascending order
 select D.Name, Count(*) Total_Employee from Employee E
 join Department D on E.Department_Id=D.Department_Id
 group by D.Name having Count(*) >=5 order by D.Name;


 -- 7. How many jobs are there in the organization? Display with designations.
 select J.Designation as Designation, COUNT(*) Total_Jobs from Employee E
 join Job J on E.Job_Id=J.Job_ID group by j.Designation;


 --  8. How many employees are working in "New York"?
Select L.City, COUNT(*) from Employee E
join Department D on E.Department_Id=D.Department_Id
Join Location L on D.Location_Id=L.Location_ID where L.City='NewYork' group by L.City


-- 9. Display the employee details with salary grades. Use conditional statementto create a grade column.
Select *, Case
When Salary > 2000 Then 'High Salary'
When Salary between 1000 and 2000 Then 'Mid Salary'
Else 'Low Salary'
End as Grade from Employee;


-- 10.  List out the number of employees grade wise. Use conditional statementto create a grade column
With Employee_Grade
as
(Select *, Case
When Salary > 2000 Then 'High Salary'
When Salary between 1000 and 2000 Then 'Mid Salary'
Else 'Low Salary'
End as Grade from Employee)
select Grade, COUNT(*) as Total_Employees from Employee_Grade group by Grade;

-- 11. Display the employee salary grades and the number ofemployees between 2000 to 5000 range of salary.
With Employee_Grade
as
(Select *, Case
When Salary > 2000 Then 'High Salary'
When Salary between 1000 and 2000 Then 'Mid Salary'
Else 'Low Salary'
End as Grade from Employee)
select Grade, COUNT(*) as Total_Employees from Employee_Grade where salary between 2000 and 5000 group by Grade;

-- 12. Display all employees in sales or operation departments
Select D.Name as Department_Name, COUNT(*) Total_Employees from Employee E
join department D on E.Department_Id=D.Department_Id
where D.Name = 'Sales' or D.Name= 'Operations' group by D.Name;


--  SET Operators:
 -- 1. List out the distinct jobs in sales and accounting departments.
select distinct job_id from Employee where Department_Id= (Select Department_Id from Department where name='Sales')
union
select distinct Job_Id from Employee where Department_Id=(Select Department_Id from Department where name='Accounting');



-- 2. List out all the jobs in sales and accounting departments.
SELECT E.Job_Id FROM Employee E
JOIN Department D ON E.Department_Id = D.Department_Id
WHERE D.Name IN ('Sales', 'Accounting');


--	3. List out the common jobs in research and accounting departments in ascending order.
select job_id from Employee where Department_Id= (Select Department_Id from Department where name='research')
union
select Job_Id from Employee where Department_Id=(Select Department_Id from Department where name='Accounting')
order by Job_Id;


--  Subqueries:
	 -- 1. Display the employees list who got the maximum salary.
	 select CONCAT_WS(' ',First_Name, Middle_Name, Last_Name), Salary as Employee_Name
	 from Employee where  salary = (select max(salary) from Employee);

	 --  2. Display the employees who are working in the sales department.
	  select CONCAT_WS(' ',First_Name, Middle_Name, Last_Name) as Employee_Name from Employee
	  where Department_id = (select Department_Id from Department where name = 'Sales');


	--  3. Display the employees who are working as 'Clerk'.
	select CONCAT_WS(' ',First_Name, Middle_Name, Last_Name) as Employee_Name from Employee
	  where Job_Id = (Select Job_Id from job where Designation = 'Clerk')


	  -- 4.  4. Display the list of employees who are living in "New York".
	  select CONCAT_WS(' ',First_Name, Middle_Name, Last_Name) as Employee_Name from Employee E
	  join Department D on E.Department_Id=D.Department_Id
	  where D.Location_Id = (select Location_Id from Location where City = 'NewYork')

	-- 5.  5. Find out the number of employees working in the salesdepartment.
	select count(*) total_employee from Employee
	where Department_Id = (Select Department_Id from Department where name = 'Sales')


	-- 6. Update the salaries of employees who are working as clerks on the basis of 10%.
	select salary + (salary *0.10) as Updated_Salary from Employee
	where Job_Id= (select Job_Id from job where Designation='Clerk')

	
	--  7. Delete the employees who are working in the accountingdepartment.
	Delete from Employee where Department_Id = (select Department_Id from Department where name = 'Accounting');
	

	--	 8. Display the second highest salary drawing employee details.
	With Salary_Rank
	as(
	select CONCAT_WS(' ',First_Name, Middle_Name, Last_Name) as Employee_Name, Salary,
	RANK() over (order by salary desc) as Rank_Num from Employee)
	select * from salary_Rank where rank_num =2


	--  9. Display the nth highest salary drawing employee details.
With Salary_Rank
	as(
	select CONCAT_WS(' ',First_Name, Middle_Name, Last_Name) as Employee_Name, Salary,
	row_number() over (order by salary desc) as Row_Num from Employee)
	select * from salary_Rank where row_num = 3

	
	--  10. List out the employees who earn more than every employee in department30.
	SELECT CONCAT_WS(' ', First_Name, Middle_Name, Last_Name) AS Employee_Name, Salary
	FROM Employee WHERE Salary > all (SELECT Salary FROM Employee WHERE Department_Id = 30);


	-- 11.  List out the employees who earn more than the lowest salaryin department.Find out whose department has no employees
	select * from Employee where Salary > (select MIN(salary) from Employee);

	select D.Department_Id, D.Name from Department D 
	left join Employee E on D.Department_Id=E.Department_Id where Employee_Id is null;

	select * from Employee
	

	--  12. Find out which department has no employees.
	select D.Department_Id, D.Name from Department D 
	left join Employee E on D.Department_Id=E.Department_Id where Employee_Id is null;


	-- 13. Find out the employees who earn greater than the average salary for their department
	select D.name as Department_Name, CONCAT_WS(' ',First_Name, Middle_Name, Last_Name) as Employee_Name, Salary
	From Employee E inner join Department D on E.Department_Id=D.Department_Id
	where Salary > ( select AVG(salary) from Employee WHERE Department_Id = E.Department_Id);