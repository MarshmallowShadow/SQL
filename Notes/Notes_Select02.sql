------------------------------------------------------------------------------

--단일 함수

select avg(salary) from employees; --employees중 salary에서 평균 구함

select count(*) from employees; --employees에 총 건 수를 반환

select max(salary) from employees; --employees중 salary에 최대값을 반환

select min(salary) from employees; --employees중 salary에 최소값을 반환

select sum(salary) from employees; --employees에 있는 salary의 합계를 구합니다

select count(*) from employees
where salary > 16000;

select salary, round(avg(salary)) from employees; --오류남

select count(*), max(salary), min(salary), avg(salary) from employees;

