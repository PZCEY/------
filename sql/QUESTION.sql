
create table sqlpractice.employee (
`Id` varchar(255),
`'Name` varchar(255),
`Salary` varchar(255),
`DepartmentID` varchar(255)
) ;

INSERT INTO sqlpractice.employee VALUES('1','Joe','70000','1');
INSERT INTO sqlpractice.employee VALUES('2','Henry','80000','2');
INSERT INTO sqlpractice.employee VALUES('3','Jane','60000','2');
INSERT INTO sqlpractice.employee VALUES('4','Ben','90000','1');

create table sqlpractice.department (
`ID` varchar(255),
`Department` varchar(255)
);

INSERT INTO sqlpractice.department VALUES('1','IT');
INSERT INTO sqlpractice.department VALUES('2','Sales');


create table sqlpractice.seat(
`id` int,
`employee` varchar(255)
);

insert into sqlpractice.seat values(1,'Jack');
insert into sqlpractice.seat values(2,'Scott');
insert into sqlpractice.seat values(3,'Emery');
insert into sqlpractice.seat values(4,'Green');
insert into sqlpractice.seat values(5,'Linda');
insert into sqlpractice.seat values(6,'Jane');

CREATE TABLE `Trips` (
`ID` varchar(255),
`Client_ID` varchar(255) ,
`Driver_ID` varchar(255),
`City_ID` varchar(255) ,
`Status` varchar(255) ,
`Request_at` varchar(255)
) ;
#插入数据
INSERT INTO `Trips` VALUES ('1', '1', '10', '1', 'completed', '2019-10-01');
INSERT INTO `Trips` VALUES ('2', '2', '11', '1', 'cancelled_by_driver', '2019-10-01');
INSERT INTO `Trips` VALUES ('3', '3', '12', '6', 'completed', '2019-10-01');
INSERT INTO `Trips` VALUES ('4', '4', '13', '6', 'cancelled_by_driver', '2019-10-01');
INSERT INTO `Trips` VALUES ('5', '1', '10', '1', 'completed', '2019-10-02');
INSERT INTO `Trips` VALUES ('6', '2', '11', '6', 'completed', '2019-10-02');
INSERT INTO `Trips` VALUES ('7', '3', '12', '6', 'completed', '2019-10-02');
INSERT INTO `Trips` VALUES ('8', '2', '12', '12', 'completed', '2019-10-03');
INSERT INTO `Trips` VALUES ('9', '3', '10', '12', 'completed', '2019-10-03');
INSERT INTO `Trips` VALUES ('10', '4', '13', '12', 'cancelled_by_driver',
'2019-10-03');

CREATE TABLE `Users` (
`Users_ID` varchar(255) ,
`Banned` varchar(255) ,
`Role` varchar(255)
) ;
#插入数据
INSERT INTO `Users` VALUES ('1', 'No', 'client');
INSERT INTO `Users` VALUES ('2', 'Yes', 'client');
INSERT INTO `Users` VALUES ('3', 'No', 'client');
INSERT INTO `Users` VALUES ('4', 'No', 'client');
INSERT INTO `Users` VALUES ('10', 'No', 'driver');
INSERT INTO `Users` VALUES ('11', 'No', 'driver');
INSERT INTO `Users` VALUES ('12', 'No', 'driver');
INSERT INTO `Users` VALUES ('13', 'No', 'driver');


create table sales_record( shopid varchar(11),dt date,sale int );
INSERT INTO sales_record
VALUES ('A', '2017-10-11', 300),
('A', '2017-10-12', 200),
('A', '2017-10-13', 100),
('A', '2017-10-15', 100),
('A', '2017-10-16', 300),
('A', '2017-10-17', 150),
('A', '2017-10-18', 340),
('A', '2017-10-19', 360),
('B', '2017-10-11', 400),
('B', '2017-10-12', 200),
('B', '2017-10-15', 600),
('C', '2017-10-11', 350),
('C', '2017-10-13', 250),
('C', '2017-10-14', 300),
('C', '2017-10-15', 400),
('C', '2017-10-16', 200),
('D', '2017-10-13', 500),
('E', '2017-10-14', 600),
('E', '2017-10-15', 500),
('D', '2017-10-14', 600);

