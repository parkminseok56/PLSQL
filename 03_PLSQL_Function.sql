--함수
--pl/sql 코드 작성시에는 지금까지 사용하던 익명 블럭은 잘 사용하지 않음
--일반적으로 이름이 있는 서브 프로그램(함수) 또는 프로시저를 사용하는 것이 대부분임
--익명 블럭은 한번 사용하고 나면 없어져 버리는 휘발성 블럭이지만 함수 또는 프로시져는 컴파일을 거쳐 데이터 베이스에 저장돼 재사용이 가능한 구조


--함수의 형태
--create or replace function 함수이름(매개변수1, 매개변수2)
--return 리턴될 데이터타입;
--is[as]
--  변수, 상수 선언
--begin
--  실행부
--  return 리턴값;
-- [exception
--      예외처리부 ]
--end [함수이름];

--각 키워드별 상세내용
--create or replace function : create or replace function라는 구문을 이용해 함수 생성.
--           함수를 만들고 수정하더라도 이 구문을 계속 컴파일 할 수 있고, 마지막으로 컴파일 한 내용이 함수의 내용과 이름으로 사용됨
--매개변수 : 전달인수로 저장하는 변수로 "변수이름 변수의 자료형" 형태로 작성함
--첫번째 return 구분 다음에는 리턴될 자료의 자료형을 쓰고, 아래쪽 두번째 return 구문 옆에는 그 자료형으로 실제 리턴될 값 또는 변수이름을 써줌
-- [] 안에 있는 exception 구문은 필요치 않을 시 생략 가능



--두개의 정수를 전달해서 첫번째 값을 두번째 값으로 나눈 나머지를 구해서 리턴해주는 함수
set serveroutput on;

create or replace function myMod(num1 number, num2 number)
    return number
is
    v_remainder number :=0;    --나눈 나머지를 저장할 변수
    v_mok number :=0;   --나눈 몫을 저장할 변수
begin
    v_mok :=floor(num1/num2);   --나눈 몫의 정수 부분만 저장(소수점 절사)
    v_remainder :=num1-(num2*v_mok);   --몫*제수를 피제수에서 빼면 나머지가 계산됨
    return v_remainder;
end;


select myMod(14,4) from dual;


--연습문제1
--도서번호를 전달인수로 전달해 Booklist에서 해당 도서 제목을 리턴받는 함수를 제작

--함수 호출 명령
select subjectbynum(5), subjectbynum(50) from dual;

--함수 제작
create or replace function subjectbynum(num number)
    return varchar2
is
    v_subject varchar2(50);
--    v_subject booklist.subject%type;
begin
    select subject 
    into v_subject
    from booklist where booknum=num;
    
    return v_subject;
end;


--연습문제2
--위의 함수의 기능중 전달된 도서번호로 검색된 도서가 없다면, '해당 도서 없음'이라는 문구가 리턴되도록 수정
--function 내부에서 count(*)함수 활용. 조회한 도서번호의 레코드개수가 0개이면 '해당 도서 없음'
select subjectbynum2(5), subjectbynum2(50) from dual;

--함수 제작
create or replace function subjectbynum2(num number)
    return varchar2
is
    v_subject varchar2(50);
    howmany number;
begin
    
    
    --전달받은 도서번호의 해당하는 도서가 몇권인지 조회
    select count(*)
    into howmany
    from booklist where booknum=num;
    
    if howmany =0 then
        v_subject := '해당 도서 없음';
    else 
        select subject into v_subject from booklist where booknum=num;
     end if;
    return v_subject;
end;


--매개변수가 없는 함수
create or replace function fn_get_user --매개변수가 없는 함수는 괄호없이 정의하기도 함
    return varchar2
is
    vs_user_name varchar2(80);
begin
    select user into vs_user_name from dual;    --현재 오라클 로그인 유저 조회->vs_user_name변수에 저장
    return vs_user_name; --사용자 이름 리턴
end;
select fn_get_user(), fn_get_user from dual; --매개변수가 없는 함수는 괄호 없이 호출하기도 함


--연습문제3
--emp테이블에서 각 부서번호를 전달받아서 급여의 평균값을 계산해 리턴하는 함수 제작하기
--전달된 부서번호의 사원이 없으면 급여평균은 0으로 리턴
--함수 호출은 아래와 같음
select salAvgDept(10), salAvgDept(20), salAvgDept(30),salAvgDept(40) from dual;

create or replace function salAvgDept(dnum number)
    return number
is 
    aveSal number(10);
    worker number(2);
begin
    select count(*)  into worker  from emp where deptno=dnum; --전달된 부서번호가 존재하는지 먼저 검사
if worker=0 then
    aveSal :=0;
else select avg(sal) into aveSal  from emp where deptno=dnum;
end if;
    return aveSal;
end;









