--���ν���
--�Լ��� ����� ����
--�Լ��� ��� ������ ������ ���ν����� ��������� ���� ���� Ư¡(������ ���� ������ �ڵ�(����)�� ����)
--return Ű���� ���, ���Ͽ����� �ϴ� ������ �ʿ䰳����ŭ ���� �����

--���ν����� ����
--create or replace procedure ���ν����̸�(
--  �Ű�������1 [in|out|in out] ������Ÿ��[:=����Ʈ ��],
--  �Ű�������2 [in|out|in out] ������Ÿ��[:=����Ʈ ��],
--  ...
-- )
--is(as)
--  ����, ��� ����
--begin
--  �����
--[exception
--  ����ó����]
--end [���ν����̸�];

-- create or replace procedure : ���ν����� �����ϴ� ����
--�Ű�������1 [in|out|in out] :�Ű������� ����� ���޵Ǵ� �����μ��� �޴� in������ ���Ͽ����� �Ҽ� �ִ� out������ ���� �� ���.
--  �Էº����� ��º����� ������ ���ÿ� �ο��Ƿ��� in out�� ���� �����
--  ���ν����� �⺻������ ���ϰ��� ������(���� return����� ������� ����) ������ �Ӽ��� out�Ӽ��ϳ��� �ο������ν�
--      ������ ������ �䳻�� �� �ְԴ� ����� ������
--  ���� �Ӽ��� in�ΰ�� ���� ����


--rentlist ���̺� ���ڵ带 �߰��ϴ� ���ν���
set serveroutput on;
create or replace procedure newRentList(
    p_bnum in rentlist.bnum%type,
    p_mnum in rentlist.mnum%type,
    p_discount in rentlist.discount%type)
is
begin
    insert into rentlist(rentdate, numseq, bnum, mnum, discount)
    values (sysdate, rent_seq.nextVal, p_bnum, p_mnum, p_discount);
    commit;
end;

exec newRentList(6,3,300);

select * from rentlist order by numseq desc;


--in,out, in out �Ű����� ��� #1
--newRentlist ���ν������� �Էµ� ���� ��¥�� ȣ���� ������ �ǵ��� �޾Ƽ� �����
create or replace procedure newRentList2(
    p_bnum in rentlist.bnum%type,
    p_mnum in rentlist.mnum%type,
    p_discount in rentlist.discount%type,
    p_outdate out rentlist.rentdate%type)
is
    v_sysdate rentlist.rentdate%type := sysdate;  --���� ����� ���ÿ� ���ó�¥�� ����
begin
    insert into rentlist(rentdate, numseq, bnum, mnum, discount)
    values (v_sysdate, rent_seq.nextVal, p_bnum, p_mnum, p_discount);
    commit;
    p_outdate := v_sysdate; --out������ ���ó�¥�� ��� �ִ� �������� ������
    --out������ ���� �ִ� ���� ȣ���� �� out������ �������� ������ �� ���� �����ϴ� �Ͱ� ����
end;
declare
    v_date rentlist.rentdate%type;
begin
    newRentList2(4,2,200,v_date);
    --�͸������ ���ν����� ȣ���� ���� exec�� ������� ����
    --���ν����� �ƴϰ� �Լ����ٸ� v_curdate=newrentlist2(7,2,200); �� ���� ����ϰ�����
    --���ν����̱� ������ �Ű������߿����� out������ �� ��� ������ ��������(�ڹ��� call by reference�� ���� �ǹ�)
    --���ν��� ���ο��� out������ ���� ���� �ִ� ������ ������ ȣ���� ������ �־��� ������ �� ���� �����޾Ƽ� ����� �Ͱ� ����.
    
    --���ν������� �־��� ���� ���� ������ ���� ��µ�
    dbms_output.put_line(v_date);
end;


--in,out, in out �Ű����� ��� #2
--in������ out������ in out ����
create or replace procedure parameter_test(
    p_var1 in varchar2,
    p_var2 out varchar2,
    p_var3 in out varchar2)
