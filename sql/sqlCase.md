# 常见sql问题专题  

## 分组求最值问题
对于分组求最值问题有两种解法：1. 采用窗口函数 2. 运用聚合函数

```sql
# 窗口函数解法
SELECT department, Name, Salary from
(select ID as eid,Name,Salary, rank() over(order by salary partition by Id) as ranking
from 
employee) a left join
department 
on a.eid = department.ID
where ranking = 1;
```

```sql
# 对子表分组求和，inner join。
select d.Department, e.name as Name, e.salary  from 
department d inner join employee e
on d.ID = e.DepartmentID
INNER JOIN 
(select departmentId, max(salary) as salary from employee
group by departmentID) c
ON c.departmentId = e.departmentId and c.salary = e.salary
```


