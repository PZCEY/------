use sqlpractice;
SELECT department, Name, Salary from
(select ID as eid,Name,Salary, rank() over(order by salary partition by Id) as ranking
from 
employee) a left join
department 
on a.eid = department.ID
where ranking = 1;