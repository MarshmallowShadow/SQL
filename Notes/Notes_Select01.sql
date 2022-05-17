--모든 column에 조회하기 (SELECT, FROM절)
select * from employees;
select * from departments;

-----------------------------------------------------------------------------

--원하는 column에 조회하기 (employee_id, first_name, last_name 조회하기)
select employee_id, first_name, last_name
from employees;

-----------------------------------------------------------------------------

--별명 이용법 (column명 대신 별명이 임시로 지정된다)
select employee_id as empNO,
first_name "f-name",
salary "연 봉", --특수문자는 "" 사용 필수
department_id 부서번호
from employees;

-----------------------------------------------------------------------------

--연결 연산자(Concatenation), ||를 이용해서 붙이기

select first_name || ' ' || last_name "이름"
from employees;

select first_name || ' 입사일은 ' || hire_date
from employees;

select employee_id || first_name
from employees;

-----------------------------------------------------------------------------

--산술 연산자

select first_name "Name", salary "Old Salary", salary + 500 "New Salary"
from employees;

select first_name "Name", salary "Old Salary", salary - 300 "New Salary"
from employees;

select first_name, salary * 12
from employees;

select first_name, department_id / 10
from employees;

select first_name, salary, (salary + 300) * 12
from employees

-----------------------------------------------------------------------------

--WHERE절
/* 어떠한 조건을 맞추는 데이터만 조회 (자바의 if문이랑 같은 개념) */

-----------------------------------------------------------------------------

--비교 연산자 (=, !=, >, <, >=, <=)
select first_name || ' ' || last_name "이름",
	   salary
from employees
where salary >= 10000;

--String은 '='랑 '!='만 이용 가능
select first_name || ' ' || last_name "이름",
	   hire_date
from employees
where first_name = 'John';

--겉으로만 String같이 보이지만 날짜 형식 (String이랑 다름)
select first_name || ' ' || last_name "이름",
	   hire_date
from employees
where hire_date >= '07/01/01';
-----------------------------------------------------------------------------

--조건이 2개 이상일때 조회 (and, or)

--and가 자바의 &&랑 똑같음
select first_name || ' ' || last_name "이름",
	   salary
from employees
where salary >= 10000 and salary <= 14000;

--or이 자바의 ||랑 똑같음 (sql의 ||랑 햇갈리지 않도록 주위)
select first_name || ' ' || last_name "이름"
from employees
where first_name = 'John' or first_name = 'Martha';

-----------------------------------------------------------------------------

