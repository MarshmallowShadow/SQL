/*==============order by==============*/

select department_id 부서번호,
       salary 급여,
       first_name 이름
from employees
order by department_id asc;

select first_name 이름,
       salary 급여
from employees
where salary >= 10000
order by salary desc;

select department_id 부서번호,
       salary 급여,
       first_name 이름
from employees
order by department_id, salary desc; --order priority first column entry

/*==============문자함수==============*/
select initcap(first_name) || ' ' || initcap(last_name) 이름,
       department_id 부서번호
from employees
order by department_id;

select upper(first_name) 이름,
       lower(email) || '@gmail.com' 이메일,
       salary 급여
from employees
where salary > 10000;

--different from java string where starts at 0 but same as python for negative
--substr(startPos, length)
select first_name, substr(first_name,2,3), substr(first_name,-4,3)
from employees
where department_id = 100;

--lpad/rpad(column, length, padding_fill)
--cuts when length is smaller than the data
select first_name,
       lpad(department_id,5,'*'),
       rpad(email,10,'*'),
       lpad(rpad(first_name, 10, '*'), 15, '*')
from employees;

select replace(first_name, 'e', '*') REDACTED
from employees
where first_name like'%e%';

select replace(replace(replace(replace(replace(first_name, 'a', '*'), 'e', '*'), 'i', '*'), 'o', '*'), 'u', '*')
이름
from employees;

/*==============숫자함수==============*/
select abs(-5), --absolute value
       ceil(-6.9), --ceiling
       floor(-6.9), --floor
       round(6.9), --round off to nearest whole number
       mod(420, 7), --modulo
       power(30,2), --power
       round(3.1416, 2), --round(num, decimal point)
       trunc(3.1416, 3), --truncate(remove beyond designated decimal point)
       sign(-6.9) --0 if 0, 1 if pos, -1 if neg
from dual;
--The DUAL table is a special one-row, one-column table present by default
--used for selecting a pseudo column

/*==============날짜함수==============*/
select sysdate from dual;
select first_name, hire_date, sysdate from employees;

select add_months(sysdate, -1),
       last_day(sysdate),
       months_between(sysdate, '97/05/12'),
       new_time(sysdate, 'AST', 'PST'),
       next_day(sysdate, 5), --number represents day of the week (1 = 'sunday')
       round(sysdate, 'DAY'), --rounds based on week (up if wednesday)
       round(sysdate, 'MONTH'),
       round(sysdate, 'YEAR'),
       trunc(sysdate, 'DAY'), --always goes back to sunday of that week
       trunc(sysdate, 'MONTH')
from dual;

select first_name,
       hire_date,
       round(months_between(sysdate, hire_date) / 12) YEARS_WORKED,
       salary
from employees
order by hire_date asc;

/*==============변환함수==============*/

select first_name "First Name",
       to_char(salary, '$09,999.99') Salary
from employees
order by salary desc;



select to_date('2022')
from dual;
