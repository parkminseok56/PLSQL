--if��
--����� ���� �� �� �ϳ��̰�, �ܵ� if�� ����� ��
--if ���� then
--  ���๮1
--end if

--����� ���� �� �� �ϳ��̰�, else�� �Բ� ����� ��
--if ���� then
--  ���๮1
--else
--  ���๮2
--end if

--����� ���� �� �̻��� ��
--if ����1 then
--  ���๮1
--elsif ����2 then  -->elsif ��Ÿ�ƴ�
--  ���๮2
--else
--  ���๮3
--end if

declare
    vn_num1 number := 35;
    vn_num2 number := 16;
begin
    if vn_num1>=vn_num2 then
        dbms_output.put_line(vn_num1 ||'��(��) ū ��');
    else
        dbms_output.put_line(vn_num2 ||'��(��) ū ��');
    end if;
end;


--emp���̺��� ����Ѹ��� ������ �� ������ �ݾ׿� ���� ����, �߰�, ���� �̶�� �ܾ ����ϴ� �͸� �� ����.
--(1~1000 ����   1001~2500����  2501~����)
--����� �����ϴ� ����� dbms_random.value�Լ��� �̿���
--������ �μ���ȣ�� ��ȸ�ϵ� �� �μ��� ����� �����̸� ù��° ������� ����
set serveroutput on;
declare
    v_sal number :=0;
    v_deptno number :=0;
begin
    --��� �Ѹ� ���� : �����ϰ� �μ���ȣ�� �����ؼ� �� �μ��� ù���� ���
    
    --�����ϰ� �μ���ȣ�� �߻�
    --dbms_random.value(���ۼ���, ������) : ���ڸ� ������ �ݿø��ڸ����� �ݿø���
    --�ݿø� �ڸ��� 1�̸� �Ҽ�����°�ڸ����� �ݿø��ؼ� ù°�ڸ����� ����
    --�ݿø� �ڸ��� -1�̸� 1�� �ڸ����� �ݿø�
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


--case��
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


--case ���� 1
--case when ����1 then
--      ���๮1
--     when ����2 then
--      ���๮2
--      else
--      ���๮3
--end case;

--case ���� 2-ǥ������ ��� �� �Ǵ� ������ ������ ����� ���� �б���
--case ǥ���� �Ǵ� ����
--     when ��1 then
--      ���๮1
--     when ��2 then
--      ���๮2
--      else
--      ���๮3
--end case;


--LOOP ��

--�ݺ����� ����1
--LOOP
--  ���๮;
--  exit [when ����];
--end loop;

declare
    vn_base_num number :=7; --��
    vn_cnt number :=1;  --�ݺ� ���� ���� �� �¼�
begin
    loop
        dbms_output.put_line(vn_base_num || 'x' || vn_cnt || '=' || vn_base_num*vn_cnt); --������ ���
        vn_cnt :=vn_cnt+1; --�ݺ����� ���� 1 ����
        exit when vn_cnt>9; --�ݺ����� ������ 9�� �ʰ��ϸ� �ݺ����� ����
    end loop;
end;


--�ݺ����� ����2
--while ����
--loop
--      condition
--end loop;

declare
    vn_base_num number :=6;
    vn_cnt number :=1;  --�ݺ� ���� ���� �� �¼�
begin
    while vn_cnt <=9 --vn_cnt�� 9���� �۰ų� ���� ��쿡�� �ݺ� ����
    loop
        dbms_output.put_line(vn_base_num || 'x' || vn_cnt || '=' || vn_base_num*vn_cnt); --������ ���
        vn_cnt :=vn_cnt+1; --�ݺ����� ���� 1 ����
    end loop;
end;


--while�� exit when�� ȥ�ջ��
declare
    vn_base_num number :=9;
    vn_cnt number :=1;  --�ݺ� ���� ���� �� �¼�
begin
    while vn_cnt <=9 --vn_cnt�� 9���� �۰ų� ���� ��쿡�� �ݺ�ó��
    loop
        dbms_output.put_line(vn_base_num || 'x' || vn_cnt || '=' || vn_base_num*vn_cnt); --������ ���
        exit when vn_cnt=5;
        vn_cnt :=vn_cnt+1; --�ݺ����� ���� 1 ����
    end loop;
end;



--for ��

--for ������ in [reverse] ���۰�..����
--loop
--      condition
--end loop;
--���۰����� �������� �ݺ�����. reverse�ΰ�� �ݴ������ ������������ �ݺ�����

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

--continue ��
declare
    vn_base_num number :=9;
begin
    for i in 1..9
    loop
        continue when i=5;  --������ �����ϸ� �ݺ����� ���� �� ������ ����� �������� �ʰ� ���� �ݺ����� ����
        dbms_output.put_line(vn_base_num|| 'x' || i || '= '||vn_base_num*i);
    end loop;
end;


--goto ��
declare
    vn_base_num number :=5;
begin
    <<fifth>> --���̶�� �θ�. goto���� �̵� �������� ����. ��� �������� ����
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


--null�� : if�� �Ǵ� case when ��� �ش� ��쿡 �����ؾ��� ����� �ϳ��� ���� �� ���� ������

--if vn_variable ='A' then
--  ó������1;
--elsif vn_variable ='B' then
--  ó������2;
--else
--  null;
--end if;

--case when vn_variable ='A' then
--  ó������1;
--     when vn_variable ='B' then
--  ó������2;
--     else
--      null;
--end case;










