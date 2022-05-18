-------------------------------------------------------------------------------
--DCL(Data Control Language, 데이터 제어어)

--<sys 계정>
--오라클 슈퍼사용자
--데이터베이스에서 발생하는 모든 문제 처리 가능
--Data Dictionary


--<system 계정>
--데이터베이스 유지보수 관리할때 사용
--계정 생성, 삭제, 비번 변경, 권한 등등

--계정 생성
create user /*user*/ identified by /*password*/;
create user webdb identified by 1234;

--접속권한 부여
grant /*권한*/ to /*user*/;
grant resource, connect to webdb;

--비밀번호 변경
alter user /*user*/ identified by /*new password*/;
alter user webdb identified by webdb;

--계정 삭제
drop user /*user*/ cascade;
drop user webdb cascade;

--유저들 확인
select * from all_users;

-------------------------------------------------------------------------------
--DDL(Data Definition Language, 데이터 정의어)

--오라클 기본 자료형
/*
	CHAR(*size*)	고정길이 문자열
VARCHAR2(*size*)	가변길이 문자열
	NUMBER(p,s)		숫자 데이터; p(전체자리수), s(소수점 이하 자리수); 자리수 없으면 기본 NUMBER(38)
		DATE		날짜 + 시간
*/

--테이블 생성하기
create table /*name*/(
	/*column name 1*/	/*data type*/,
	/*column name 2*/	/*data type*/,
	/*column name 3*/	/*data type*/,
	--...--
);

create table book(
    book_id number(5),
    title   varchar2(50),
    author  varchar(10),
    pub_date    date
);

--테이블 삭제하기
drop table /*table name*/;

drop table book;

--컬럼추가
alter table /*table name*/ add (/*column name*/ /*data type*/);

alter table book add (pubs varchar2(50));

--컬럼수정
--데이터 타입 수정
alter table /*table name*/ modify(/*column name*/ /*new data type*/);
alter table book modify(title varchar2(100));

--컬럼명 수정
alter table /*table name*/ rename column /*column name*/ to /*new column name*/; 
alter table book rename column title to subject;

--컬럼 삭제
alter table /*table name*/ drop /*column name*/;
atler table book drop (author);

--테이블명 수정
rename /*table*/ to /*new table name*/;
rename book to article;

--TRUNCATE 명령
--태이블 모들 row제거
truncate table /*table name*/;
truncate table article;