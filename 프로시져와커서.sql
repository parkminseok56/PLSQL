SET SERVEROUTPUT ON;
-- 프로시져 (Procedure)
-- 웹 어플리케이션에서 데이터베이스로 접근할때 사용하는 오라클의 서브프로그램입니다.
-- 전달과 리턴을 통해 웹 어플리케이션과 데이터를 주고 받습니다.

CREATE OR REPLACE PROCEDURE 프로시져이름(
    -- 이곳엔 프로시져로 전달되는 전달인수를 받아서 저장할 매개변수가 정의됨.
    --  매개변수명 1 [IN | OUT | IN OUT ] 데이터타입
    --  매개변수명 2 [IN | OUT | IN OUT ] 데이터타입
    
    매개변수명 1 IN MEMBER.ID%TYPE
    매개변수명 2 IN MEMBER.PWD%TYPE
    매개변수명 2 IN MEMBER.EMAIL%TYPE
)
IS
  -- 이곳엔 프로시져에서 임시로 사용할 임시변수들은 선언함.
      TEMP_VAR MEMBER.ADDRESS3%TYPE;
BEGIN
   -- 이곳엔 데이터베이스를 조작할 SQL 명령과 PL/SQL 명령이 코딩됨.
   INSERT INTO MEMBER VALUES(매개변수명 1,매개변수명 2,매개변수명 3);
   COMMIT;
END;

--프로시져의 호출
EXEC 프로시져이름('SCOTT','1234','abc@abc.com');






--매개변수의 적용되는  IN,  OUT, IN OUT 의 사용
CREATE OR REPLACE PROCEDURE parameter_test(
 
    
    p_var 1 IN VARCHAR2,
    p_var 2 OUT VARCHAR2,
    p_var 3 IN OUT VARCHAR2 )
IS
  
   
BEGIN
    
     p_var 2 := 'B2'; -- 호출한 곳으로 'B2' 값을 변수  p_var 2를 이용하여 전달함.
     p_var 3 := 'C2'; -- 호출한 곳으로 'C2' 값을 변수  p_var 3를 이용하여 전달함.

END;


DECLARE 

   V_var 2 VARCHAR2(10);
   V_var 3 VARCHAR2(10):= 'C';
   
BEGIN
    parameter_test('A', V_var 2,V_var 3);
END;

--  IN : 프로시져 호출 시 전달되는 값을 받아서 저장 후 사용하는 용도로만 정의됨.

--  OUT : 프로시져를 호출하면서 OUT 변수자리에 값이 아닌 변수를 넣어주면, 프로시져에서 그 변수에 값을 넣어줌
--       프로시져가 넣어준 값은 호출된 곳에서 활용됨. (자바의 CALL BY REFERECE와 비슷한 개념임)

--  IN OUT : 두 가지 용도 모두 사용됨.
 

--  IN OUT 변수의 사용 시 유의사항
--  1. IN 변수는 전달인수로 전달되어 저장된 값을 참조만 할 수 있고, 값을 다시 대입하여 사용할 수 없음.
--  2. OUT 변수에는 전달인수로 '값'을 전달할 수 는 있지만, 참조할 수 없으므로, 의믜가 없는 전달임.
--  3. OUT 변수와 IN OUT 변수는 디폴트값을 지정할 수 없음.
--  4. IN 변수에는 변수, 상수, 각 데이터형에 따른 값을 전달인수로 전달할 수 있지만, OUT 변수와 IN OUT 변수는 
--     반드시 변수형태로 전달인수를 넣어주어야 함.




-------------------------------------------------------------------------------------------------------------------------------
-- CURSOR : 주로 프로시져 내부의 SQL 명령 중 SELECT 명령의 결과가 다수의 행(레코드) 으로 얻어졌을떼
--          결과 레코드(들)를 저장하는 변수를 말함.

CREATE OR REPLACE PROCEDURE testCursorArg(
       -- 호출한 곳에서 결과를 받아서 활용하기 때문에 커서변수가 매개변수이면서 OUT 변수로 선언됨.
       P_curvar OUT SYS_REFCURSOR)
IS
BEGIN
       OPEN temp_curvar FOR SELECT * FROM emp WHERE deptno=10;
       -- SELECT 문의 결과가 OUT 변수에 담겨서 전달됨.
       P_curvar := temp_curvar;

END;




























