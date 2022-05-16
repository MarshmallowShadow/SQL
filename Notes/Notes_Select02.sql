------------------------------------------------------------------------------

--단일 함수

select avg(salary) from employees; --employees중 salary에서 평균 구함

select count(*) from employees; --employees에 총 건 수를 반환

select max(salary) from employees; --employees중 salary에 최대값을 반환

select min(salary) from employees; --employees중 salary에 최소값을 반환

select sum(salary) from employees; --employees에 있는 salary의 합계를 구합니다


--avg 예제--

select avg(first_name) from employees; --숫자열이 아니면 오류

select avg(commission_pct) from employees; --null들어가있는 값은 미포함

select avg(nvl(commission_pct, 0)) from employees; --null값을 포함하는 방법

select round(avg(salary), 2) from employees;


--count 예제--

select count(commission_pct) from employees; --null값은 미포함

select count(nvl(commission_pct, 0)) from employees; --null값 포함

select count(*) from employees
where salary > 15000;


--기타 예제--

select salary, round(avg(salary)) from employees; --오류

select count(*), max(salary), min(salary), avg(salary) from employees; --그룹함수들은 그룹함수끼리만 select가능


------------------------------------------------------------------------------

--GROUP BY절

select manager_id from employees
group by manager_id; --같은 manager_id끼리 묶음

select manager_id from employees
group by manager_id
order by manager_id asc; --정렬은 묶은 후 가능

select job_id, avg(salary) from employees
group by job_id; --묶은 row들 끼리 salary의 평균 구함

select job_id, department_id, avg(salary) from employees
group by job_id; --오류: group by column명이 아닌 column입력하면 오류

------------------------------------------------------------------------------

--HAVING절

select department_id, count(*), sum(salary)
from employees
group by department_id
where sum(salary) >= 20000; --WHERE절로 그룹함수 비교할려면 오류

select department_id, count(*), sum(salary)
from employees
group by department_id
having sum(salary) >= 20000; --Group함수들 용 WHERE

select department_id, count(*), sum(salary)
from employees
where salary >= 10000
group by department_id; --WHERE을 쓸거면 GROUP BY 전에 이용

/*
처리 순서:
1. FROM로 테이블 생성
2. WHERE 조건맞는 데이터만 남김
3. GROUP BY 별로 묶는다
4. HAVING 조건 있는 그룹 남김
5. SELECT 원하는 결과를 출력
6. ORDER BY 기준으로 정렬
*/

-------------------------------------------------------------------------------

--CASE,WHEN,THEN,ELSE,END문

/* 형식
case when 조건1 then 출력1
	 when 조건2 then 조건2
	 ...
	 else 출력n
end "컬럼명"
*/

--자바의 if-else랑 비슷한 개념

select employee_id, department_id, salary,
	   case when department_id = 10 then salary + salary
	   		when department_id > 50 then salary * 1.2
	   		when department_id is null then salary + salary * 9
	   		else salary
	   	end new_salary
from employees;

/* 자바 형식으로 CASE,WHEN,THEN,ELSE,END 표현

double new_salary;

if(department_id == 10) {
	new_salary = salary + salary;
} else if(department_id == 20) {
	new_salary = salary * 1.2;
} else if(department_id == null) {
	new_salary = salary + salary * 9;
} else {
	new_salary = salary;
}

*/

--DECODE()함수

select employee_id, department_id, salary,
	   decode( department_id, 10, salary - 100,
				20, salary * 1.5,
				salary
	   	) new_salary
from employees;
--DECODE야말로 자바의 switch-case랑 개념이 똑같음
--DECODE는 SWITCH~ELSE처럼 <, >, 등 못씀

--SWITCH~ELSE로 위 명령 표현
select employee_id, department_id, salary,
	   case when department_id = 10 then salary - 100
	   		when department_id = 20 then salary * 1.5
	   		else salary
	   	end new_salary
from employees;

/* 자바 형식으로 DECODE 표현

double new_salary;

switch department_id:
	case 10:
		new_salary = salary - 100;
		break;
	case 20:
		new_salary = salary * 1.2;
		break;
	case null:
		new_salary = salary + salary * 9; //이거는 자바에서 이렇게 하면 오류 날 수 있음
		break;
	default:
		new_salary = salary;
		break;
*/

-------------------------------------------------------------------------------

--Join (equi join)

select first_name, country_name
from employees, countries; --country_name 과 first_name 의 모든 조합 출력 (약 2675 데이터 출력)

select em.first_name, jh.start_date, jh.end_date --해당 테이블에 column을 select
from employees em, job_history jh --클래스 선언이랑 비슷한 개념 (테이블에 Alias(이름) 지정)
where em.employee_id = jh.employee_id; --조합을 축소 방법 (두 테이블에 PK와 FK를 통한 연결고리)

--카티션 프로덕트 (Cartesian Product): 두 테이블 데이터의 갯수의 곱
--올바른 Join조건을 WHERE절에 부여 해야 함 (employees와 job_history의 employee_id)

select employees.first_name, job_history.start_date, job_history.end_date
from employees, job_history
where employees.employee_id = job_history.employee_id; --Alias 주지 않아도 가능

select first_name, start_date, end_date
from employees, job_history
where employees.employee_id = job_history.employee_id; --중복 column명이 없으면 이런 식으로도 가능

select employee_id, first_name, start_date, end_date
from employees, job_history
where employees.employee_id = job_history.employee_id; --두 테이블에 employee_id라는 중복 이름이 있어서 오류

select em.employee_id, first_name, start_date, end_date
from employees em, job_history jh
where em.employee_id = jh.employee_id; --최소 중복 이름 있는 데이터는 지정 필수

select first_name, em.department_id, 
       department_name, de.department_id
from employees em, departments de
where em.department_id = de.department_id; --두 테이블에 데이터가 null일 경우에는 출력 안함 (107개중 106개만 생성)

select first_name, em.department_id, 
       department_name, de.department_id
from employees em, departments de
where em.department_id = de.department_id or
	   em.department_id is null; --원하던 결과가 아님...

/*
처리 순서:
1. FROM로 테이블 생성
2. WHERE 조건맞는 데이터만 남김
(GROUP BY, HAVING 불과)
3. SELECT 원하는 결과를 출력
4. ORDER BY 기준으로 정렬
*/

-------------------------------------------------------------------------------

--left outer join
select first_name, em.department_id, 
       department_name, de.department_id
from employees em, left outer join departments de
where em.department_id = de.department_id; --em에서 department_id가 null일 경우에도 (+)를 통해서 null있는 데이터 출력 가능
	   
select first_name, em.department_id, 
       department_name, de.department_id
from employees em, departments de
where em.department_id = de.department_id(+); --oracle에서만 지원

--right outer join
select first_name, em.department_id, 
       department_name, de.department_id
from right outer join employees em, departments de
where em.department_id = de.department_id; --left랑 right는 테이블의 위치 차이 (왼쪽테이블 기준으로 오른쪽에만 null이 없을 경우 출력)

select first_name, em.department_id, 
       department_name, de.department_id
from employees em, departments de
where em.department_id(+) = de.department_id;  --oracle에서만 지원

--full outer join
select first_name, em.department_id, 
       department_name, de.department_id
from employees em, departments de
where em.department_id(+) = de.department_id(+); --right outer join이랑 left outer join 포함 데이터 다 들어감

--self join
select em.employee_id, man.first_name, emp_first_name, em.manager_id
from employees em, employees man
where man.employee_id = emp.manager_id; --같은 테이블인 employees(em)랑 employees(man)랑 비교해서 연결고리 있는 데이터 출력
--alias 이용 필수