--between 연산자
--salary가 10000이상('>=')  14000이하('<=") 일때만 조회
select first_name || ' ' || last_name "이름", salary
from employees
where salary betweem 10000 and 14000;

--in 연산자
--자바의 contains아님
select first_name || ' ' || last_name "이름", salary
from employees
where first_name in ('Martha', 'John');

--아래가 위랑 동일
select first_name || ' ' || last_name "이름"
from employees
where first_name = 'John' or first_name = 'Martha';

-----------------------------------------------------------------------------

--like연산자
--한글자 길이 -> _
--임의의 길이의 글자 길이 -> %

--맨 앞에 'J'들어간 이름 있는 데이터 조회 (대소문자 구분 주의)
select first_name || ' ' || last_name "이름", salary
from employees
where first_name like 'J%';

--맨 뒤에 'y'들어간 이름 있는 데이터 조회
select first_name || ' ' || last_name "이름", salary
from employees
where first_name like '%y';

--'h'뒤에는 길이 상관없을(%), 앞에는 '_'가 하나만 있어서 'h'가 두번쨰로 마지막을 의미
select first_name || ' ' || last_name "이름", salary
from employees
where first_name like '%h_';

--'_'가 3개, 그리고 'a'가 있어서 길이는 4글자로 고정, 근데 세번쨰 자리에는 무조건 'a'가 들어가야 함
select first_name
from employees
where first_name like '__a_';

-----------------------------------------------------------------------------

--(null)
--<0이랑 다름 (자바의 null이랑 같은 개념)>

--아무것도 안뜸, 틀린 방식 ('!='도 마찬가지)
select first_name, commission_pct
from employees
where commission_pct = null;

--'=' 대신 'is'가 맞음
select first_name, commission_pct
from employees
where commission_pct is null;

--'!=' 대신 'is not'가 맞음
select first_name, manager_id
from employees
where manager_id is not null;

-----------------------------------------------------------------------------

--ORDER BY절
/* 
데이터 정렬할때 사용
-String은 오르는 순서가 특수문자, 숫자, 알파벳(a,A,b,B,...), 한글
*/

--기본이 오르는 순서
select department_id, salary, first_name
from employees
order by department_id;

--desc 내리는 순서
select first_name, salary
from employees
order by salary desc;

--asc 오르는 순서, 먼저 입력한 column이 우선순위
select department_id, salary, first_name
from employees
order by department_id asc, salary desc;

-----------------------------------------------------------------------------

/*

SELECT 총 처리방법

1. "FROM"절의 테이블 이용
2. table로부터 한 row읽는다
3. "WHERE"절로 조건 만족하는지 확인 (아니면 2번 반복)
4. 임시 결과 생성
5. 모든 row 처리 될때까지 2~4번 반복
6. "ORDER BY"절로 정렬
7. "SELECT"절에 column만 출력

*/

------------------------------------------------------------------------------

--단일 함수

--문자열 함수

--'concat'
select concat(first_name, last_name) from employees;--"first_name || last_name"과 동일

--'initcap'
select initcap(first_name) from employees; --first_name에 첫번째 글자만 대문자

--'lower'
select lower(email) from employees; --email전부 소문자

--'upper'
select upper(first_name) from employees; --first_name 전부 대문자

--'lpad'
select lpad(department_id,5,'*') from employees; --lpad(문자열, 최대길이, 채움글자) 최대길이로 문자 자르고 부족한 공간은 채움글자로 왼쪽에서 채움

--'rpad'
select rpad(email,10,'*') from employees; --rpad(문자열, 최대길이, 채움글자) 최대길이로 문자 자르고 부족한 공간은 채움글자로 오른쪽에서 채움

--양쪽에 채울려면 이런 방식으로 하면 됨
select lpad(rpad(first_name, 10, '*'), 15, '*') from employees;
--길이가 더 짧으면 잘라버림
select first_name, lpad(first_name, 3, '*') from employees;
--rpad도 오른쪽에서 자름
select first_name, rpad(first_name, 3, '*') from employees;


--("dual"은 임시 테이블 만들때 사용)
--'ltrim'
select ltrim('      Hello      ') from dual; --왼쪽에 있는 공백 제거

--'rtrim'
select rtrim('      Hello      ') from dual; --오른쪽에 있는 공백 제거

select ltrim('HHHHHHHHHHhelloOOOOOOOOOOOOO', 'H') from dual; --왼쪽에 있는 'H'전부 제거 (대소문자 구분)

select rtrim('HHHHHHHHHHhelloOOOOOOOOOOOOO', 'H') from dual; --오른쪽에 있는 'O'전부 제거 (대소문자 구분)

--'chr'
select chr(99) from dual; --ASCII코드에서 문자로 반환

--'ascii'
select ascii('a') from dual; --문자를 ASCII코드로 반환

--'replace'
select first_name, replace(first_name, 'e', '*') from employees; --first_name에 모든 'e'를 '*'로 바꿈

--'substr'
select first_name, substr(first_name,2,3) from employees; --substr(문자열, 시작 위치(첫 위치가 1), 길이(왼쪽에서 오른쪽))
select first_name, substr(first_name,-4,3) from employees; --시작 위치가 음수면 오른쪽 기준으로 첫 위치가 -1, 길이는 똑같이 왼쪽에서 오른쪽

--'translate'
select first_name, translate(first_name, 'aeiouAEIOU', '**********') from employees; --translate(문자열, 바꿀 글자들, 바뀌는 문자, 재소문자 구분)
select first_name, translate(first_name, 'aeiou', '12345') from employees;
--바뀔 문자가 해당 위치에 있는 바꿀 문자로 바뀜 (a는1, e는2, i는3, o는4, u는5)
select first_name, translate(first_name, 'aeiouAEIOU', '*%') from employees;
--바뀔 문자 길이가 1보다 많고 바꿀 문자보다 적을 경우에는 길이 초과인 문자들은 전부 지워버림 (a는*, e는%, 나머지는 지움)

--'instr'
select first_name, instr(first_name, 'a', 3, 2) from employees;
--instr(문자열, 검색할 문자, 문자 검색 시작 위치, 몇번째로 나타나는걸 찾아야하는지) 해당 조건의 문자 첫 위치 출력 (첫 위치 기준 1)
--first_name에 3번재 글자부터 주번째로 나오는 'a'위치 찾기 (없으면 0출력)

--'length'
select first_name, length(first_name) from employees; --문자열 길이 출력

------------------------------------------------------------------------------

--숫자 함수

--'abs'
select abs(-5) from dual; --절대값

--'ceil'
select ceil(-6.9) from dual; --6.9보다 크거나 같은 최소 정수

--'floor'
select floor(-6.9) from dual; --6.9보다 작거나 같은 최대 정수 

--'round'
select round(6.9) from dual; --반올림
select round(3.1416, 2) from dual; --round(숫자, 소수자리) 반올림

--'mod'
select mod(420, 7) from dual; --나머지

--'power'
select power(30,2) from dual; --30의 2승

--'trunc'
select trunc(3.1416, 3) from dual; --trunc(숫자, 소수자리) 내림

--'sign'
select sign(-6.9) from dual; --0이면 0, 양수면 1, 음수면 -1

------------------------------------------------------------------------------

--날짜 함수
/*
한국 날짜은 기준이
	YYYY/MM/DD
	YYYY-MM-DD
	YY/MM/DD
	YY-MM-DD

순서 중요
	

요일은
	'일요일' = '일' = 1 != 'SUNDAY'(치면 오류)
	'월요일' = '월' = 2
	'화요일' = '화' = 3
	'수요일' = '수' = 4
	'목요일' = '목' = 5
	'금요일' = '금' = 6
	'토요일' = '토' = 7
*/

--'sysdate'
select sysdate from dual; --시스템 날짜 출력
select sysdate from employees; --employees에 갯수만큼 시스템 날짜 출력

--'add_months'
select add_months(sysdate, -1) from dual; --숫자만큼 sysdate에 달 추가

--'last_day'
select last_day(sysdate) from dual; --sysdate달에 마지막날 출력

--'months_between'
select months_between(sysdate, '97/05/12') from dual; --'97/05/12'에서 sysdate까지의 몇달차이인지 출력

--'new_time'
select new_time(sysdate, 'AST', 'PST') from dual; --sysdate가 AST 라는기준에서 PST로 전환 (한국시간은 날짜만 출력)

--'next_day'
select next_day(sysdate, '일') from dual; --sysdate부터 다음 일요일인 날짜 출력

--'round'
select round(sysdate, 'DAY') from dual; --주 기준으로 반올림 (수요일 이상이면 다음 일요일인 날짜로 출력)
select round(sysdate, 'MONTH') from dual; --달 기준으로 반올림 (예: 2022년 4월 15일이면 15일이 반인 기준으로 '22/05/01'로 반올림)
select round('2022/06/30', 'YEAR') from dual; --년 위주로 반올림 (예: 2022년 7월 15일이면 6월 30일이 반 기준으로 '23/01/01로 반올림)

--'trunc'
select trunc(sysdate, 'DAY') from dual; --sysdate에 날을 해당 주의 일요일로 뒤로 감
select trunc(sysdate, 'MONTH') from dual; --sysdate에 날을 1일로 내림

------------------------------------------------------------------------------

--변환 함수

--<to_char(숫자, 문자형식)>

--9의 길이만큼 문자로 표시 (적으면 공백으로 채워짐, salary가 더 길면 #####로 표시)
select first_name, to_char(salary, '99999') Salary from employees;

--0과 9의 길이만큼 문자로 표시 (적으면 공백으로 채워짐)
select first_name, to_char(salary, '099999') Salary from employees;

--숫자 뒤에 '$' 붙임
select first_name, to_char(salary, '$99999') Salary from employees;

--0과 9의 길이만큼 문자로 표시하고 뒤에 '$'붙임
select first_name, to_char(salary, '$09999.99') Salary from employees;

--'.'기준으로소수점 이하 표시
select first_name, to_char(salary, '9999.99') Salary from employees;

--'.'기준으로소수점 이하 표시
select first_name, to_char(salary, '99,999.99') Salary from employees;

--종합
select first_name, to_char(salary, '$09,999.99') Salary from employees;

--9대신 0으로 대체 가능
select first_name, to_char(salary, '000000') Salary from employees;

--다른 숫자로 대체 하면은 오류 생김
select first_name, to_char(salary, '333333') Salary from employees;


--to_char(날짜, 문자형식)

--날짜를 다른 형식으로 변경
select sysdate, to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS') from dual;

--날짜 한국어로 표현할때 (문자열 넣을때 ""꼭 쓰길!)
select sysdate, to_char(sysdate, 'YYYY"년" MM"월" DD"일"') from dual;

--문자열에 ""안쓰면 오류
select sysdate, to_char(sysdate, 'YYYY년 MM월 DD일') from dual;

------- 단일함수>변환함수>TO_CHAR(날짜, ‘출력모양’) 날짜문자형으로 변환하-----------
--‘YYYY’	연도를 4자리로 표현합니다. (22년도는 '2022')
--‘YY’		연도를 2자리로 표현합니다. (22년도는 '22')
--‘MM’		월을 숫자2자리로 표현합니다. (7월은 '07')
--‘MON’		유닉스에서는 월을 뚯하는 영어 3글자를 표현합니다.(7월은 'JUL')
--‘MON’		윈도우는 ‘MONTH’와 동일 합니다.(7월은 '7월')
--‘MONTH’	월을 뜻하는 이름 전체를 표현합니다.(7월은 '7월')
--'DD’		일을 숫자 2자리로 표현합니다.(15일은 '15')
--‘DAY’		유닉스에서는 요일을 영문으로 표현 합니다.(일요일은 'SUN')
--‘DAY’		윈도우에서는 요일을 한글로 표현 합니다.(토요일은 '토요일')
--'DDTH’	몇번째 날인지 표현합니다. (15일은 15TH)
--‘HH24’	하루를 24시간으로 표현합니다. (오후 7시는 19)
--'HH’		하루를 12시간으로 표현합니다. (7시는 07)
--‘MI’		분으로 표현합니다. (56분은 '56')
--'SS’		초로 표현합니다. (41초는 '41')


--<to_date(문자열식 날짜)>

--문자열을 날짜형식으로 변경 (날짜 함수에 기준 참고)
--반환 후에 날짜 관련 연산자 이용 가능
select to_date('2022/05/04') from dual;


--to_number(문자)
--문자열을 숫자로 반환 (반환하면 숫자 관련 연산자 이용 가능)
select to_number('0099') from dual;


--nvl(컬럼명, null일때값), nvl2(컬럼명, null아닐때값, null일때값)
--(null)을 전부 0으로 바꿈
select commission_pct, nvl(commission_pct, 0) from employees;

--(null)이면 0으로 바꿈, null 아니면 전부 1로 바꿈
select commission_pct, nvl2(commission_pct, 1, 0) from employees;

