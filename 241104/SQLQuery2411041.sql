USE SampleDB
/**********delete*********
e.g. ���Ի���� ��縦 �ߴ�.
�ӽ����̺�: deleted
**********Ʈ����(Trigger)*********
 CREATE TRIGGER Ʈ���Ÿ�
 ON �۵���/�߻��ϴ� ���̺��
 AFTER ������ �ϸ�(INSERT OR UPDATE OR DELETE �� �ϳ� �ۼ�)
 AS
 BEGIN
  ����� �߻��Ѵ�. ������ �ǰ� �Ѵ�.
  �����ϰ� �� ���̺�
 END
*/
create table ���Ի��
(��� int,
 �̸� char(20))

select * from ���Ի��

CREATE trigger ���msg  
on ���Ի��  
after insert  
as  
begin  
  select �̸�+ '�� ȯ���մϴ�.!!~~~~' from inserted  
end

insert ���Ի�� values(1, 'ȫ�浿')
insert ���Ի�� values(2, 'ȫ���')
insert ���Ի�� values(3, '��ö��')
insert ���Ի�� values(4, '��ö��')

create trigger ���delete
on ���Ի��
after delete
as
begin
  select �̸� + '�� ����ϼ̱���.. �ƽ��׿�' from deleted
end

delete from ���Ի�� where ��� = 4
/*************************************************/
-- ����. �� ���̺��� ȸ���� Ż���ϸ� �������� ���̺��� �ش� ȸ�� ������ �����ϴ� Ʈ���� ��������del�� ���� ------------------------------------------------
select * from ��
select * from ��������

CREATE TRIGGER ��������_INSERT
ON ��
AFTER INSERT
AS
BEGIN
  IF (SELECT �������� FROM INSERTED) = 1
    INSERT INTO �������� SELECT ��id, ����, ����ó FROM INSERTED
END
-- ���ڵ� ����
INSERT �� VALUES(344,'�ڿ���','01-446-4573',1020,1)
INSERT �� VALUES(443,'�ڼ�','02-346-4573',1020,0)
INSERT �� VALUES(324,'�ֿ���','031-921-3312',755,1)
INSERT �� VALUES(714,'������','02-363-8765',1100,1)
--Ʈ���� ����
create trigger ��delete
on ��
after delete
as
begin
  -- if (select �������� from deleted = 1) ���� �ۼ����� �ʾƵ� �ȴ�.
    delete from �������� where ��id = (select ��id from deleted)
end
-- ���ڵ� ����
delete from �� where ���� = '�ֿ���'
delete from �� where ���� = '�ڼ�'

/*******************
-- insert
insert into ���̺�� values()

-- delete
delete from ���̺�� where

-- update
update ���̺�� set �������� where
********************/
/*************************************************/
-- ����. �԰� ��ǰ�� ���� �ȴٸ� ��ǰ�� �������� �°� �����Ͻÿ� ------------------------------------------------
select * from �԰�
select * from ��ǰ

create trigger �԰�insert
on �԰�
after insert
as
begin 
  update ��ǰ set ������=������+(select �԰���� from inserted)
              where ��ǰ�ڵ�=(select ��ǰ�ڵ� from inserted)
end 
-- ���ڵ� ����
insert �԰� values('P01', '2024/11/04', 10)
insert �԰� values('P01', '2024/11/04', 10
--Ʈ���� ����
create trigger ��ǰdelete
on �԰�
after delete
as
begin
  update ��ǰ set ������ = ������ - (select �԰���� from deleted)
              where ��ǰ�ڵ�=(select ��ǰ�ڵ� from deleted)
end
-- ���ڵ� ����
delete from �԰� where �԰��ȣ = 2
/*************************************************/
select * from ��������
select * from ��ǰ
-- Ʈ���� ����
create trigger ����delete
on ��������
after delete
as
begin 
    update ��ǰ set ���� = ���� - (select �������� from deleted) 
	            where ��ǰ�ڵ� = (select ��ǰ�ڵ� from deleted)
END
-- ���ڵ� ����
delete from �������� where ������ = '�̵���'