is
begin
    --in������ out������ ���޵� ������ ��� ����� ��
    dbms_output.put_line('p_var1 value = '||p_var1);
    --out������ �����μ��� ������ ���޹��� ���ϴ� ������. ���� �������൵ ������� ����
    --in �����μ��� ����� �ο��Ϸ��� ���� ������ in�� out�� ���� �����.
    dbms_output.put_line('p_var2 value = '||p_var2);
    dbms_output.put_line('p_var3 value = '||p_var3);
    --in ������ out������ ��� ���� �����غ�
    p_var1 := 'A2';  --in������ �����μ��� ���� ���� ������ �� ���Ƿ� ���� �������� ����.
    p_var2 := 'B2';
    p_var3 := 'C2';
end;

DECLARE
    v_var1 varchar2(10) :='A';
    v_var2 varchar2(10) :='B';
    v_var3 varchar2(10) :='C';
begin
    parameter_test(v_var1,v_var2,v_var3);
    dbms_output.put_line('v_var1 value = '||v_var1);
    dbms_output.put_line('v_var2 value = '||v_var2);
    dbms_output.put_line('v_var3 value = '||v_var3);
    --���ν����� out������ ���޵� ������ ���ν��� ���� �� ���ν��� ������ �־��� ���� ����Ǿ� �ְ� ��
end;

--in out ������ ����Ģ
--1. in ������ �����μ��� ���޵Ǿ� ����� ���� ������ �� �� �ְ�, ���� �Ҵ��� �� ����
--2. out �������� �����μ��� ���� ������ ���� ������, ������ �� �����Ƿ� �ǹ̰� ���� ����
--3. out ������ in out ������ ����Ʈ���� ������ �� ����
--4. in�������� ����, ���, �� ���������� ���� ���� �����μ��� ���� �� �� ������, out������ in out������ �ݵ�� �������·� �����μ��� �־������


--Default value
create or replace procedure newRentList(
    p_bnum in rentlist.bnum%type,
    p_mnum in rentlist.bnum%type,
    p_discount in rentlist.discount%type := 100 --����Ʈ ���:�Ű������� ���� �̸� ������
)
is
begin
    insert into rentlist(rentdate, numseq, bnum, mnum, discount)
    values (sysdate, rent_seq.nextVal, p_bnum, p_mnum, p_discount);
    commit;
end;
exec newRentList(5,5);

--�Ű����� �μ� ���޽�, ���� ����
exec newRentList(p_mnum=>5, p_bnum=>6);
select * from rentlist order by numseq desc;


--return��:���ν������� return�� ���� �����ϰڴٴ� ����� �ƴϰ�, ���������� ���ν����� �����ڴٴ� ��
--rentlist�� ���ڵ带 �߰��ϱ� ���� ���޵� ������ȣ�� ȸ����ȣ�� ���ٸ� '�ش� ������ȣ�� �����ϴ�' �Ǵ� '�ش� ȸ����ȣ�� �����ϴ�.' ��� ����ϰ�
--�߰��� ���ν����� �������� �Ʒ� ���ν����� �����ϱ�
--default value 2
create or replace procedure newRentList(
    p_bnum in rentlist.bnum%type,
    p_mnum in rentlist.bnum%type,
    p_discount in rentlist.discount%type := 100 --����Ʈ ���:�Ű������� ���� �̸� ������
)
is
    bcnt Number; mcnt Number;
begin
    select count(*) into bcnt from booklist where booknum=p_bnum;
    if bcnt=0 then
        dbms_output.put_line('�ش� ������ȣ�� �����ϴ�');  return; --���ν��� ����
    end if;
    select count(*) into mcnt from memberlist where membernum=p_mnum;
    if mcnt=0 then
        dbms_output.put_line('�ش� ȸ����ȣ�� �����ϴ�');  return; --���ν��� ����
    end if;
    insert into rentlist(rentdate, numseq, bnum, mnum, discount)
    values (sysdate, rent_seq.nextVal, p_bnum, p_mnum, p_discount);
    commit;
end;
exec newRentList(20,60,100);

--�Ű����� �μ� ���޽�, ���� ����
exec newRentList(p_mnum=>5, p_bnum=>6);
select * from rentlist order by numseq desc;



