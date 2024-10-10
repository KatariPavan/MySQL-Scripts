create database Mysqltraning;
use Mysqltraning;
show databases;
create table studentdetails(
student_ID int,
student_Name varchar(100),
course_Details varchar(50)
);

alter table studentdetails add email varchar(100);
insert into studentdetails(student_ID,Student_Name,course_Details,email)
 values(1,'Anirudh','C001','anirudh@music'),
 (2,'devisriprasad','C002','DSP@music'),
 (3,'MMkeravani','C003','MMK@oscar'),
 (4,'Rajamouli','C004','RRR@oscar'),
 (5,'Unknow','C005','Unknow@unknow');
 
show tables;
describe studentdetails;

 select * from studentdetails;
 select student_ID from studentdetails;
 select student_ID,student_Name from studentdetails;
 
delete from studentdetails;
#delete is not worked while Mysql is in auto update for that use command
set SQL_SAFE_UPDATES = 0;
delete from studentdetails;
select * from studentdetails;

insert into studentdetails(student_ID,Student_Name,course_Details,email)
 values(1,'Anirudh','C001','anirudh@music'),
 (2,'devisriprasad','C002','DSP@music'),
 (3,'MMkeravani','C003','MMK@oscar'),
 (4,'Rajamouli','C004','RRR@oscar'),
 (5,'Unknow','C005','Unknow@unknow');

select * from studentdetails;
truncate table studentdetails;
# delete vs truncate
# delete used to delete specific row
# truncate deletes all the data in the table
# Where used for specific functions (filtering)
# while using truncate rollback of changes is not done
# truncate excutive faster than delet

show tables;
select * from studentdetails;
select * from studentdetails where course_Details ='C001';
select * from studentdetails where student_ID = 3 and course_Details = 'C003';
select * from studentdetails where student_ID = 2 or course_Details = 'C004';
select * from studentdetails where not student_ID  = 5;
select * from studentdetails where course_Details in ('C001','C005');
select * from studentdetails where student_ID between 1 and 5;

insert into studentdetails(student_ID,Student_Name,course_Details,email)
 values(6,'balla','C006','balla@rana'),
 (7,'bahubali','C007','bahubali@prabhas'),
 (8,'sherkahn','C008','sher@khan'),
 (9,'ballaya','C009','jai@ballaya'),
 (10,'know','C0010','know@know');

select * from studentdetails where email like 'R%';
select * from studentdetails where email like '%n';
select * from studentdetails where email like '%k%';

insert into studentdetails(student_ID,Student_Name,course_Details)
values(11,'tom','C0011');
select * from studentdetails;

select * from studentdetails where email is null;

-- Advanced SQL concepts

use Mysqltraning;
show databases;

create table Customerdetails(
CID varchar(10) primary key,
fname varchar(20),
mname varchar(20),
lname varchar(20),
city varchar(20),
age int(5),
phoneno varchar(10),
occupation varchar (10),
dob date);

insert into Customerdetails values('C001','a','b','akhil','HYD',23,'9876534270','software','1999-02-01'),
('C002','a','s','bhuvan','SECD',25,'9876534770','It','1997-01-09'),
('C003','t','b','suresh','HYD',28,'9876534274','doctor','1996-01-02'),
('C004','p','d','rohith','SECD',33,'9876534273','k','1991-01-02'),
('C005','a','m','ganesh','NZBD',43,'9876534272','teacher','1999-01-02'),
('C006','a','a','srinivas','HYD',28,'9876534271','it','1999-01-02'),
('C007','n','m','nafeez','SECD',18,'9876554270','software','1999-01-02'),
('C008','m','m','sai','HYD',23,'9876634270','it','2001-01-02'),
('C009','a','b','unknow','SECD',43,'9856534270','Agrie','1989-01-02'),
('C0010','a','b','know','NZBD',19,'9876535270','software','2003-01-02');

select * from Customerdetails;

select min(age)from Customerdetails;
select lname from Customerdetails where age = 18;
select max(age) from Customerdetails;
select lname from Customerdetails where age = 43;
select count(*) from Customerdetails;
select avg(age) from Customerdetails;
select sum(age) as Sum_of_age from Customerdetails;

select count(fname),city from Customerdetails group by city having count(city)>2; 
select count(fname),city from Customerdetails group by city having count(city)<4; 
select count(fname),city from Customerdetails group by city having count(city)=4; 
select count(fname),city from Customerdetails group by city having count(city)!=4; 

