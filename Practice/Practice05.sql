/*문제1.
담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의
이름, 매니저아이디, 커미션비율, 월급을 출력하세요. (45건)
*/
select	first_name 이름, manager_id 매니저아이디, commission_pct 커미션비율, salary 월급
from	employees
where	manager_id is not null
and		commission_pct is null
and		salary > 3000;


/*문제2.
각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name), 급여
(salary), 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id) 를
조회하세요.
-조건절비교 방법으로 작성하세요
-급여의 내림차순으로 정렬하세요
-입사일은 2001-01-13 토요일 형식으로 출력합니다.
-전화번호는 515-123-4567 형식으로 출력합니다.
(11건)
*/
select	employee_id 직원번호, first_name 이름, salary 급여, to_char(hire_date, 'YYYY-MM-DD') 입사일, 
		replace(phone_number, '.', '-') 전화번호, department_id 부서번호
from	employees
where	(salary, department_id) in (select max(salary), department_id from employees group by department_id)
order by salary desc;


/*문제3
매니저별 담당직원들의 평균급여 최소급여 최대급여를 알아보려고 한다.
-통계대상(직원)은 2005년 이후(2005년 1월 1일 ~ 현재)의 입사자 입니다.
-매니저별 평균급여가 5000이상만 출력합니다.
-매니저별 평균급여의 내림차순으로 출력합니다.
-매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
-출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여,
매니저별최대급여 입니다.(9건)
*/
select	g.manager_id 매니저아이디, m.first_name 매니저이름, hire_date
        매니저평균급여, 매니저별최소급여, 매니저별최대급여
from	employees m,
		(
		select	manager_id, round(avg(salary), 1) 매니저평균급여,
				min(salary) 매니저별최소급여, max(salary) 매니저별최대급여
		from	(select * from employees where hire_date >= '05/01/01')
		group by manager_id
		) g
where	g.manager_id = m.employee_id
and		매니저평균급여 > 5000
order by 매니저평균급여 desc;


/*문제4.
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명
(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다. (106명)
*/
--정답 1
select	e.employee_id 사번, e.first_name 이름, d.department_name 부서명,
		m.first_name 매니저이름
from	employees m, employees e 
left outer join departments d
on      e.department_id = d.department_id
where	e.manager_id = m.employee_id;

--오라클only
select	e.employee_id 사번, e.first_name 이름, d.department_name 부서명,
		m.first_name 매니저이름
from	employees m, employees e, departments d
where	e.manager_id = m.employee_id
and		e.department_id = d.department_id(+);


/*문제5.
2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의
사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요
*/
select	rn, 사번, 이름, 급여, 입사일, 부서명
from	(select rownum rn, 사번, 이름, 급여, 입사일, 부서명
		 from (select employee_id 사번, first_name || ' ' || last_name 이름,
		 			  salary 급여, hire_date 입사일, department_name 부서명
		 			  from employees e
                      left outer join departments d
                      on e.department_id = d.department_id
		 			  where hire_date >= '05/01/01'
		 			  order by hire_date asc)
		 		) e
where	rn >= 11 and rn <=20;


/*문제6.
가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary)과 근무하는
부서 이름 (department_name)은?
*/
select	first_name || ' ' || last_name 이름, salary 연봉,
		department_name 부서명, hire_date
from	employees e
left outer join departments d
on		e.department_id = d.department_id
where	hire_date in (select max(hire_date) from employees);


/*문제7.
평균연봉(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 이름(firt_name), 성
(last_name)과 업무(job_title), 연봉(salary)을 조회하시오.
*/
select	employee_id 직원번호, first_name 이름, last_name 성, job_title 업무, e.salary 연봉, dep.salary "AVG_SALARY"
from	employees e, jobs j,
		(
		select  d.department_id, salary
		from    departments d,
		        (select department_id, avg(salary) salary from employees group by department_id) s
		where	s.department_id = d.department_id
		and		salary = (select max(salary) from (select avg(salary) salary from employees group by department_id))
		) dep
where	e.job_id = j.job_id
and		dep.department_id = e.department_id;


/*문제8. 평균 급여(salary)가 가장 높은 부서는?*/
select	department_name
from	departments d,
		(select department_id, avg(salary) salary from employees group by department_id) s
where	s.department_id = d.department_id
and		salary = (select max(salary) from (select avg(salary) salary from employees group by department_id));

select	department_name
from	departments d,
		(
        select department_id
        from    (select avg(salary) salary, department_id 
                  from employees group by department_id)
        where salary = (select max(salary) from (select avg(salary) salary, department_id 
                                                 from employees group by department_id))
        ) s
where	s.department_id = d.department_id;


/*문제9. 평균 급여(salary)가 가장 높은 지역은?*/
select  region_name
from    regions r,
        (
        select	region_id, salary
        from	(
        		select	region_id, avg(salary) salary
				from	(
						select	r.region_id, region_name, salary
						from	employees e, departments d, locations l, countries c, regions r
						where	e.department_id = d.department_id
						and		d.location_id = l.location_id
						and		l.country_id = c.country_id
						and		c.region_id = r.region_id
						)
				group by region_id
				)
		) s
where	r.region_id = s.region_id
and		salary in	(
					select	max(salary)
					from	(
							select	region_id, avg(salary) salary
							from	(
									select	r.region_id, salary
									from	employees e, departments d, locations l, countries c, regions r
									where	e.department_id = d.department_id
									and		d.location_id = l.location_id
									and		l.country_id = c.country_id
									and		c.region_id = r.region_id
									)
							group by region_id
							)
                	);


/*문제10. 평균 급여(salary)가 가장 높은 업무는?*/
select  job_title
from    jobs j,
        (select job_id, avg(salary) salary from employees group by job_id) s
where s.job_id = j.job_id
and   salary = (select max(salary) from (select avg(salary) salary from employees group by job_id));


