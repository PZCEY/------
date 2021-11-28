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

## 序号调换的问题
一般可能会用到奇偶数的trick。可以用case when来判断规则
```sql
select 
(case 
when countId = id and mod(id,2) != 0 then id
when countId != id and mod(id,2) != 0 then id+1
when mod(id,2) = 0 then id-1 
end) id, employee
from seat, (select count(id) as countId from seat) cs
order by id;
```

## 计算取消率
```sql
select
Request_at Day,
count(*),
sum(if(status='completed',0,1)),
round(sum(if(Status='completed',0,1))/count(*) ,2) Cancellation_Rate
from users u
left join trips t
on u.Users_ID = t.Client_ID
where banned = 'NO' and Request_at between '2019-10-01' and '2019-10-03'
group by Request_at
```

