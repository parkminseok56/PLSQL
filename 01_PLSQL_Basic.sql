--PL/SQL

--�ټ��� SQL����� �𿩼� �ϳ��� �۾���� �Ǵ� Ʈ������� �̷� �� �̸� �ϳ��� ������ ��� �ѹ��� �����ϰ� �ϴ� ����������

--���� ��� �Ϲ����� ���θ� �����ͺ��̽�����
--��ٱ��Ͽ� �ִ� ����� ������ �ֹ� ���̺� �־�� �� ��
--1. ��ٱ��� ���̺��� ���� �����ڰ� �־�� ��� ��ȸ(select)
--2. ����� �ֹ����̺� �߰�(insert)

--���� ���� �ΰ� �̻��� SQL�� �ѹ��� ����ǰ��� �Ѵٸ� select�� ����� ������ �ְ� ������ ����� ���� �ٽ� insert �� �� ����
--����Ŭ�� �����ϴ� ���α׷��� ��ҿ� �Բ� SQL ��� �׷�(��)�� ����� �ѹ��� ������ �� �ְ� ��
--�׷��� ������� PL/SQL ���� ���Ŀ� �츮�� �н��� MyBatis������ Ȱ���


--��
--PL/SQL�� ���� ������ �����Ǿ� �ִµ�, ���� ������ �� �ִ� ������ sql����� ���ִ� �� ���� ������, �̴� ����� ���� ������ ��
--�̿� �͸� ��, �̸��� �ִ� �� � �ְ� ���δ� ��ɺ��� �̸���, �����, �����, ����ó���ηε� �����⵵ ��.

--PL/SQL��(��)�� ���� ��
--PL/SQL�� �ϳ��� ��������� ������ �� �Ʒ��� ���� �� ��ġ, ��ɺ� ������ �̷���
IS(AS)
--�̸���
DECLARE
--�����(���� ���� ���)
BEGIN
--�����(SQL���)
EXCEPTION
--����ó����
END;
--BEGIN, END�� ������ �������� �ʿ信 ���� ���� ����


--�͸� ��(������� �ʴ� ���� Ű����� �����ص� ����)
declare
    num number; --���� ����
begin
    num := 100;  --num ������ 100�� ����  ->������1
    DBMS_OUTPUT.PUT_LINE(num);  --���ȭ�鿡 num �������� ����ϼ��� ->������2
end;

--ȭ�� ����� ���� ����� on��
set serveroutput on

--����ð��� ����ϱ� ���� ����� on��
set timing on
set timing off

