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


--제약조건

/*
--NOT NULL: null값 입력불가
--UNIQUE: 중복값 입력불가 (null은 허용)
--PRIMARY KEY: NOT NULL + UNIQUE, 데이터들끼리 유일성을 보장함 (테이블당 1개)
--FOREIGN KEY (외래키): 일반적으로 REFERENCE 테이블의 PK를 참조 
						참조 테이블의 없는 값은 삽입 불가 (null은 가능)
*/

--예제
create table author (
	author_id		number(10),
	author_name		varchar2(100)		not null, --null값이 없으면 안됨
	author_desc		varchar2(500),
	primary key (author_id) --primary key는 마지막에 지정
);

--예제2
create table book (
	book_id		number(10),
	title		varchar2(100),		not null,
	pubs		varchar2(100),
	pub_date	date,
	author_id	number(10),
	primary key	(book_id)
	constraint	book_fk foreign key (author_id) --foreign key지정
	references	author(author_id) --참조 테이블
);
--'constraint	book_fk'는 foreign key(FK)에 이름을 주는 형식
--이름을 지정하는 이유:
--1. FK관한 요류 메세지가 뜰때 이름 지정 안하면 어디에서 오류가 나는지 알려주지 않음
--2. constraint(FK)를 수정할때 이름 필수

--**참조 테이블의 레코드 삭제 시 동작 (DML DELETE 참조)**
--ON DELETE CASCADE: 해당하는 FK를 가진 참조행도 삭제
--ON DELETE SET NULL: 해당하는 FK를 NULL로 바꿈

-------------------------------------------------------------------------------
--DML (Data Manipulation Lanaguge, 데이터 조작어)

--<INSERT>
--테이블에 데이터 추가

--*목시적 방법*
--컬럼, 이름, 순서 지정하지는 않지만 테이블 생성했을때 정의한 순서에 따라 값 지정
insert into /*table*/
values (/*value1*/, /*value2*/, ...);

--(author_id, author_name, author_desc) 순서
insert into author
values (1, '박경리', '토시작가');

--오류: 데이터 갯수가 안맞음
insert into author
values (1, '박경리');

--테이터 추가 안하고 싶으면 null삽입
insert into author
values (1, '박경리', null);


--*명시적 방법*
insert into /*table*/ (/*column1*/, /*column2*/, ... , /*column n*/)
values (/*value1*/, /*value2*/, ..., /*value n*/);

--예
insert into author (author_id, author_name)
values (2, '이문열');

--테이블 정의한 순서 아니라도 상관 없음
insert into author (author_name, author_id)
values ('이문열', 2);


--<UPDATE>
--데이터 수정
update /*table*/
set	/*colunm1*/ = /*new value1*/,
	/*colunm2*/ = /*new value2*/,
...
where /*조건*/;

--id 1인 작가 수정
update author
set author_name = '기안84',
    author_desc = '웹툰작가'
where author_id = 1;

--where조건 만족하지 못하는 경우에는 오류 대신 0개 수정되었다고 뜸
update author
set author_name = '기안84',
    author_desc = '웹툰작가'
where author_id = 666;

--조건이 없을 경우에는 전부 수정
update author
set author_desc = '웹툰작가';


--<DELETE>
--테이블 데이터 삭제
delete from /*table*/
where /*조건*/;

--조건 없으면 데이터 전부 삭제
--truncate랑 같음
delete from /*table*/;

--예
delete from author
where author_id = 1;


--FK참조되어있는 PK삭제 시
--(books에 FK1이 있는 데이터 있을 경우에)

--해당 id있는 책 전부 삭제
delete from author
where author_id = 1
on delete cascade;

--해당 id있는 책에 있는 author_id null로 지정
delete from author
where author_id = 1
on delete set null;


-------------------------------------------------------------------------------
--<SEQUENCE>
--연속적인 일련번호 생성 (PK에 주로 사용)

--생성
create sequence /*name*/
increment by /*increase value*/
start with /*starting value*/;

create sequence seq_author_id
increment by 1
start with 1;

--사용
/*sequence name*/.nextval
--예
insert into author
values (seq_author_id.nextval, '박경리', '토지 작가 ' ); --seq_author_id = 1

insert into author
values (seq_author_id.nextval, '이문열', '삼국지 작가'); --seq_author_id = 2


--sequence 조회
select * from user_sequences;

--현제 시퀀스 조회
select /*sequence name*/.currval from dual;

--다음 시퀀스 조회
--쓸때 주의 (다음 값이 오름, 임시 아님)
select /*sequence name*/.nextval from dual;

--sequence 삭제
drop sequence /*sequence name*/;


-------------------------------------------------------------------------------
--COMMIT
--현제 스테이트 저장
commit;

--ROLLBACK
--마지막으로 commit했던 시기로 돌아가기
rollback;

