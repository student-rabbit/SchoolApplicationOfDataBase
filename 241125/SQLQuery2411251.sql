USE SampleDB
/**********Ŀ��(Cursor)*********
 �������� ���(SQL)���� �������� �� ������ ������ ó���� �� �� �ִ� ����. *�Ѱ��� ���ڵ� ������ ������ ó�� == ������*
 �������� ���: �Ѱ��� ��ɾ���� ���ϴ� ��� ���� ����� �� �ִ� ��
 ����
  1. Ŀ�� ����(DECLARE)
  2. Ŀ�� ����(OPEN)
  3. �ݺ����� Ŀ�� �۾�=> Ŀ�� ������ ��������(FETCH) + ó��
  4. Ŀ�� �ݱ�(CLOSE)
  5. Ŀ�� �Ҵ� ����(DEALLOCATE)
*************************************************/
-- ����. ���� ���̺��� 80�� �̻� ------------------------------------------------
-- 1. Ŀ�� ����- ���� ����
declare s_test cursor for
select �й�, �̸�, ���� from ���� where ���� > 80
-- 2. Ŀ�� ���� - ���� ����
open s_test
-- 3. ���� ���� - 4���� ���� ����
declare @�й� char(9),
        @�̸� char(20),
		@���� int
-- 4. �Ѱ� ���ڵ� �о����
fetch next from s_test
into @�й�, @�̸�, @����
-- �ݺ��� ���� �Ǵ�. 0�� ����, -1�� ����
while @@FETCH_STATUS = 0
begin
  select @�й�, @�̸�, @����
  fetch next from s_test
  into @�й�, @�̸�, @����
end
-- 5. Ŀ�� �ݱ� - ���� ����
close s_test
-- 6. Ŀ�� �Ҵ� ���� - ���� ����
deallocate s_test
/*************************************************/
-- ����. �ӽ����̺� ���� ------------------------------------------------
create table #�ӽ�
(�й� char(9),
 �̸� char(20),
 ���� int)
-- 1. Ŀ�� ����- ���� ����
declare s_test cursor for
select �й�, �̸�, ���� from ���� where ���� > 80
-- 2. Ŀ�� ���� - ���� ����
open s_test
-- 3. ���� ���� - 4���� ���� ����
declare @�й� char(9),
        @�̸� char(20),
		@���� int
-- 4. �Ѱ� ���ڵ� �о����
fetch next from s_test
into @�й�, @�̸�, @����
-- �ݺ��� ���� �Ǵ�. 0�� ����, -1�� ����
while @@FETCH_STATUS = 0
begin
  insert into #�ӽ� 
  select @�й�, @�̸�, @����
  fetch next from s_test
  into @�й�, @�̸�, @����
end
-- 5. Ŀ�� �ݱ� - ���� ����
close s_test
-- 6. Ŀ�� �Ҵ� ���� - ���� ����
deallocate s_test
-- ��� Ȯ��
select * from #�ӽ�
/*************************************************/
-- ����. å ���̺��� ���ǻ��ڵ尡 p003�� 10% ���ΰ���, �������� ���󰡷� ��� ------------------------------------------------
-- Ŀ�� �۾��� å����, �о�, ���ǻ��ڵ�, ���� ���� ���� �ͼ� �۾��� ��.
create table #å
(å���� varchar(50),
 �о� varchar(20),
 ���ǻ��ڵ� char(5),
 ���� int)
-- 1. Ŀ�� ����
declare s_test cursor for
select å����, �о�, ���ǻ��ڵ�, ���� from å
-- 2. Ŀ�� ����
open s_test
-- 3. ���� ����
declare @å���� varchar(50),
        @�о� varchar(20),
        @���ǻ��ڵ� char(5),
        @���� int 
-- 4. �Ѱ� ���ڵ� �о����
fetch next from s_test
into @å����, @�о�, @���ǻ��ڵ�, @����

while @@FETCH_STATUS = 0
begin
  if(@���ǻ��ڵ� = 'p003')
    insert into #å values(@å����, @�о�, @���ǻ��ڵ�, @����*0.9)
  else
    insert into #å values(@å����, @�о�, @���ǻ��ڵ�, @����)
  fetch next from s_test
  into @å����, @�о�, @���ǻ��ڵ�, @����
end
-- 5. Ŀ�� �ݱ�
close s_test
-- 6. Ŀ�� �Ҵ� ����
deallocate s_test
-- 7. ����
select * from #å
/*************************************************/
CREATE TABLE ��ٱ���
(���Ź�ȣ INT IDENTITY,
 ������ǰ INT,
 ���ŷ� INT,
 �����Ѿ� INT)

