/* ==================[ "select" and "from" ]================ */
select first_name, phone_number, hire_date, salary from employees;
select first_name, last_name, salary, phone_number, email, hire_date from employees;

select first_name as 이름, phone_number as 전화번호, hire_date as 입사일, salary as 급여 from employees;

select employee_id "사원 번호", first_name 이름, last_name 성, salary 급여,
    phone_number 전화번호, email 이메일, hire_date 입사일
from employees; /* temporary name change */

select first_name || ' ' || last_name from employees; /* string concatenation */
select salary*12 from employees; /* operators */

select first_name || '-' || last_name 이름, salary 급여, 
    salary*12 연봉, salary*12+5000 연봉2, phone_number 전화번호
from employees;

/* ==================[ "where" ]================ */

select first_name || ' ' || last_name 이름, salary 급여
from employees
where salary >= 15000;

select first_name || ' ' || last_name 이름, hire_date 입사일
from employees
where hire_date > '07/01/01';

select salary from employees where first_name = 'Lex';

/* "and" operator */
select first_name || ' ' || last_name 이름, salary 급여
from employees
where salary >= 14000 and salary <= 17000;

select first_name || ' ' || last_name 이름, hire_date 입사일
from employees
where hire_date > '04/01/01' and hire_date < '05/12/31';

/* "between" operator */
select first_name || ' ' || last_name 이름, salary 급여
from employees
where salary between 14000 and 17000;

select first_name || ' ' || last_name 이름, hire_date 입사일
from employees
where hire_date between '04/01/01' and '05/12/31';

/* "in" operator */
select first_name || ' ' || last_name 이름, salary 급여
from employees
where salary in (2100, 3100, 4100, 5100);

/* "like" operator */
select first_name 이름, salary 급여
from employees
where first_name like '%am%';

select first_name 이름, salary 급여
from employees
where first_name like '_a%';

select first_name 이름
from employees
where first_name like '%___a%';

select first_name 이름, salary 급여
from employees
where first_name like '__a_';

/* null */
select first_name, salary, commission_pct, salary*commission_pct
from employees
where salary between 13000 and 15000; /* sample data with null values */

select first_name 이름, salary 급여, commission_pct 커미션비율
from employees
where commission_pct is not null;

select first_name 이름 from employees where commission_pct is null and manager_id is null;
