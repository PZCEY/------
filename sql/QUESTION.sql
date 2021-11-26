
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




