------------------------------------------------------------------------------

--subQuery (질의문 속의 질의문)


--<단일행 subQuery>

--subquery로 Den의 월급을 비교
--subQuery는 괄호로 묶어야함
--가급적 order by 최대한 안씀
select first_name, salary
from employees
where salary > (select salary 
                from employees 
                where first_name = 'Den');
--여기에 'Den'이라는 이름이 여러개일 경우에는 오류 생김

--'!=' 대신 '<>'씀
select first_name, salary
from employees
where salary <> (select salary 
                from employees 
                where first_name = 'Den');

--subQuery 결과가 여러게일때 오류남
select first_name, salary
from employees
where salary > (select salary 
                from employees 
                where first_name != 'Den');

--subQuery에 select도 많을때 오류
select first_name, salary
from employees
where salary > (select first_name, salary 
                from employees 
                where first_name = 'Den');

------------------------------------------------------------------------------

--<다중행 subQuery>

--<in>
--in을 통해 subQuery 반환값이랑 동일한 경우에 출력 가능
select first_name, salary
from employees
where salary in (select salary
				 from employees
				 where department_id = 100);
--동일
select firs_name, salary
from employees
where department_id = 100;

--<any> (or이랑 같은 개념)
--부서번호 110인 월급 중 하나라도 높은 전직원 출력
select employee_id, first_name, salary
from employees
where salary >any (select salary
				   from employees
				   where department_id = 110);
--동일
select employee_id, first_name, salary
from employees
where salary > 12008 or
	  salary > 8300;

--<all> (and랑 같은 개념)
--110 부서번호인 월급 보다 전부 높을 경우인 전직원 출력
select employee_id, first_name, salary
from employees
where salary >all (select salary
				   from employees
				   where department_id = 110);
--동일
select select employee_id, first_name, salary
from employees
where salary > 8300 and
	  salary > 12008;


--여러가지 값도 비교 가능 (단 비교대상이 꼭 있어야함)
select first_name, salary
from employees
where (department_id, salary) in (select department_id, max(salary)
				 				  from employees
				 				  group by(department_id));

--오류: department_id 비교대상이 subQuery에 없음
select first_name, salary
from employees
where (department_id, salary) in (select max(salary)
				 				  from employees
				 				  group by(department_id));

--오류: where문에 department_id 비교대상이 없음
select first_name, salary
from employees
where salary in (select department_id, max(salary)
				 from employees
				 group by(department_id));

--비교대상의 위치 주위 (순서가 바뀌면 원하는 결과가 안나옴)
select first_name, salary
from employees
where (department_id, salary) in (select max(salary), department_id
								  from employees
								  group by(department_id));


--subQuery로 join
--subQuery를 통해서 자기만의 커스텀 테이블 제작 가능
--subQuery는 from에서도 이용 가능 (subQuery도 케이블이기 때문에 두 테이블들을 join)
select e.department_id, e.employee_id, e.first_name, e.salary
from employees e, (select department_id, max(salary) salary
				   from employees
				   group by department_id) d
where d.salary = e.salary and 
	  d.department_id = e.department_id;

--where가 달리 테이블 row가 늘어난다
select *
from employees e, (select department_id, max(salary) salary
				   from employees
				   group by department_id) d
where d.salary = e.salary and 
	  d.department_id = e.department_id;

------------------------------------------------------------------------------


--<rownum>
--가로열 번호 생성
select rownum, first_name, salary
from employees
order by salary desc;

--예: 급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오.
--오답
select rownum, first_name, salary
from employees
where rownum < 6
order by salary desc;

--정답 (비효율적이지만 언전적인)
select rn, first_name, salary
from (select rownum rn, first_name, salary
	  from (select first_name,
	  			   salary
	  		from employees
	  		order by salary desc)
	  )
where rn <= 5;

--정답2
select rownum, first_name, salary
from (select rownum, first_name, salary
	  from employees
	  order by salary desc)
where rownum <= 5;

