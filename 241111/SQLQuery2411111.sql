USE SampleDB
/********** �߰��� ���ڵ� *********
 �ӽ� ���̺�: INSERTED
 ������ �ӽ� ���̺� : deleted
**********update Ʈ���� �۾�*********
 deleted�� ���� ���� ���ڵ� ���� ����ȴ�. == ����
 inserted�� ���� ���� ���ڵ� ���� ����ȴ�. == ���Ѵ�.
**********Ʈ����(Trigger)*********
 CREATE TRIGGER Ʈ���Ÿ�
 ON �۵���/�߻��ϴ� ���̺��
 AFTER ������ �ϸ�(INSERT OR UPDATE OR DELETE �� �ϳ� �ۼ�)
 AS
 BEGIN
  ����� �߻��Ѵ�. ������ �ǰ� �Ѵ�.
  �����ϰ� �� ���̺�
 END
***********************************
Ʈ���� Ư¡
1. �������� �����ų �� ����.
2. �Ű������� ����.
3. Ʈ������� �Ϻη� ó���ȴ�.
4. Ʈ���Ű� �� �ٸ� Ʈ���Ÿ� �����ų �� �ִ�.
5. Check ������ �̿��� �������� ���Ἲ ��������. ������ ������ �����Ѵ�.
***********************************
insert
 insert into ���̺�� values()

delete
 delete from ���̺�� where

update
 update ���̺�� set �������� where
*************************************************/
-- ����. �԰� ������ �����Ǹ� ��ǰ ���̺��� ��� ������ ���� ------------------------------------------------
create trigger �԰�insert
on �԰�
after insert
as
begin 
  update ��ǰ set ������ = ������ + (select �԰���� from inserted)
  where ��ǰ�ڵ� = (select ��ǰ�ڵ� from inserted)
end 
--
create trigger �԰�delete   
on �԰�  
after delete --!!!!!!!  
as  
begin  
   update ��ǰ set ������ = ������ - (select �԰���� from deleted)  
   where ��ǰ�ڵ� = (select ��ǰ�ڵ� from deleted)  
end
--
insert into �԰� values('P01', '2024/11/11', 5)
--
select * from �԰�
select * from ��ǰ
-- update Ʈ����
create trigger �԰�update
on �԰�
after update
as
begin
  update ��ǰ
   set ������ = ������-(select �԰���� from deleted)+(select �԰���� from inserted)
   where ��ǰ�ڵ� = (select ��ǰ�ڵ� from inserted)
end
-- update ���ڵ� �ۼ�
update �԰� set �԰���� = 10 where �԰��ȣ = 2
/************************************************
-- ����. �����������̺�� ��ǰ���̺��� ���������� ������ �����Ǹ� ��ǰ���̺��� �����ǵ��� Ʈ���Ÿ� �ۼ��Ͻÿ�. ------------------------------------------------
 Ʈ���Ÿ� �ۼ��� �� ���������� �۵��ϴ� ���� Ȯ���ϱ� ���� ���� SQL���� �����Ͻÿ�.
 update �������� set ��������=5  where ��ȣ=3
*/
create trigger ��ǰdelete  
on ��������   
after delete   
as  
begin 
  update ��ǰ
   set ���� = ���� - (select �������� from deleted )    
   where  ��ǰ�ڵ� = (select ��ǰ�ڵ� from deleted)   
end
--
create trigger ��ǰinsert  
on ��������  
after insert  
as  
begin  
  update ��ǰ
   set ���� = ���� + (select �������� from inserted )  
   where ��ǰ�ڵ� = (select ��ǰ�ڵ� from inserted)   
end
--
select * from ��������
select * from ��ǰ
-- update Ʈ���� �ۼ�
create trigger ����update
on ��������
after update
as
begin
 update ��ǰ
  set ���� = ���� - (select �������� from deleted) + (select �������� from inserted)
  where ��ǰ�ڵ� = (select ��ǰ�ڵ� from inserted)
end
-- update ���ڵ� ����
update �������� set ��������=5  where ��ȣ=3