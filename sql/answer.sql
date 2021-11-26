use sqlpractice;
SELECT department, Name, Salary 
from
(select departmentid as eid,Name,Salary, rank() over(partition by DepartmentID order by salary DESC) as ranking
from 
employee) a left join
department 
on a.eid = department.ID
where ranking = 1;

select d.Department, e.name as Name, e.salary  from 
department d inner join employee e
on d.ID = e.DepartmentID
INNER JOIN 
(select departmentId, max(salary) as salary from employee
group by departmentID) c
ON c.departmentId = e.departmentId and c.salary = e.salary