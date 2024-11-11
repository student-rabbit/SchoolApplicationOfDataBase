/************************2024_Ʈ����.hwp*************************/
-- ����1. ����1 ���̺� �л����ڵ尡 �ԷµǸ� ���� ���̺��� �հ谡 �����ǵ��� insertƮ���Ÿ� ���� ------------------------------------------------
create table ����1
(�й� int,
 �а� char(2),
 �̸� char(20),
 ���� int)
--
create table ����
(�а� char(2),
 �հ� int) 
--
insert ���� values('d1',0),('d2',0),('d3',0)
--
select * from ����1
select * from ����
-- Ʈ���� ����
create trigger �л�insert
on ����1
after insert
as
begin
  update ����
  set �հ� = �հ� + (select ���� from inserted) 
  where �а� = (select �а� from inserted) 
end
-- ���ڵ� �Է�
insert into ����1 values(1, 'd1', 'ȫ�浿', 80)
insert into ����1 values(2, 'd1', '�輱��', 85)
insert into ����1 values(3, 'd2', '�ֿ���', 100)
insert into ����1 values(4, 'd3', '��ö��', 77)
/*************************************************/
-- ����2. ����1 ���̺� �л����ڵ尡 �����Ǹ� ���� ���̺��� �հ谡 �����ǵ��� deleteƮ���Ÿ� ���� ------------------------------------------------
create trigger �л�delete
on ����1
after delete
as
begin
 update ����
  set �հ� = �հ� - (select ���� from deleted) 
  where �а� = (select �а� from deleted) 
end
-- ���ڵ� ����
delete ����1 where �̸� = '��ö��'
/*************************************************/
-- ����3. ����1 ���̺� ������ �����Ǹ� ���� ���̺��� �հ谡 �����ǵ��� update Ʈ���Ÿ� ���� ------------------------------------------------
create trigger ����update
on ����1
after update
as
begin
 update ����
  set �հ� = �հ� - (select ���� from deleted) + (select ���� from inserted)
  where �а� = (select �а� from inserted)
end
-- ���ڵ� ����
update ����1 set ���� = 90 where �й� = 2
/*************************************************/
-- ����4. Ƽ�� ���̺��� �����ϰ� �׷��� Ƽ���� ������ ������ Ƽ�� ������ �ż��� ���� �Ѱ����� ����ϴ� Ʈ���Ÿ� Ʈ���� �߻� ������ �ۼ��ϼ���. ------------------------------------------------
create table Ƽ��
(��ȣ int identity,
 �Ƶ� int,
 û�ҳ� int, 
 ���� int)
--
select * from Ƽ��
-- Ʈ���� ����
create trigger Ƽ��insert
on Ƽ��
after insert
as
begin
 select �Ƶ�*2000+û�ҳ�*3000+����*5000 �ѱݾ� from inserted
end
-- ���ڵ� �Է�
insert Ƽ�� values(2,1,2)
insert Ƽ�� values(2,0,2)
insert Ƽ�� values(2,1,2)
/*************************************************/
-- ����5. ����4�� Ƽ�� ���̺��� �Ƶ�, û�ҳ�, ���� �� �ϳ��� Ƽ�� ���� �ż��� �����Ǹ� �Ѱ����� �ٽ� ����ؼ� ����ϴ� Ʈ���Ÿ� �ۼ��ϰ� Ʈ���� �߻� ������ �ۼ��ϼ���. ------------------------------------------------
create trigger Ƽ��update
on Ƽ��
after update
as
begin
 select �Ƶ�*2000+û�ҳ�*3000+����*5000 �ѱݾ� from inserted
end
-- ���ڵ� ����
update Ƽ�� set �Ƶ� = 10 where ��ȣ = 7