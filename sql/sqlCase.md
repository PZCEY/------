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
### 连续登录的变体问题--连续次数

```sql
--排两次序
select uid, max(cd) from(
select uid,count(diff) as cd from
(select *, rk1-rk2 as diff from
(select *,row_number()over(partition by uid order by tdate) as rk1,row_number()over(partition by uid, is_flag order by tdate) as rk2
from t
order by uid, tdate) t1) t2
group by uid, diff) t3
group by uid;
```


## 留存率
![avatar](/sql/scene1_tb_str.png)

```sql
select 
t1.load_dt,
count(t1.usr_id),
count(t2.usr_id),
count(t3.usr_id),
count(t4.usr_id),
count(distinct t2.usr_id)/count(distinct t1.usr_id) as ratio1,
count(distinct t3.usr_id)/count(distinct t1.usr_id) as ratio2,
count(distinct t4.usr_id)/count(distinct t1.usr_id) as ratio3
from
(select usr_id, min(load_dt) load_dt from
 td_load_rcd
 group by usr_id) t1 left join 
(select load_dt, usr_id from td_load_rcd group by load_dt, usr_id) t2 on
t1.usr_id = t2.usr_id and 
t1.load_dt = date_sub(t2.load_dt, interval 1 day) left join
(select load_dt, usr_id from td_load_rcd group by load_dt, usr_id) t3 on
t1.usr_id = t3.usr_id and 
t1.load_dt = date_sub(t3.load_dt, interval 3 day) left join
(select load_dt, usr_id from td_load_rcd group by load_dt, usr_id) t4 on
t1.usr_id = t4.usr_id and
t1.load_dt = date_sub(t4.load_dt, interval 7 day)
group by t1.load_dt

```

## 计算中位数，平均数和众数
```sql
-- 中位数
select avg(emp_salary)
from
(
select emp_salary,
row_number() over(order by emp_salary) as rn,
count(*) over() as n
from emp_salary
) t
where rn in (floor(n/2)+1,if(mod(n,2) = 0,floor(n/2),floor(n/2)+1))
```


## 计算摊销收入
![avatar](/sql/bilibili.png)
```sql
select sum(dailya) from(
select *,pay_amount/datediff(end_date,begin_date) as dailya from
(select * from bilibili_m2 
where m_date >= '2021-01-01' and m_date < '2021-07-01') t1
left join bilibili_m1
on 1
where m_date >= begin_date and m_date <= end_date) t2
group by y_m
```

```sql
select distinct cust_uid1, mch_nm from 
(select cust_uid1, cust_uid2, mch_nm as mch_nm1
from
(select t1.cust_uid cust_uid1,t2.cust_uid cust_uid2
from (select distinct cust_uid, mch_nm from mt_trx_rcd ) t1
left join (select distinct cust_uid, mch_nm from mt_trx_rcd ) t2
on t1.mch_nm = t2.mch_nm
where t1.cust_uid !=t2.cust_uid
group by t1.cust_uid, t2.cust_uid
having count(1) >= 15) t3
left join (select distinct cust_uid, mch_nm from mt_trx_rcd ) t4
on t3.cust_uid1 = t4.cust_uid) t5
left join
(select distinct cust_uid, mch_nm from mt_trx_rcd ) t6
on t5.cust_uid2 = t6.cust_uid
where mch_nm1 != mch_nm and cust_uid1 = 'MT10010'
```
## 计算转化率（conversion rate）
```sql
select prd_nm, vw/snd,cart/vw,buy/cart,buy from
(select prd_id, count(distinct cust_uid) snd from tb_clk_rcd where if_snd = 1 group by prd_id)t1
left join 
(select prd_id, count(distinct cust_uid) vw from tb_clk_rcd where if_vw = 1 group by prd_id)t2
on t1.prd_id = t2.prd_id
left join
(select prd_id, count(distinct cust_uid) cart from tb_clk_rcd where if_cart = 1 group by prd_id)t3
on t2.prd_id  = t3.prd_id
left join 
(select prd_id, count(distinct cust_uid) buy from tb_clk_rcd where if_buy = 1 group by prd_id)t4
on t3.prd_id = t4.prd_id
left join  tb_prd_map t5
on t5.prd_id = t4.prd_id
```

## 行列转换问题 
- 多行转多列问题
```SQL
/*
创建数据表
*/
insert into sqlpractice.rowColumn values('2014','B','9');
insert into sqlpractice.rowColumn values('2015','A','8');
insert into sqlpractice.rowColumn values('2015','B','7');
insert into sqlpractice.rowColumn values('2014','A','10');
```
```sql
select
a,
max(case when b="A" then c end) col_A,
max(case when b="B" then c end) col_B
from t1
group by a
```
- 行转列复原
```sql
select
a,
b,
c
from (
select a,"A" as b,col_a as c from t1_2
union all
select a,"B" as b,col_b as c from t1_2
)tmp
```


## 排名中取他值
示例表格如下所示：
|a|b|c|
|---|---|---|
|2014| A |3|
|2014 |B |1|
|2014| C| 2|
|2015| A |4|
|2015| D| 3|

表格创建sql代码如下：
```sql
create table sqlpractice.rankData(
	`a` varchar(255),
    `b` varchar(255),
    `c` varchar(255)
);

insert into sqlpractice.rankData values('2014','A','3');
insert into sqlpractice.rankData values('2014','B','1');
insert into sqlpractice.rankData values('2014','C','2');
insert into sqlpractice.rankData values('2015','A','4');
insert into sqlpractice.rankData values('2015','D','3');
```
1. 按a字段分组，取b最小时的c的值
```sql
select * from(
select *,rank()over(partition by a order by b) as rk
from sqlpractice.rankData) t1
where rk = 1
```
2. 按a字段分组，取b最小时和最大时的c的值
```sql
select a,max(if(rk=1,c,null)) min_c,max(if(desc_rk=1,c,null)) max_c from(
select *,rank()over(partition by a order by b) as rk,
rank()over(partition by a order by b desc) as desc_rk
from sqlpractice.rankData) t1
where rk = 1 or desc_rk = 1
group by a

```
3. 按a分组，取b字段前两大和后两大的c值

```SQL
-- HIVE版本，用concat_ws 和 collect_list进行合并
select a,concat_ws(',',collect_set(case when rk=2 then c when rk = 1 then c else null end)) min_c,concat_ws(',',collect_set(case when desc_rk=2 then c when desc_rk = 1 then c else null end ))max_c,rk,desc_rk from(
select *,rank()over(partition by a order by b) as rk,
rank()over(partition by a order by b desc) as desc_rk
from sqlpractice.rankData) t1
where rk = 2 or desc_rk = 2 or rk = 1 or desc_rk = 1 
group by a
```

```sql
--mysql版本，用group_concat进行合并
select a,GROUP_CONCAT(case when rk=2 then c when rk = 1 then c else null end) min_c,GROUP_CONCAT(case when desc_rk=2 then c when desc_rk = 1 then c else null end ) max_c from(
select *,rank()over(partition by a order by b) as rk,
rank()over(partition by a order by b desc) as desc_rk
from sqlpractice.rankData) t1
where rk = 2 or desc_rk = 2 or rk = 1 or desc_rk = 1 
group by a
```

# 产生连续数值

```sql
select row_number()over() as id
from
(select split(space(99),' ') x) tmp lateral view explode(x) tmp2
```

