------------------------------------------------------------------------------

--단일 함수

select avg(salary) from employees; --employees중 salary에서 평균 구함

select count(*) from employees; --employees에 총 건 수를 반환

select max(salary) from employees; --employees중 salary에 최대값을 반환

select min(salary) from employees; --employees중 salary에 최소값을 반환

select sum(salary) from employees; --employees에 있는 salary의 합계를 구합니다


--기타 예제

select count(*) from employees
where salary > 16000;

select round(avg(salary), 2) from employees;

select avg(first_name) from employees; --숫자열이 아니면 오류

select salary, round(avg(salary)) from employees; --오류

select count(*), max(salary), min(salary), avg(salary) from employees; --그룹함수들은 그룹함수끼리만 select가능

select avg(commission_pct)
from employees; --null들어가있는 값은 0으로 처리


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

------------------------------------------------------------------------------

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

