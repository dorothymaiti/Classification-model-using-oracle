drop table student cascade constraints;

create table STUDENT (
student_number VARCHAR2(20) PRIMARY KEY,
first_name VARCHAR2(20),
surname VARCHAR2(20),
dob DATE,
prog_code VARCHAR2(6));

insert into STUDENT (student_number, first_name, surname, dob, prog_code)
values ('D020150120', 'Brendan', 'Tierney', to_date('19/01/1995', 'DD/MM/YYYY'), 'DT228B');

insert into STUDENT (student_number, first_name, surname, dob, prog_code)
values ('D020150121', 'Damian', 'Gordon', to_date('20/06/1965', 'DD/MM/YYYY'), 'DT228B');

insert into STUDENT (student_number, first_name, surname, dob, prog_code)
values ('D020150122', 'Deirdre', 'Lawless', to_date('04/10/1973', 'DD/MM/YYYY'), 'DT228B');

insert into STUDENT (student_number, first_name, surname, dob, prog_code)
values ('D020150123', 'Robert', 'Ross', to_date('28/12/2000', 'DD/MM/YYYY'), 'DT228B');

select * from student;
select first_name from student where prog_code = 'DT228B';
select first_name from student where first_name like 'D%';

select * from student where student_number = 'D020150123';

update STUDENT
set prog_code = 'DT228A'
where student_number = 'D020150123';

select * from student where student_number = 'D020150123';


delete from STUDENT where student_number = 'D020150123';
delete from STUDENT where first_name like 'D%';
select * from STUDENT;

insert into STUDENT (student_number, first_name, surname, dob, prog_code)
values ('D020125565', 'Alan', 'Cueva', to_date('03/09/1991', 'DD/MM/YYYY'), 'DT228B');

update student set prog_code = 'TU059' where student_number = 'D020125565';

--2-3-4 – Create a table that contains Course Codes with the following attributes. You can decide the appropriate name of the table and the data types of each attribute.

create table COURSE(
    COURSE_ID NUMBER PRIMARY KEY,
    COURSE_CODE VARCHAR(20),
    COURSE_DESCRIPTION VARCHAR(100)
    );
    
-- 2-3-5 – Insert at least 4 records into the table created in 2-3-4
insert into COURSE  (COURSE_ID, COURSE_CODE, COURSE_DESCRIPTION)
values (1, 'TU059', 'master degree full time');

insert into COURSE  (COURSE_ID, COURSE_CODE, COURSE_DESCRIPTION)
values (2, 'TU060', 'master degree part time');

insert into COURSE  (COURSE_ID, COURSE_CODE, COURSE_DESCRIPTION)
values (3, 'TU061', 'not real');

insert into COURSE  (COURSE_ID, COURSE_CODE, COURSE_DESCRIPTION)
values (4, 'TU062', 'not real 2');

-- 2-3-6 – Modify the table structure to contain a new attributed called FULL_PART_TIME. This attribute is to contain a value that indicates if the course is for full-time or part-time students.
alter table COURSE add (FULL_PART_TIME CHAR(1) DEFAULT 'F' NOT NULL);

-- 2-3-7 – Update the records in course codes table to have the correct value for the FULL_PART_TIME attribure.
update COURSE set FULL_PART_TIME = 'P' where course_id = 2;
update COURSE set COURSE_CODE = 'DT228B' where course_id = 4;

-- 2-3-8 – Query the course codes table to verify that the data is correct.
select * from course;

-- 2-3-9 – Write a query that joins the STUDENT table with the course codes table
select CONCAT(CONCAT(student.first_name, ' '), student.surname) name, student.dob, course.course_description
from student
inner join course on course.course_code = student.prog_code;

-- 2-3-10 – Write a query that displays the following
select max(course.course_description), count(student_number)
from course
inner join student on course.course_code = student.prog_code
group by course.course_id;

--------------------------------------------------------------------------------------------------------------------------------

@/home/acueva/Downloads/master_detail.sql

-- 3.1 – List the employee details and the name of their department location
select emp.ename, emp.job, emp.mgr, emp.hiredate, emp.sal, dept.dname, dept.loc
  from emp
 inner join dept on dept.deptno = emp.deptno;

-- 3.2 – List the total number of employees at each department location name
select max(dept.dname), max(dept.loc), count(emp.empno)
from dept
inner join emp on emp.deptno = dept.deptno
group by dept.deptno;

-- 3.3 – List the employees who have the job title of ‘MANAGER’
select ename, job
from emp
where job = 'MANAGER';

-- 3.4 – List the employees and their length of service (based on HIREDATE)
select ename, EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM hiredate) service
from emp;

-- 3.5 – List the details of the manager of each department
select dept.*, emp.ename
from dept
left join emp on emp.deptno = dept.deptno and emp.job = 'MANAGER';
