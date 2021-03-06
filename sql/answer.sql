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
ON c.departmentId = e.departmentId and c.salary = e.salary;


select 
case when mod(id,2) =0 then id - 1 else id + 1 end as ID, employee
from seat 
order by ID
;

select 
(case 
when countId = id and mod(id,2) != 0 then id
when countId != id and mod(id,2) != 0 then id+1
when mod(id,2) = 0 then id-1 
end) id, employee
from seat, (select count(id) as countId from seat) cs
order by id;

select count(status), request_at from
trips
group by request_at;

select c.shopid,dt,dt1,dt2 from
(select a.shopid,dt,dt1 from 
sales_record a left join (select shopid, date_sub(dt,interval 1 day) as dt1 from sales_record) b 
on a.shopid = b.shopid and a.dt = b.dt1) c 
left join (select shopid, date_sub(dt,interval 2 day) as dt2 from sales_record) d 
on c.shopid = d.shopid and c.dt = d.dt2
where dt1 is not null and dt2 is not null;

select distinct t1.shopid
from sales_record t1
left join sales_record t2
on t1.shopid = t2.shopid
left join sales_record t3
on t2.shopid = t3.shopid
where t1.dt = t2.dt-1 and t2.dt = t3.dt - 1;

select count(distinct t1.shopid)
from sales_record t1
left join sales_record t2
on t1.shopid = t2.shopid
left join sales_record t3
on t2.shopid = t3.shopid
where t1.dt = t2.dt+1 and t2.dt = t3.dt + 1;

select count(distinct shopid1) from 
(SELECT t1.shopid AS shopid1, t1.dt AS dt1, t1.sale AS sale1
, lead(t1.dt, 1, NULL) OVER (PARTITION BY t1.shopid ORDER BY dt) AS dt2
, lead(t1.dt, 2, NULL) OVER (PARTITION BY t1.shopid ORDER BY dt) AS dt3
FROM sales_record t1) t2
where dt1 = dt2 -1 and dt1 = dt3 - 2;

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
having count(*)>2) c;

select * from(
select Cust_uid, dt, lead(dt,1,null)over(partition by Cust_uid order by dt) as dt1, lead(dt,2,null)over(partition by Cust_uid order by dt) as dt2 from
(select a.Cust_uid,date_format(Trx_tm, '%Y-%m-%d') as dt, Mch_nm from
usr_trx_rcd a left join usr_bas_inf b
on a.Cust_uid = b.Cust_uid
where Mch_nm like '%??????%' and year(Trx_tm)=2021 and month(Trx_tm) >= 03 and gender = 'F') c)
where dt = dt1-1 and dt = dt2-2 ;

select emp_salary, max(cnt) from (
select emp_salary, count(emp_salary) as cnt  from
emp_salary
group by emp_salary)t1;


select avg(emp_salary) from(
select emp_salary, row_number()over(order by emp_salary) as rk, count(1)over() as n
from emp_salary) t1
where rk = (floor(n/2) + 1) or rk = if(mod(n,2)=0,floor(n/2),floor(n/2) + 1);

select emp_salary, row_number()over(order by emp_salary) as rk, count(1)over() as n
from emp_salary;

select shopid,count(dt1) as continue_day from (
select *,date_sub(dt,interval rk day) as dt1 from (
select *,row_number()over(partition by shopid order by dt) as rk
from sales_record ) t1) t2
group by shopid, dt1
having count(dt1) >= 3;

select uid, max(cd) from(
select uid,count(diff) as cd from
(select *, rk1-rk2 as diff from
(select *,row_number()over(partition by uid order by tdate) as rk1,row_number()over(partition by uid, is_flag order by tdate) as rk2
from t
order by uid, tdate) t1) t2
group by uid, diff) t3
group by uid;

create table sqlpractice.rowColumn(
	`a` varchar(255),
    `b` varchar(255),
    `c` varchar(255)
);

insert into sqlpractice.rowColumn values('2014','B','9');
insert into sqlpractice.rowColumn values('2015','A','8');
insert into sqlpractice.rowColumn values('2015','B','7');
insert into sqlpractice.rowColumn values('2014','A','10');

SELECT a, (case when b = 'A' then c end) FROM
sqlpractice.rowColumn


