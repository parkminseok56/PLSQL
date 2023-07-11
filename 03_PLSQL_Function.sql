--�Լ�
--pl/sql �ڵ� �ۼ��ÿ��� ���ݱ��� ����ϴ� �͸� ���� �� ������� ����
--�Ϲ������� �̸��� �ִ� ���� ���α׷�(�Լ�) �Ǵ� ���ν����� ����ϴ� ���� ��κ���
--�͸� ���� �ѹ� ����ϰ� ���� ������ ������ �ֹ߼� �������� �Լ� �Ǵ� ���ν����� �������� ���� ������ ���̽��� ����� ������ ������ ����


--�Լ��� ����
--create or replace function �Լ��̸�(�Ű�����1, �Ű�����2)
--return ���ϵ� ������Ÿ��;
--is[as]
--  ����, ��� ����
--begin
--  �����
--  return ���ϰ�;
-- [exception
--      ����ó���� ]
--end [�Լ��̸�];

--�� Ű���庰 �󼼳���
--create or replace function : create or replace function��� ������ �̿��� �Լ� ����.
--           �Լ��� ����� �����ϴ��� �� ������ ��� ������ �� �� �ְ�, ���������� ������ �� ������ �Լ��� ����� �̸����� ����
--�Ű����� : �����μ��� �����ϴ� ������ "�����̸� ������ �ڷ���" ���·� �ۼ���
--ù��° return ���� �������� ���ϵ� �ڷ��� �ڷ����� ����, �Ʒ��� �ι�° return ���� ������ �� �ڷ������� ���� ���ϵ� �� �Ǵ� �����̸��� ����
-- [] �ȿ� �ִ� exception ������ �ʿ�ġ ���� �� ���� ����



--�ΰ��� ������ �����ؼ� ù��° ���� �ι�° ������ ���� �������� ���ؼ� �������ִ� �Լ�
set serveroutput on;

create or replace function myMod(num1 number, num2 number)
    return number
is
    v_remainder number :=0;    --���� �������� ������ ����
    v_mok number :=0;   --���� ���� ������ ����
begin
    v_mok :=floor(num1/num2);   --���� ���� ���� �κи� ����(�Ҽ��� ����)
    v_remainder :=num1-(num2*v_mok);   --��*������ ���������� ���� �������� ����
    return v_remainder;
end;


select myMod(14,4) from dual;


--��������1
--������ȣ�� �����μ��� ������ Booklist���� �ش� ���� ������ ���Ϲ޴� �Լ��� ����

--�Լ� ȣ�� ���
select subjectbynum(5), subjectbynum(50) from dual;

--�Լ� ����
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


--��������2
--���� �Լ��� ����� ���޵� ������ȣ�� �˻��� ������ ���ٸ�, '�ش� ���� ����'�̶�� ������ ���ϵǵ��� ����
--function ���ο��� count(*)�Լ� Ȱ��. ��ȸ�� ������ȣ�� ���ڵ尳���� 0���̸� '�ش� ���� ����'
select subjectbynum2(5), subjectbynum2(50) from dual;

--�Լ� ����
create or replace function subjectbynum2(num number)
    return varchar2
is
    v_subject varchar2(50);
    howmany number;
begin
    
    
    --���޹��� ������ȣ�� �ش��ϴ� ������ ������� ��ȸ
    select count(*)
    into howmany
    from booklist where booknum=num;
    
    if howmany =0 then
        v_subject := '�ش� ���� ����';
    else 
        select subject into v_subject from booklist where booknum=num;
     end if;
    return v_subject;
end;


--�Ű������� ���� �Լ�
create or replace function fn_get_user --�Ű������� ���� �Լ��� ��ȣ���� �����ϱ⵵ ��
    return varchar2
is
    vs_user_name varchar2(80);
begin
    select user into vs_user_name from dual;    --���� ����Ŭ �α��� ���� ��ȸ->vs_user_name������ ����
    return vs_user_name; --����� �̸� ����
end;
select fn_get_user(), fn_get_user from dual; --�Ű������� ���� �Լ��� ��ȣ ���� ȣ���ϱ⵵ ��


--��������3
--emp���̺��� �� �μ���ȣ�� ���޹޾Ƽ� �޿��� ��հ��� ����� �����ϴ� �Լ� �����ϱ�
--���޵� �μ���ȣ�� ����� ������ �޿������ 0���� ����
--�Լ� ȣ���� �Ʒ��� ����
select salAvgDept(10), salAvgDept(20), salAvgDept(30),salAvgDept(40) from dual;

create or replace function salAvgDept(dnum number)
    return number
is 
    aveSal number(10);
    worker number(2);
begin
    select count(*)  into worker  from emp where deptno=dnum; --���޵� �μ���ȣ�� �����ϴ��� ���� �˻�
if worker=0 then
    aveSal :=0;
else select avg(sal) into aveSal  from emp where deptno=dnum;
end if;
    return aveSal;
end;









