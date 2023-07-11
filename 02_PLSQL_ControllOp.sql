--if문
--경우의 수가 둘 중 하나이고, 단독 if로 사용할 때
--if 조건 then
--  실행문1
--end if

--경우의 수가 둘 중 하나이고, else와 함께 사용할 때
--if 조건 then
--  실행문1
--else
--  실행문2
--end if

--경우의 수가 셋 이상일 때
--if 조건1 then
--  실행문1
--elsif 조건2 then  -->elsif 오타아님
--  실행문2
--else
--  실행문3
--end if

declare
    vn_num1 number := 35;
    vn_num2 number := 16;
begin
    if vn_num1>=vn_num2 then
        dbms_output.put_line(vn_num1 ||'이(가) 큰 수');
    else
        dbms_output.put_line(vn_num2 ||'이(가) 큰 수');
    end if;
end;


--emp테이블에서 사원한명을 선별해 그 월급의 금액에 따라 낮음, 중간, 높음 이라는 단어를 출력하는 익명 블럭 제작.
--(1~1000 낮음   1001~2500보통  2501~높음)
--사원을 선별하는 방법은 dbms_random.value함수를 이용함
--랜덤한 부서번호로 조회하되 그 부서에 사원이 여럿이면 첫번째 사원으로 선택
set serveroutput on;
declare
    v_sal number :=0;
    v_deptno number :=0;
begin
    --사원 한명 선별 : 랜덤하게 부서번호를 결정해서 그 부서의 첫번재 사원
    
    --랜덤하게 부서번호를 발생
    --dbms_random.value(시작숫자, 끝숫자) : 숫자를 지정된 반올림자리에서 반올림함
    --반올림 자릿수 1이면 소수점둘째자리에서 반올림해서 첫째자리까지 남김
    --반올림 자릿수 -1이면 1의 자리에서 반올림
    v_deptno :=round(dbms_random.value(15,44),-1);
--    dbms_output.put_line(v_deptno);
    select sal into v_sal from emp where deptno=v_deptno and rownum=1;
    dbms_output.put_line(v_deptno);
    dbms_output.put_line(v_sal);


    if v_sal between 1 and 1000 then
        dbms_output.put_line('low');
    elsif v_sal >=1001 and v_sal<=2500 then
        dbms_output.put_line('average');
    elsif v_sal>2500 then
        dbms_output.put_line('high');
    end if;
end;
select*from emp;


--case문
declare
    v_sal number :=0;
    v_deptno number := 0;
begin
    v_deptno := round(dbms_random.value(15,44) ,-1);
    select sal into v_sal from emp where deptno=v_deptno and rownum=1;
    dbms_output.put_line(v_deptno);
    dbms_output.put_line(v_sal);
    
    case when v_sal between 1 and 1000 then
        dbms_output.put_line('low');
    WHEN v_sal >=1001 and v_sal<=2500 then
        dbms_output.put_line('average');
    when v_sal>2500 then
        dbms_output.put_line('high');
    end CASE;
end;


--case 유형 1
--case when 조건1 then
--      실행문1
--     when 조건2 then
--      실행문2
--      else
--      실행문3
--end case;

--case 유형 2-표현식의 결과 값 또는 변수의 값들의 경우의 수로 분기함
--case 표현식 또는 변수
--     when 값1 then
--      실행문1
--     when 값2 then
--      실행문2
--      else
--      실행문3
--end case;


--LOOP 문

--반복실행 유형1
--LOOP
--  실행문;
--  exit [when 조건];
--end loop;

declare
    vn_base_num number :=7; --단
    vn_cnt number :=1;  --반복 제어 변수 겸 승수
begin
    loop
        dbms_output.put_line(vn_base_num || 'x' || vn_cnt || '=' || vn_base_num*vn_cnt); --구구단 출력
        vn_cnt :=vn_cnt+1; --반복제어 변수 1 증가
        exit when vn_cnt>9; --반복제어 변수가 9를 초과하면 반복실행 멈춤
    end loop;
end;


--반복실행 유형2
--while 조건
--loop
--      condition
--end loop;

declare
    vn_base_num number :=6;
    vn_cnt number :=1;  --반복 제어 변수 겸 승수
begin
    while vn_cnt <=9 --vn_cnt가 9보다 작거나 같을 경우에만 반복 실행
    loop
        dbms_output.put_line(vn_base_num || 'x' || vn_cnt || '=' || vn_base_num*vn_cnt); --구구단 출력
        vn_cnt :=vn_cnt+1; --반복제어 변수 1 증가
    end loop;
end;


--while과 exit when의 혼합사용
declare
    vn_base_num number :=9;
    vn_cnt number :=1;  --반복 제어 변수 겸 승수
begin
    while vn_cnt <=9 --vn_cnt가 9보다 작거나 같을 경우에만 반복처리
    loop
        dbms_output.put_line(vn_base_num || 'x' || vn_cnt || '=' || vn_base_num*vn_cnt); --구구단 출력
        exit when vn_cnt=5;
        vn_cnt :=vn_cnt+1; --반복제어 변수 1 증가
    end loop;
end;



--for 문

--for 변수명 in [reverse] 시작값..끝값
--loop
--      condition
--end loop;
--시작값부터 끝값까지 반복실행. reverse인경우 반대방향의 숫자진행으로 반복실행

declare
    vn_base_num number :=8;
begin
    for i in 1..9
    loop
        dbms_output.put_line(vn_base_num || 'x' || i || '=' || vn_base_num*i); 
    end loop;
end;

--reverse
declare
    vn_base_num number :=8;
begin
    for i in reverse 1..9
    loop
        dbms_output.put_line(vn_base_num || 'x' || i || '=' || vn_base_num*i); 
    end loop;
end;

set serveroutput on;

--continue 문
declare
    vn_base_num number :=9;
begin
    for i in 1..9
    loop
        continue when i=5;  --조건이 충족하면 반복실행 영역 중 나머지 명령을 실행하지 않고 다음 반복으로 진행
        dbms_output.put_line(vn_base_num|| 'x' || i || '= '||vn_base_num*i);
    end loop;
end;


--goto 문
declare
    vn_base_num number :=5;
begin
    <<fifth>> --라벨이라고 부름. goto문의 이동 목적지로 사용됨. 사용 권장하지 않음
    for i in 1..9
    loop
        dbms_output.put_line(vn_base_num|| 'x' || i || '= '||vn_base_num*i);
        if i= 3 then
            goto sixth;
        end if;
    end loop;
    <<sixth>>
    vn_base_num :=6;
    for i in 1..9
    loop
        dbms_output.put_line(vn_base_num|| 'x' || i || '= '||vn_base_num*i);
    end loop;
end;


--null문 : if문 또는 case when 등에서 해당 경우에 실행해야할 명령이 하나도 없을 때 쓰는 구문임

--if vn_variable ='A' then
--  처리로직1;
--elsif vn_variable ='B' then
--  처리로직2;
--else
--  null;
--end if;

--case when vn_variable ='A' then
--  처리로직1;
--     when vn_variable ='B' then
--  처리로직2;
--     else
--      null;
--end case;