--�츮�� ���� ��ǥ�� ������Ʈ���� ���޹��� �����μ��� ����(sql)�ϰ�, ����� ������Ʈ�� �ٽ� �������ִ� ��������
--����� �� ��Ȳ���� �������� �������Ƿ� ���� ���� �־��ְ� (num:=100), ����� ȭ������ �����
--(DBMS_OUTPUT.PUT_LINE(num);

--����: ù��° SQL���� Orders ���̺� ���ڵ带 �����ϰ�, ���� ū �⺻Ű���� ��ȸ�� ���� �� ����
--      oreder_detail�� �Է°����� ����Ϸ��� ������ �����ϰ� ���� �����ؼ� Ȱ����.
--���� ������
--������ �����ڷ�Ÿ��
-- := �ʱⰪ; sql��ɳ��� =�� �����ϱ� ���� :=���� ����մϴ�.

--pl/sql�� �ڷ���
--������ oracle �ڷ����� ��� �����ϸ�, �����Ӱ� ��� ����
--boolean :true, false, null �� ���� �� �ִ� �ڷ���
--pls_integer : -2147483648~2147483647���� ���� ���� number���� ���� ��������� �� ������
--binary_integer: pls_integer�� ���� �뷮 ���� �뵵�� ���
--natral:pls_integer �� ���(0����)
--natraln: natral�� ������, null����� ���� ����� ���ÿ� �ʱ�ȭ �ʿ�
--positive : pls_integer �� ���(0������)
--positiven:positive �� ������, null����� ���� ����� ���ÿ� �ʱ�ȭ �ʿ�
--signtype: -1,0,1
--simple_integer:pls_integer �� null�� �ƴ� ��� ��, ����� ���ÿ� �ʱ�ȭ �ʿ�


--������
--**:����(�ڽ�)���� ->3**4 3�� 4����
-- +,-:��� ���� ���� ����
--��Ģ���� +,-,*,/,||(���ڿ� ����)
--�񱳿��� =,>,<,<=,>=,<>,!=, is null, like, between, in
--������ not and or

--pl/sql ���� �����ڸ� ����� ��
declare
    a integer;
begin
    a :=2**2*3**2;
    DBMS_OUTPUT.PUT_LINE('a =' ||to_char(a));
end;
--begin���� �� ���� ���ο����� �ѹ����� sql���� �ϳ��� ��ɾ��, �����ڸ� ������ �Ϲ� ��ɾ �ϳ��� ��ɾ�� �ν��ؼ�
--�ǵڿ� ';'�� �ִ� ������ ������


--sql developer ����â���� �ݵ�� ���� ����� �� �ִ� �� �ƴ�. �Ϲ����� sql���� ��밡��.
select*from emp;

--sql���� ���� ���Ǵ� pl/sql��

--emp���̺��� �����ȣ�� 7900�� ����� �̸��� ����ϱ�
select ename from emp where empno=7900; -- ->���� ��� â�� table �������� ���

-- �� ������ pl/sql�� ���� �ְ� ����� ������ �����ؼ� DBMS_OUTPUT.PUT_LINE���� ����ϱ�
declare
    v_ename varchar2(30);
begin
    select ename 
    into v_ename 
    from emp 
    where empno=7900; --�� �ȿ��� sql��ɵ� ���� ������
    --�� �ȿ��� sql��ɵ� ���� ������
    --�� �ȿ� sql���� ���� �������� �׳� �ٸ� ��ɰ� ���� ����ϸ� ��
    --sql���� ����� ������ ��Ƴ��� ��� ->select�� from���̿� intoŰ���带 �ְ� ����� ������ ������
    --select���� from���̿� ������ �ʵ尪�� ��������, �� ������ŭ into�� ������ ������ ��� ����� �� �ְ� ��
    DBMS_OUTPUT.PUT_LINE(v_ename);
end;

--�����ȣ�� 7900�� ����� �̸��� �޿��� ����ϱ�

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

--������ ������ ���� ��� �ڷ����� ������ ���缭 �����ϱⰡ ���ŷο�Ƿ�, ��Ī�� �ʵ��� �̸��� %Type�� �̿��� �ڵ����� �ڷ����� �������� ��
declare
    empname emp.ename%type; --emp ���̺��� ename�ʵ��� �ڷ������� ������ �ڷ����� �����ּ���
    empsal emp.sal%type;
begin
    select ename, sal
    into empname, empsal
    from emp
    where empno=7900;
    dbms_output.put_line(empname ||' '|| to_char(empsal));
end;

--��������1
--dbms_output.put_line�� 9�� ����Ͽ� ������ 7���� ����ϴ� �͸���� �����ϱ�
--�̾���̱� ���굵 �����
--����� ������ �ʿ����� �ʱ� ������ declare�� ���� �ʾƵ� ��

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

--��������2
--������̺�(emp)���� �����ȣ(empno)7788�� ����� �̸�(ename)�� �μ���(dname)�� ����ϴ� �͸� ����� ���弼��
--join��� ��� '�̸�-�μ���'�� ��ũ��Ʈ ���â�� ���
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

--��������3
--select�� �� ���� insert��ɿ� �����
--������̺�(emp)���̺��� ���� ū �����ȣ�� ��ȸ�ϰ�, �� �����ȣ(empno)���� 1��ŭ ū ���ڸ� ���ο� �Է� ���ڵ��� �����ȣ�� �� ���ڵ带 �߰�
--�Ϸù�ȣ �ʵ忡 �������� ���� ��� ����ϴ� ���

--�����:harrison
--job:manager
--mgr:7566
--hiredate:2022/06/14(���ó�¥)
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
    
    --�̰� auto commit�� �ƴϿ��� ���� commit�� ���� �ؾ���
    commit;
end;

select * from emp order by empno desc;
























