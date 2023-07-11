--PL/SQL

--다수의 SQL명령이 모여서 하나의 작업모듈 또는 트랜잭션을 이룰 때 이를 하나의 블럭으로 묶어서 한번에 실행하게 하는 단위실행명령

--예를 들어 일반적인 쇼핑몰 데이터베이스에서
--장바구니에 있는 목록을 꺼내서 주문 테이블에 넣어야 할 때
--1. 장바구니 테이블에서 현재 접속자가 넣어둔 목록 조회(select)
--2. 목록을 주문테이블에 추가(insert)

--위와 같이 두개 이상의 SQL이 한번에 실행되고자 한다면 select의 결과를 변수에 넣고 변수에 저장된 값을 다시 insert 할 수 있음
--오라클이 제공하는 프로그래밍 요소와 함께 SQL 명령 그룹(블럭)을 만들어 한번에 실행할 수 있게 함
--그렇게 만들어진 PL/SQL 블럭은 추후에 우리가 학습할 MyBatis에서도 활용됨


--블럭
--PL/SQL은 여러 블럭으로 구성되어 있는데, 쉽게 짐작할 수 있는 실행할 sql명령이 모여있는 블럭 등이 있으며, 이는 명령의 실행 단위가 됨
--이외 익명 블럭, 이름이 있는 블럭 등도 있고 내부는 기능별로 이름부, 선언부, 실행부, 예외처리부로도 나누기도 함.

--PL/SQL문(블럭)의 구성 예
--PL/SQL로 하나의 단위명령을 실행할 때 아래와 같이 각 위치, 기능별 구성이 이뤄짐
IS(AS)
--이름부
DECLARE
--선언부(변수 선언 등등)
BEGIN
--실행부(SQL명령)
EXCEPTION
--예외처리부
END;
--BEGIN, END를 제외한 나머지는 필요에 의해 생략 가능


--익명 블럭(사용하지 않는 영역 키워드는 생략해도 무방)
declare
    num number; --변수 선언
begin
    num := 100;  --num 변수에 100을 저장  ->실행명령1
    DBMS_OUTPUT.PUT_LINE(num);  --결과화면에 num 변수값을 출력하세요 ->실행명령2
end;

--화면 출력을 위해 기능을 on함
set serveroutput on

--실행시간을 출력하기 위한 기능을 on함
set timing on
set timing off