create table emp_salary (emp_name VARCHAR(20),emp_salary varchar(20),from_date
date,to_date date);
INSERT INTO `emp_salary`(`emp_name`, `emp_salary`, `from_date`, `to_date`)
VALUES (1001, 15000, '2020-03-01', '2020-03-31');
INSERT INTO `emp_salary`(`emp_name`, `emp_salary`, `from_date`, `to_date`)
VALUES (1002, 12000, '2020-03-01', '2020-03-31');
INSERT INTO `emp_salary`(`emp_name`, `emp_salary`, `from_date`, `to_date`)
VALUES (1003, 14000, '2020-03-01', '2020-03-31');
INSERT INTO `emp_salary`(`emp_name`, `emp_salary`, `from_date`, `to_date`)
VALUES (1004, 15000, '2020-03-01', '2020-03-31');


CREATE TABLE `t` (
`uid` varchar(255),
`tdate` varchar(255),
`is_flag` varchar(255)
);

INSERT INTO `t` VALUES ('1', '2020-02-01', '1');
INSERT INTO `t` VALUES ('1', '2020-02-02', '0');
INSERT INTO `t` VALUES ('1', '2020-02-03', '1');
INSERT INTO `t` VALUES ('1', '2020-02-04', '1');
INSERT INTO `t` VALUES ('1', '2020-02-05', '0');
INSERT INTO `t` VALUES ('1', '2020-02-06', '1');
INSERT INTO `t` VALUES ('1', '2020-02-07', '1');
INSERT INTO `t` VALUES ('1', '2020-02-08', '1');
INSERT INTO `t` VALUES ('2', '2020-02-01', '1');
INSERT INTO `t` VALUES ('2', '2020-02-02', '0');
INSERT INTO `t` VALUES ('2', '2020-02-03', '0');
INSERT INTO `t` VALUES ('2', '2020-02-04', '1');
INSERT INTO `t` VALUES ('2', '2020-02-05', '1');
INSERT INTO `t` VALUES ('2', '2020-02-06', '1');
INSERT INTO `t` VALUES ('2', '2020-02-07', '1');
INSERT INTO `t` VALUES ('2', '2020-02-08', '1');



create table d_date(
date_id varchar(255),
is_work varchar(255)
);


insert into `d_date` values('2017-04-13',' 1');
insert into `d_date` values('2017-04-14',' 1');
insert into `d_date` values('2017-04-15',' 0'); 
insert into `d_date` values('2017-04-16',' 0');
insert into `d_date` values('2017-04-17',' 1'); 

create table t14(
a varchar(255),
b varchar(255),
c varchar(255)
);
insert into `t14` values('1',' 申请','2017-04-14 18:03:00');
insert into `t14` values('1','通过','2017-04-17 09:43:00');
insert into `t14` values('2','申请','2017-04-13 17:02:00'); 
insert into `t14` values('2','通过','2017-04-15 09:42:00');

select a, round(sum(duration),2) from(
select *,
case 
when is_work = 0 and end_date != date_id then 0 
when is_work = 1 and start_date != date_id and end_date != date_id then 9
when is_work = 1 and start_date = date_id then (unix_timestamp(time('18:30:00'))-unix_timestamp(start_time))/(60*60)
when end_date = date_id then (unix_timestamp(end_time)-unix_timestamp(time('09:30:00')))/(60*60)
end as duration
from
(select a, min(c) start, max(c) end, date(min(c)) start_date ,date(max(c)) end_date,time(min(c)) as start_time, time(max(c)) as end_time from
t14
group by a) tmp1
left join 
d_date
on 1=1
where date_id between start_date and end_date
order by a)tmp2
group by a;

SELECT (UNIX_TIMESTAMP(time('20:43:00'))-UNIX_TIMESTAMP(time('18:03:00')))/(60*60) AS DiffDate
