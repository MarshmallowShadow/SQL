select first_name, phone_number, hire_date, salary from employees;
select first_name, last_name, salary, phone_number, email, hire_date from employees;

select first_name as 이름, phone_number as 전화번호, hire_date as 입사일, salary as 급여 from employees;
select employee_id 사원번호, first_name 이름, last_name 성, salary 급여, phone_number 전화번호,
email 이메일, hire_date 입사일 from employees;

select first_name || ' ' || last_name from employees;

select salary*12 from employees;