--우리의 현재 목표는 웹사이트에서 전달받은 전달인수로 연산(sql)하고, 결과를 웹사이트로 다시 리턴해주는 것이지만
--현재는 그 상황까지 공부하지 못했으므로 내가 값을 넣어주고 (num:=100), 결과를 화면으로 출력함
--(DBMS_OUTPUT.PUT_LINE(num);

--변수: 첫번째 SQL에서 Orders 테이블에 레코드를 삽입하고, 가장 큰 기본키값을 조회한 다음 그 값을
--      oreder_detail의 입력값으로 사용하려면 변수를 선언하고 값을 저장해서 활용함.
--변수 선언방법
--변수명 변수자료타입
-- := 초기값; sql명령내의 =과 구분하기 위해 :=으로 사용합니다.

--pl/sql의 자료형
--기존의 oracle 자료형은 모두 포함하며, 자유롭게 사용 가능
--boolean :true, false, null 을 가질 수 있는 자료형
--pls_integer : -2147483648~2147483647값을 갖는 정수 number형에 비해 저장공간을 덜 차지함
--binary_integer: pls_integer와 같은 용량 같은 용도로 사용
--natral:pls_integer 중 양수(0포함)
--natraln: natral과 같지만, null허용이 없고 선언과 동시에 초기화 필요
--positive : pls_integer 중 양수(0미포함)
--positiven:positive 와 같지만, null허용이 없고 선언과 동시에 초기화 필요
--signtype: -1,0,1
--simple_integer:pls_integer 중 null이 아닌 모든 값, 선언과 동시에 초기화 필요


--연산자
--**:제곱(자승)연산 ->3**4 3의 4제곱
-- +,-:양수 음수 구분 연산
--사칙연산 +,-,*,/,||(문자열 연결)
--비교연산 =,>,<,<=,>=,<>,!=, is null, like, between, in
--논리연산 not and or

--pl/sql 블럭에 연산자를 사용한 예
declare
    a integer;
begin
    a :=2**2*3**2;
    DBMS_OUTPUT.PUT_LINE('a =' ||to_char(a));
end;
--begin등의 각 영역 내부에서는 한문장의 sql문도 하나의 명령어로, 연산자를 포함한 일반 명령어도 하나의 명령어로 인식해서
--맨뒤에 ';'이 있는 곳까지 실행함


--sql developer 쿼리창에는 반드시 블럭만 사용할 수 있는 건 아님. 일반적인 sql문도 사용가능.
select*from emp;

--sql문과 같이 사용되는 pl/sql블럭

--emp테이블에서 사원번호가 7900인 사원의 이름을 출력하기
select ename from emp where empno=7900; -- ->질의 결과 창에 table 형식으로 출력

-- 위 문장을 pl/sql의 블럭에 넣고 결과를 변수에 저장해서 DBMS_OUTPUT.PUT_LINE으로 출력하기
declare
    v_ename varchar2(30);
begin
    select ename 
    into v_ename 
    from emp 
    where empno=7900; --블럭 안에서 sql명령도 실행 가능함
    --블럭 안에서 sql명령도 실행 가능함
    --블럭 안에 sql문은 따로 지정없이 그냥 다른 명령과 같이 기술하면 됨
    --sql문의 결과를 변수에 담아내는 방법 ->select와 from사이에 into키워드를 넣고 저장될 변수를 지정함
    --select문과 from사이에 지정한 필드값이 여러개면, 그 개수만큼 into에 변수를 지정해 모두 저장될 수 있게 함
    DBMS_OUTPUT.PUT_LINE(v_ename);
end;

--사원번호가 7900인 사원의 이름과 급여를 출력하기

declare
    v_ename varchar2(30);
    v_sal number;
begin
    select ename, sal
    into v_ename, v_sal
    from emp
    where empno=7900;
    dbms_output.put_line(v_ename ||' '|| to_char(v_sal));
end;

--변수의 개수가 많은 경우 자료형을 일일히 맞춰서 선언하기가 번거로우므로, 매칭할 필드의 이름과 %Type을 이용해 자동으로 자료형이 맞춰지게 함
declare
    empname emp.ename%type; --emp 테이블의 ename필드의 자료형으로 변수의 자료형을 맞춰주세요
    empsal emp.sal%type;
begin
    select ename, sal
    into empname, empsal
    from emp
    where empno=7900;
    dbms_output.put_line(empname ||' '|| to_char(empsal));
end;

--연습문제1
--dbms_output.put_line을 9번 사용하여 구구단 7단을 출력하는 익명블럭을 제작하기
--이어붙이기 연산도 사용함
--현재는 변수가 필요하지 않기 때문에 declare도 쓰지 않아도 됨

begin
dbms_output.put_line('7 X 1 = '|| 7*1);
dbms_output.put_line('7 X 2 = '|| 7*2);
dbms_output.put_line('7 X 3 = '|| 7*3);
dbms_output.put_line('7 X 4 = '|| 7*4);
dbms_output.put_line('7 X 5 = '|| 7*5);
dbms_output.put_line('7 X 6 = '|| 7*6);
dbms_output.put_line('7 X 7 = '|| 7*7);
dbms_output.put_line('7 X 8 = '|| 7*8);
dbms_output.put_line('7 X 9 = '|| 7*9);
end;

--연습문제2
--사원테이블(emp)에서 사원번호(empno)7788번 사원의 이름(ename)과 부서명(dname)을 출력하는 익명 블록을 만드세요
--join명령 사용 '이름-부서명'을 스크립트 출력창에 출력
declare
    v_ename emp.ename%type;
    v_dname dept.dname%type;
begin
    select ename, dname
    into v_ename, v_dname
    from emp
    join dept
    on emp.deptno=dept.deptno
    where empno=7788;
    dbms_output.put_line(v_ename||'-'||v_dname);
end;

--연습문제3
--select로 얻어낸 값을 insert명령에 사용함
--사원테이블(emp)테이블에서 가장 큰 사원번호로 조회하고, 그 사원번호(empno)보다 1만큼 큰 숫자를 새로운 입력 레코드의 사원번호로 해 레코드를 추가
--일련번호 필드에 시퀀스가 없는 경우 사용하는 방법

--사원명:harrison
--job:manager
--mgr:7566
--hiredate:2022/06/14(오늘날짜)
--sal:3000
--comm:700
--deptno:40
declare
    max_empno emp.empno%type;
begin
    select max(empno)
    into max_empno
    from emp;
    
    max_empno :=max_empno+1;
    insert into emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
    values(max_empno, 'HARRISON', 'manager',7566, sysdate, 3000, 700, 40);
    
    --이건 auto commit이 아니여서 직접 commit을 내가 해야함
    commit;
end;

select * from emp order by empno desc;
