INSERT ��ٱ��� VALUES(3,5,45000)
INSERT ��ٱ��� VALUES(1,1,20000)
INSERT ��ٱ��� VALUES(2,11,220000)
INSERT ��ٱ��� VALUES(4,2,60000)
INSERT ��ٱ��� VALUES(5,3,15000)
INSERT ��ٱ��� VALUES(3,7,21000)

select * from ��ٱ���

CREATE TABLE #��������
(���Ź�ȣ INT,
 ������ǰ int,
 ���ŷ� int,
 �����Ѿ� int,
 �������� VARCHAR(30))

-- ����. ���ŷ��� 5�̻��̰ų� �����Ѿ��� 10���� �̻��� ���ڵ���� ��� Ŀ�� ����. #�������� ���̺� �Է� ------------------------------------------------
-- 1. Ŀ�� ����
declare s_test cursor for
select * from ��ٱ��� where ���ŷ� > 5 or �����Ѿ� >100000
-- 2. Ŀ�� ����
open s_test
-- 3. ���� ����
declare @���Ź�ȣ INT,
        @������ǰ int,
        @���ŷ� int,
        @�����Ѿ� int
-- 4. �Ѱ� ���ڵ� �о����
fetch next from s_test
into @���Ź�ȣ,@������ǰ,@���ŷ�, @�����Ѿ�
-- ����.�����Ѿ��� 10���� �̻��̸� �����Ѿ��� 10%�����ϰ����ž� ���(��������)���̶� ��������, ���ŷ��� 5�̻��̸� �����ŷ� ������� ���������� ����  ------------------------------------------------
while @@FETCH_STATUS = 0
begin
  if(@�����Ѿ�>=100000)
    insert into #�������� values(@���Ź�ȣ,@������ǰ,@���ŷ�, @�����Ѿ�*0.9, '���ž� ���(���� ����)')
  if(@���ŷ�>=5)
    insert into #�������� values(@���Ź�ȣ,@������ǰ,@���ŷ�, @�����Ѿ�, '���ŷ� ���')
  fetch next from s_test
  into @���Ź�ȣ,@������ǰ,@���ŷ�, @�����Ѿ�
end
-- 5. Ŀ�� �ݱ�
close s_test
-- 6. Ŀ�� �Ҵ� ����
deallocate s_test
-- 7. ����
select * from #��������
/*************************************************/
-- ����. scroll �� �����ϰ� ���ڵ� �̵��� ����. ------------------------------------------------
-- 1. Ŀ�� ����- ���� ����
declare s_test scroll cursor for
select �й�, �̸�, ���� from ���� where ���� > 80
-- 2. Ŀ�� ���� - ���� ����
open s_test
-- 3. ���� ���� - 4���� ���� ����
declare @�й� char(9),
        @�̸� char(20),
		@���� int
-- 4. �Ѱ� ���ڵ� �о����
fetch next from s_test
into @�й�, @�̸�, @����

select @�й�, @�̸�, @����
-- 5. �ڷ� ���ư��� - scroll �� ���� ��쿡�� ����.
declare @�й� char(9),
        @�̸� char(20),
		@���� int

fetch prior from s_test
into @�й�, @�̸�, @����

select @�й�, @�̸�, @����
-- 5. ������ �л� Ȯ���غ��� - scroll �� ���� ��쿡�� ����.
declare @�й� char(9),
        @�̸� char(20),
		@���� int

fetch last from s_test
into @�й�, @�̸�, @����

select @�й�, @�̸�, @����
-- 5. ù��° �л� Ȯ���غ��� - scroll �� ���� ��쿡�� ����.
declare @�й� char(9),
        @�̸� char(20),
		@���� int

fetch first from s_test
into @�й�, @�̸�, @����

select @�й�, @�̸�, @����
-------------------------- ���� ���
select * from ����

begin tran
update ���� set ���� = 85 where �̸� = '������'  -- �ӽ� �������� ������.

declare @�й� char(9),
        @�̸� char(20),
		@���� int

fetch last from s_test
into @�й�, @�̸�, @����

select @�й�, @�̸�, @����

close s_test
deallocate s_test
-------------------------- �� ���� ���?? ���� Ȯ���غ���
declare s_test insensitive cursor for
select �й�, �̸�, ���� from ���� where ���� > 80

open s_test

declare @�й� char(9),
        @�̸� char(20),
		@���� int

fetch next from s_test
into @�й�, @�̸�, @����

select @�й�, @�̸�, @����

update ���� set ���� = 85 where �̸� = '������' 

close s_test
deallocate s_test

rollback