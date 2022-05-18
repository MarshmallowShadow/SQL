-- 문제1. 평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시요.
select count(*)
from employees
where salary < (select avg(salary) from employees);


/* 문제2.
평균급여 이상, 최대급여 이하의 월급을 받는 사원의
직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 최대급여를 급여의 오름차
순으로 정렬하여 출력하세요 (51건)
*/
select employee_id 직원번호, first_name 이름, salary 급여,
       평균급여, 최대급여
from employees e, (select avg(salary) 평균급여, max(salary) 최대급여 from employees)
where salary > 평균급여 and salary <= 최대급여
order by salary asc;


/* 문제3.
직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의
주소를 알아보려고 한다.
도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 
주(state_province), 나라아이디(country_id)를 출력하세요 (1건)
*/
--subQuery 이용
select location_id 도시아이디, street_address 거리명, postal_code 우편번호,
	   city 도시명, state_province 주, country_id 나라아이디
from locations
where location_id in (select location_id 
					  from departments
					  where department_id in (select department_id
					  						from employees
					  						where first_name = 'Steven' and
					  							  last_name = 'King')
					 );

--equi join 이용
select l.location_id 도시아이디, street_address 거리명, postal_code 우편번호,
	   city 도시명, state_province 주, country_id 나라아이디
from locations l, departments d,  employees e
where l.location_id = d.location_id and
	  d.department_id = e.department_id and
	  first_name = 'Steven' and
	  last_name = 'King';


/* 문제 4
job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의 사번,이름,급여를 급여의 내림차순으로
출력하세요 -ANY연산자 사용 (74건)
*/
select employee_id 사번, first_name 이름, salary 급여
from employees
where salary >any (select salary from employees where job_id = 'ST_MAN')
order by salary desc;


/* 문제5.
각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name)과
급여(salary) 부서번호(department_id)를 조회하세요.
단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다.
조건절비교, 테이블조인 2가지 방법으로 작성하세요 (11건)
*/
--in으로 구하기
select employee_id 직원번호, first_name 이름, salary 급여, department_id 부서번호
from employees
where (department_id, salary) in (select department_id, max(salary)
								  from employees
								  group by department_id)
order by salary desc;

--테이블로 join
select e.employee_id 직원번호, e.first_name 이름, d.salary 급여, d.department_id 부서번호
from employees e, (select department_id, max(salary) salary
				 from employees
				 group by department_id)
where e.department_id = d.department_id and
	  e.salary = e.salary
order by salary desc;


/* 문제6.
각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다.
연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오 (19건)
*/
select job_title 업무명, salary*12 연봉
from jobs j, (select job_id, max(salary) salary from employees group by job_id) e
where j.job_id = e.job_id;


/* 문제7.
자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 직원번호(employee_id),
이름 (first_name)과 급여(salary)을 조회하세요 (38건)
*/
select employee_id 직원번호, first_name 이름, e.salary 급여
from employees e, (select avg(salary) salary from employees group by department_id) d
where e.department_id = d.department_id and
	  e.salary > d.salary;


/*문제8.
직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을 
입사일 순서로 출력 하세요
*/
select rn, 사번, 이름, 급여, 입사일
from (select rownum rn, 사번, 이름, 급여, 입사일
      from (select employee_id 사번, first_name 이름, 
            salary 급여, hire_date 입사일
            from employees
            order by hire_date asc)
     )
where rn >= 11 and rn <= 15;