create table accounts(
acnumber varchar(6),
CID varchar(9),
BID varchar(9),
opening_balance int,
acod date,
actype varchar(10),
acstatus varchar(10),
constraint act_acnumber_pk primary key(acnumber),
constraint act_CID_fk foreign key(CID) references Customerdetails(CID)
);
show tables;
insert into accounts values('A001','C001','001','1000','2022-09-08','savings','active'),
('A002','C002','001','1000','2023-07-08','savings','active'),
('A003','C003','001','1000','2024-03-04','savings','active'),
('A004','C004','001','1000','2024-04-01','current','terminated'),
('A005','C005','001','1000','2024-01-02','savings','active'),
('A006','C006','001','1000','2024-09-06','savings','terminated'),
('A007','C007','001','1000','2024-09-09','curent','active'),
('A008','C008','001','1000','2024-04-01','savings','terminated'),
('A009','C009','001','1000','2024-07-06','savings','active'),
('A0010','C0010','001','1000','2024-04-05','savings','active');

select * from accounts;
select count(*) from accounts;
select count(*),acstatus from accounts group by acstatus;
select count(*),actype from accounts group by actype;
select count(*),actype from accounts group by actype having count(actype)=8;

#JOINS
select * from accounts;
select * from Customerdetails ;
select count(*) from Customerdetails;
select count(*) from accounts;
# inner join
select lname,acnumber from Customerdetails inner join accounts on Customerdetails.CID = accounts.CID; 
select actype,acnumber,lname,age from Customerdetails inner join accounts on  Customerdetails.CID = accounts.CID;
select * from Customerdetails inner join accounts on Customerdetails.CID = accounts.CID; 

# Left join 
create table branch (
BID varchar(5),
Bname varchar (10),
Bcity varchar (10),
constraint branch_BID_pk primary key(BID)
);

insert into branch values ('001','SbTPT','Tpt'),
('002','SoTPT','delhi'),
('003','SvTPT','hyd'),
('004','SpTPT','che'),
('005','SlTPT','sec');

select * from branch;
select* from accounts;

select * from Customerdetails left join accounts on Customerdetails.CID = accounts.CID;
select * from accounts left join Customerdetails on Customerdetails.CID = accounts.CID;
select * from branch left join accounts on branch.BID = accounts.BID;

show tables;

# right join 
select * from accounts right join Customerdetails on accounts.CID = Customerdetails.CID;
select * from Customerdetails right join accounts on accounts.CID = Customerdetails.CID;

# self join 

create table studentDB(
student_ID int,
student_Name varchar(15),
course_Details varchar(5),
duration int(5)
);
insert  into studentDB values(1,'suresh','D1',3),
(2,'ganesh','D1',3),
(3,'rohith','D2',2),
(4,'srinivas','D3',6),
(5,'moulana','D2',2),
(6,'pavan','D1',3),
(7,'suresh','D2',2),
(8,'rohith','D1',3);

select * from studentDB;
#
select s1.student_ID,s2.student_Name,s1.course_Details
from studentDB as s1,studentDB s2 
where s1.student_ID=s2.student_ID and s1.course_Details != s2.course_Details;

#full join
select * from Customerdetails full join accounts on Customerdetails.CID = accounts.CID;
select * from Customerdetails left join accounts on Customerdetails.CID = accounts.CID
union select * from Customerdetails right join accounts on Customerdetails.CID = accounts.CID
 
 -- subquery
 
 use database Mysqltraning;
 
create table Customers(
CID varchar(10) primary key,
fname varchar(20),
mname varchar(20),
lname varchar(20),
city varchar(20),
age int(5),
phoneno varchar(10),
occupation varchar (10),
dob date
);

 
insert into Customers select * from Customerdetails where age >=25;
select * from Customers;

update Customers set age = age+2 where age in (select age from Customerdetails where age>=35);
select age from Customerdetails;

delete from Customers where age in (select age from Customerdetails where age >=45);
select age from Customerdetails;

select * from Customers where (select distinct CID from Customers where age>25);

-- case statements

select CID,lname,age,case when age>30 then 'the age is greater than 30'
when age=30 then 'the age is equal to 30'
else 'the age is not in group of 30' end as Age from Customers;

select lname,city,age from Customers order by (case when city is null then 'no city'
else city end );

select lname,occupation,case when occupation = 'Agrie' then 'jai jawan'
when occupation = 'student' then 'future heros'
else others end as people;

 -- view
 
 create view Agedcustomers as select lname,age,city from Customers where age > 45;
 select * from Agedcustomers;
 
 create view Delicity as select lname, age,city from Customers where city = 'delhi';
 select * from Delicity;
 show tables;

 