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
where (department_id, salary) in (select department_id, max(salary)
                                  from employees
                                  group by department_id);

select first_name, salary
from employees
where (department_id, salary) in ((100, 12008), (30, 11000), (90, 24000), (20, 13000), 
                                  (70, 10000), (110, 12008), (50, 8200), (80, 14000), 
                                  (40, 6500), (60, 9000), (10, 4400)); --the long way

select e.department_id, e.employee_id, e.first_name, e.salary
from employees e, (select department_id, max(salary) salary
				   from employees
				   group by department_id) d
where d.salary = e.salary and 
	  d.department_id = e.department_id;