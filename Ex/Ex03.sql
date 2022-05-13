--Group Methods
select count(*),
	   avg(salary),
	   max(salary),
	   min(salary),
	   sum(salary)
from employees;

select(commission_pct) from employees; --null not included

select avg(salary), count(*) from employees
where salary >= 10000;

select count(*), sum(salary) from employees;

select count(*), avg(nvl(commission_pct,0))
from employees; --how to include null


--GROUP BY

select department_id, avg(salary)
from employees
group by department_id;

select department_id, first_name, count(*), sum(salary)
from employees
group by department_id; --error, first name cannot be grouped

select department_id, count(*), sum(salary)
from employees
where sum(salary) >= 20000
group by department_id; --error because


--HAVING

select department_id, count(*), sum(salary)
from employees
group by department_id
having sum(salary) >= 20000; --WHERE for groups

--CASE ~ END

SELECT employee_id, salary,
     CASE WHEN job_id = 'AC_ACCOUNT' THEN salary + salary * 0.1
             WHEN job_id = 'SA_REP'     THEN salary + salary * 0.2
           WHEN job_id = 'ST_CLERK'   THEN salary + salary * 0.3
            ELSE salary
     END realSalary
FROM employees;


SELECT employee_id, salary,
     DECODE( job_id, 'AC_ACCOUNT', salary + salary * 0.1,
                        'SA_REP',     salary + salary * 0.2,
                      'ST_CLERK',   salary + salary * 0.3,
               salary ) realSalary
FROM employees;

select first_name, department_id,
	CASE WHEN department_id >= 10 and department_id <= 50 THEN 'A-TEAM'
		 WHEN department_id >= 60 and department_id <= 100 THEN 'B-TEAM'
		 WHEN department_id >= 110 and department_id <= 150 THEN 'C-TEAM'
		 ELSE '팀 없음'
	END team
from employees;

--Join

select first_name, country_name
from employees, countries; --prints all possible combinations between countries and employees

select first_name, em.department_id, 
       department_name, de.department_id
from   employees em, departments de
where  em.department_id = de.department_id; --connection between employees and departments

select first_name, department_name, job_title
from employees e, departments d, jobs j
where e.department_id = d.department_id and
	  e.job_id = j.job_id;


	  