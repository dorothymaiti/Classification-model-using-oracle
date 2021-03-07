-- Task 1 – Copying data -------------------------------------------------------------------------------------------------------

-- Using SQL create a copy of the DEPT and EMP tables. Give the new tables a name something like DEPT_COPY, EMP_COPY.
create table emp_copy as select * from emp;
create table dept_copy as select * from dept;

-- Write one query returning the following attributes. Create a new table based on this query.
-- The table for each attribute is given in brackets.
-- HINT: write the SQL query first and test it works and returns the correct data/rows. Then use it to create the table.
-- EMPNO (EMP_COPY) ENAME (EMP_COPY) JOB (EMP_COPY) SAL (EMP_COPY) DNAME (DEPT_COPY) LOC (DEPT_COPY)
select emp_copy.empno, emp_copy.ename, emp_copy.job, emp_copy.sal, dept_copy.dname, dept_copy.loc
from emp_copy, dept_copy
where dept_copy.deptno = emp_copy.deptno;

-- The query will return one record per employee, containing some of the employee attributes, and joins to the DEPT table to
-- return some of the department details for the employee. [WHERE EMP_COPY.DEPTNO = DEPT_COPY.DEPTNO]
-- Using this query to create a table containing the results returned by the query. Name this new table EMP_DETAILS.
create table emp_details as
select emp_copy.empno, emp_copy.ename, emp_copy.job, emp_copy.sal, dept_copy.dname, dept_copy.loc
from emp_copy, dept_copy
where dept_copy.deptno = emp_copy.deptno;

-- Task 2 – Extracting Data using SQL ------------------------------------------------------------------------------------------

-- Using the SQL features/commands of creating data in different formats, practice using each one.
-- There is also a JSON format. Try that and see if it works
-- Create a file, using SQL, that exports the EMP_COPY and DEPT_COPY tables, using the following formats
-- JSON / CSV / HTML

set feedback off
spool "/home/acueva/Documents/Classes/Working with Data/sql/emp.json"
select /*json*/ * from EMP_COPY;
spool off
set feedback on

set feedback off
spool "/home/acueva/Documents/Classes/Working with Data/sql/emp.csv"
select /*csv*/ * from EMP_COPY;
spool off
set feedback on

set feedback off
spool "/home/acueva/Documents/Classes/Working with Data/sql/emp.html"
select /*html*/ * from EMP_COPY;
spool off
set feedback on

set feedback off
spool "/home/acueva/Documents/Classes/Working with Data/sql/dept.json"
select /*json*/ * from DEPT_COPY;
spool off
set feedback on

set feedback off
spool "/home/acueva/Documents/Classes/Working with Data/sql/dept.csv"
select /*csv*/ * from DEPT_COPY;
spool off
set feedback on

set feedback off
spool "/home/acueva/Documents/Classes/Working with Data/sql/dept.html"
select /*html*/ * from DEPT_COPY;
spool off
set feedback on

-- Open the HTML files in an internet browser and inspect the data.
-- Make sure that these files are created correctly and does not have any additional or unnecessary elements in them.
-- HINT: You might need to make minor edits to this files
-- Additional Exercise (Optional): Using R and/or Python load these files into a dataframe and inspect the data.

-- Task 3 – Extracting Data using SQL Developer --------------------------------------------------------------------------------

-- Use the Export table feature in SQL developer to create additional files for the EMP_COPY and DEPT_COPY tables.
-- Use different names to what was used in Task 2 above.
-- Inspect these files and compare the contents of these files to those created in Task 2.

-- Task 4 – Loading Data using SQL Developer -----------------------------------------------------------------------------------

-- Drop the tables EMP_COPY and DEPT_COPY.
drop table emp_copy;
drop table dept_copy;

-- Using the Import feature of SQL Developer, load the data into your Oracle schema using the files created in Task 3.
-- Do you encounter any errors? If so, how would you overcome these.

-- Compare the tables, data and structure of the EMP_COPY and DEPT_COPY tables with the original tables, the data and the table
-- structures. Are there any differences? If so, why?
select * from EMP_COPY;
select * from EMP;

--------------------------------------------------------------------------------------------------------------------------------
-- Lab Exercise 2 – SQL Manipulation Functions
--------------------------------------------------------------------------------------------------------------------------------

-- Task 1 – Some Date processing
-- Find out the day of the week you were born on, and what days of the week you celebrated your 10th, 18th, etc birthday on.
select to_char(date'1991-09-03', 'DAY') from dual;
select to_char(date'2001-09-03', 'DAY') from dual;
select to_char(date'2009-09-03', 'DAY') from dual;

-- Task 2 – Date and Time processing
-- Write out today's date in standard format used in EU and in USA. Include the time in standard 12 hour format and in 
-- 24 hour format.
select to_char(sysdate, 'YYYY-MM-DD') today,
       to_char(sysdate, 'HH24:MI:SS') time24,
       to_char(sysdate, 'HH:MI:SS')   time
  from dual;

