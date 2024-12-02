USE SampleDB
/*********************Ʈ���� �⸻��� ���� ������****************************/
-- �߿�!!!!!!
 -- �˻� select from where
 -- �Է� insert into values 
 -- ���� delete from where 
 -- ���� update set where 

create table e1
(��� int,
�̸� char(20),
���� char(10))

create table total
(���� char(10),
���ο� int)
insert total values('���',0)
insert total values('�븮',0)
insert total values('����',0)
insert total values('����',0)

select * from e1
select * from total
/*************************************************/
-- Ʈ���� ���� 1. e1���̺� ������ڵ尡 �ԷµǸ� total���ڵ忡 �Էµ� ����� ������ ���ο��� +1 �����Ǵ� insert Ʈ���Ÿ� �ۼ� ------------------------------------------------
create trigger e1_insert
on e1
after insert
as
begin
  update total
    set ���ο� = ���ο� + 1 
	where ���� = (select ���� from inserted) 
end
-- ���ڵ� �Է�
insert into e1 values(111,'ȫ�浿','���')
insert into e1 values(222,'�輱��','���')
insert into e1 values(123,'������','�븮')
/*************************************************/
-- Ʈ���� ���� 2. e1 ���̺��� ������ �����Ǹ� total���̺��� �ش� ���޿� ���� ���ο��� �����Ǵ� updateƮ���Ÿ� �ۼ�------------------------------------------------
create trigger e1_update
on e1
after update
as
begin
  update total
    set ���ο� = ���ο� - 1 
	where ���� = (select ���� from deleted) 
  update total
    set ���ο� = ���ο� + 1 
	where ���� = (select ���� from inserted) 
end
-- ���ڵ� ����
update e1 set ���� = '�븮' where �̸� = 'ȫ�浿'
/*************************************************/
-- Ʈ���� ���� 3. e1���̺��� ����� ���(����) �Ǹ� total���̺��� ���ο��� �ݿ��Ǵ� deleteƮ���Ÿ� �ۼ� ------------------------------------------------
create trigger e1_delete
on e1
after delete
as
begin
  update total
    set ���ο� = ���ο� - 1 
	where ���� = (select ���� from deleted)
end
-- ���ڵ� ����
delete from e1 where �̸� = 'ȫ�浿'
/**************************************************************************************************/
select datediff(yy, '2003/11/11', getdate())

-- ����� ���� �Լ� ���� 4. datadiff()�Լ��� �� ��¥���� ���̸� ����ϴ� �Լ��̴�. �� datediff()�Լ��� ����Ͽ� ���� �¾ ������ ���ݱ��� �� ������Ҵ���, ��ĥ ��Ҵ����� ����ϴ� ��Į�� �Լ��� �ۼ��ϰ� �����ϼ���. [����] datediff(dd, ù ��°��¥, �� ��° ��¥) ------------------------------------------------
create function birth(@dd date)
returns int
as
begin
  return(datediff(dd, @dd, getdate()))
end
-- ����
select dbo.birth('2003/12/19') ��ƿ³���
/*************************************************/
-- ����� ���� �Լ� ���� 5. ���� ������ �ζ��� ���̺� ��ȯ�Լ��� �ۼ��ϼ��� ------------------------------------------------
create function birth1(@dd date)
returns table
as
  return(select datediff(dd, @dd, getdate()) ��ƿ³�)
-- ����
select * from dbo.birth1('2003/12/19')
/*************************************************/
-- ����� ���� �Լ� ���� 6. ���߹� ���̺� ��ȯ�Լ��� �ۼ��ϼ���.  ------------------------------------------------
create function birth2(@dd date)
returns @r table
(��ƿ³� int)
as
begin
  insert into @r
  select datediff(dd, @dd, getdate())
  return
end
-- ����
select * from dbo.birth2('2003/12/19')
/*************************************************/
-- ����� ���� �Լ� ���� 7. ��ȭ ī���� ���� ������ ������ ����. �Ƹ޸�ī��- 3000, ī��� - 3500, �������꽺 - 4000, �����꽺 - 4500 ���Ằ ���� ���� �Է¹޾� ����, ���� ��, �հ踦 ����ϴ� ���߹� ���̺� �Լ��� �ۼ� ------------------------------------------------
create function cafe(@menu char(20), @num int)
returns @r table
(menu varchar(20),
 num int,
 price int)
as
begin
  insert into @r
  select @menu, @num,
  case @menu 
    when '�Ƹ޸�ī��' then @num*3000
    when 'ī���' then @num*3500
    when '�������꽺' then @num*4000
    when '�����꽺' then @num*4500
  end
  return
end
-- ���ڵ� �Է�
select * from dbo.cafe('�Ƹ޸�ī��',2)
/**************************************************************************************************/
create table #�а�
(���� char(20), �а��� varchar(30), ��ȭ char(13))

select * from �а�

-- Ŀ�� ���� 8.  ���̺� �а����� �а���, ��ȭ�� Ŀ���� �о�鿩 #�а����̺� ������ ���� �����͸� ä��� Ŀ�� �۾��� �ϼ���. ------------------------------------------------
-- Ŀ�� ����
declare s_test cursor for
select �а���, ��ȭ from �а�
-- Ŀ�� ����
open s_test
--������ ��������
declare @���� char(20), @�а��� varchar(30), @��ȭ char(13)

fetch next from s_test into @�а���, @��ȭ

while (@@FETCH_STATUS = 0)
begin
  select @���� = 
  case @�а���
    when '��ǻ�Ͱ���' then '��������'
    when '��ǰ����' then '�̰�����'
	else '��������'
  end
  insert into #�а�
  values(@����, @�а���, @��ȭ)
  fetch next from s_test into @�а���, @��ȭ
end
-- Ŀ�� �ݱ�
close s_test
-- Ŀ�� �Ҵ� ����
deallocate s_test
-- Ȯ��
select * from #�а