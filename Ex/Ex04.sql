--subquery
select first_name, salary
from employees
where salary = (select salary
                from employees
                where first_name = 'Den');

select first_name, salary, employee_id
from employees
where salary = (select min(salary)
				from employees);

select first_name, salary
from employees
where salary > (select avg(salary)
				from employees));

--in

select employee_id, first_name, salary
from employees
where salary = 8300 or
      salary = 12008; --without "in" (need to search)
				
select employee_id, first_name, salary
from employees
where salary in (select salary
				 from employees
				 where department_id = 110); --with "in"
				 
select first_name, salary
from employees
where salary in (select salary
                from employees
                where first_name = 'Den');

select first_name, salary
from employees
where salary in (select max(salary)
				 from employees
				 group by(department_id));