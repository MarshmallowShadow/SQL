--subquery

select first_name, salary, employee_id
from employees
where salary = (select min(salary)
				from employees);

select first_name, salary
from employees
where salary > (select avg(salary)
				from employees));

--in
select first_name, salary
from employees
where salary in (select max(salary)
				 from employees
				 group by(department_id));

