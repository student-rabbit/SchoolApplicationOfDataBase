USE SampleDB
/********** �߰��� ���ڵ� *********
 �ӽ� ���̺�: INSERTED
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
/*************************************************/
select * from ��������
select * from ��ǰ
-- ����. ���������� ���ڵ带 �߰��ϸ� ��ǰ�� ������ ���� ------------------------------------------------
create trigger ����insert
on ��������
after insert
as
begin 
    update ��ǰ set ���� = ���� + (SELECT �������� FROM INSERTED) 
	            where ��ǰ�ڵ� = (SELECT ��ǰ�ڵ� FROM INSERTED)
END
-- �߰��� ���ڵ�
insert �������� values('p01', '��ö��', 10)
insert �������� values('p02', '�̵���', 10)
/*************************************************/
-- ����. ��ٱ��� ���̺� ���ڵ尡 ���Եɶ����� �� �ݾ��� ��µǴ� Ʈ���Ÿ� �����ϼ���. ����, Ʈ���Ÿ� ���۽�Ű���� ��ٱ��� ���̺� ���ڵ带 �����ϴ� ������ �ۼ��ϼ���. ------------------------------------------------
create table ��ٱ���
(��ȣ int identity,
 ��ǰ char(30),
 ���� int)
-- Ȯ��
select * from ��ٱ���
-- ���ڵ� �߰�
insert ��ٱ��� values('����', 2400)
-- Ʈ���� �ۼ�
create trigger ��ٱ���insert
on ��ٱ���
after insert
as
begin
  select '�ѱݾ� :' + convert(varchar,sum(����))  from ��ٱ���
end
-- ���ڵ� �߰� �ѹ��� �� insert�� �ۼ�
insert ��ٱ��� values('����', 2600)
insert ��ٱ��� values('�κ�', 2300)
insert ��ٱ��� values('����', 3700)