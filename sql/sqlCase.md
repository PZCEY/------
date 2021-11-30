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

## 连续天数问题
> 该类问题一般用于计算连续打卡，用户留存率等问题当中  

解法一： 
```sql
-- 连续join
select count(distinct t1.shopid)
from sales_record t1
left join sales_record t2
on t1.shopid = t2.shopid
left join sales_record t3
on t2.shopid = t3.shopid
where t1.dt = t2.dt+1 and t2.dt = t3.dt + 1;
```
解法二：
```sql
-- lead函数
select count(distinct shopid1) from 
(SELECT t1.shopid AS shopid1, t1.dt AS dt1, t1.sale AS sale1
, lead(t1.dt, 1, NULL) OVER (PARTITION BY t1.shopid ORDER BY dt) AS dt2
, lead(t1.dt, 2, NULL) OVER (PARTITION BY t1.shopid ORDER BY dt) AS dt3
FROM sales_record t1) t2
where dt1 = dt2 -1 and dt1 = dt3 - 2
```
解法三：
```sql
-- 用rawnumber函数进行排序编号，然后再用日期减去编号
select distinct shopid from
(
select * from
(select *,dt-rn as d from
(select
shopid,
dt,
sale,
row_number() OVER (PARTITION BY shopid ORDER BY dt) AS rn
FROM sales_record) a) b 
group by shopid, d
having count(*)>2) c
```