-- Task 3 -Basic string processing
-- Take your full name as a string and separate it out into its individual tokens.
select SUBSTR(fullname, 1, INSTR(fullname, ' ')) as firstname,
       SUBSTR(fullname, INSTR(fullname, ' ') + 1) as lastname
 from (select 'Alan Cueva' as fullname from dual) tab
 
-- Convert the string to have Initial Caps, All Caps and all Lower Case.
select INITCAP(fullname) as initial_caps,
       UPPER(fullname) as all_caps,
       LOWER(fullname) as lower_case
 from (select 'alan cueva mora' as fullname from dual) tab

-- Task 4 – Reformatting
-- Reformat the following string: Brendan, Tierney, Kevin St, Dublin 8, Ireland
-- to the following format: brendan   |tierney   |kevin st  |dublin 8. |ireland   |
-- Convert each string component to lower case, remove the comma, replace to have fixed width of 10 characters, separated by 
-- the pipe (|) symbol
select CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(v1, '|'), v2), '|'), v3), '|'), v4), '|'), v5), '|'), v6), '|') as new_str
  from (select RPAD(REPLACE(REGEXP_SUBSTR(str, '[a-z]+, ', 1, 1), ',', ''), 10) v1,
               RPAD(REPLACE(REGEXP_SUBSTR(str, '[a-z]+, ', 1, 2), ',', ''), 10) v2,
               RPAD(REPLACE(REGEXP_SUBSTR(str, '[a-z ]+, ', 1, 3), ',', ''), 10) v3,
               RPAD(REPLACE(REGEXP_SUBSTR(str, '[a-z 0-8]+, ', 1, 4), ',', ''), 10) v4,
               RPAD(REPLACE(REGEXP_SUBSTR(str, '[a-z]+', 1, 5), ',', ''), 10) v5,
               RPAD(REPLACE(REGEXP_SUBSTR(str, '[a-z]+', 1, 6), ',', ''), 10) v6
         from (select lower(str) str from (select 'Brendan, Tierney, Kevin St, Dublin 8, Ireland' str from dual))) tab;

-- Task 5 – Working with names
-- Take the following names. Using the SQL functions reformat them into their correct form (example given)
-- input = ‘mcDonald’    output = ‘McDonald
-- input = “o’reilly”   output = “O’Reilly”
select INITCAP('mcDonald') str1, INITCAP('o’reilly') str2 from dual;

-- Task 6 – How old are you
-- Using SYSDATE and your date of birth calculate your age. Apply additional formatting or calculations to the display your age
-- in Days, Years, etc
-- Check out the various Date formats in the Documentation
select floor(age) as days,
       floor(age / 365) as years,
       floor(age / 365)*12 as months
  from (select sysdate - to_date('19910903', 'YYYYMMDD') age from dual);

-- Task 7 – When you are 65
-- Display the following information about the date of your 65th birthday.
-- How many months between today and your 65th birthday
-- How many days between today and your 65th
-- Display the Day of the week – The full day name
-- Display the month, with full name
select birthday as burthday65,
       floor((birthday-sysdate)/365)*12 as month_left,
       floor(birthday-sysdate) as days_left,
       to_char(birthday, 'DAY') as day,
       to_char(birthday, 'MONTH') as month
  from (select ADD_MONTHS(to_date('19910903', 'YYYYMMDD'), (65 * 12)) birthday from dual);

--------------------------------------------------------------------------------------------------------------------------------
-- Lab Exercise 3 – Additional SQL Queries
--------------------------------------------------------------------------------------------------------------------------------

-- Using the tables and data that was loaded last week in Exercise 3, write SQL queries to answer the following questions.

-- 3-1 – List the Minimum, Maximum and Average salaries where job title is ‘MANAGER’
select min(sal), max(sal), floor(avg(sal))
  from emp
 where job = 'MANAGER';

-- 3-2 – List details of employees who has a commission that is greater than 50% of their salary
select ename, job, sal, comm, deptno
  from emp
 where comm is not null and comm > (sal/2);

-- 3-3 – List the employees and their length of service (based on HIREDATE)
select ename, hiredate, floor((sysdate - hiredate) / 365) as service
 from emp;

-- 3-4 – List the average salary by each job title
select job, floor(avg(sal))
  from emp
 group by job;

-- 3-5 – List the average salary by each location
select loc, floor(avg(sal))
  from emp
 inner join dept on dept.deptno = emp.deptno
 group by dept.loc;

-- 3-6 – Create a new table that has the same structure as EMPLOYEE and call it MANAGERS. Write a SQL statement that will
--       inserted into the MANAGERS tables all employees who have the job title of ‘MANAGER’ and ‘PRESIDENT’
create table managers as
select *
  from emp
 where job in ('MANAGER', 'PRESIDENT');

select * from managers;
