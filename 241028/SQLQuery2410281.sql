USE SampleDB
/**********Ʈ����(Trigger)*********
 CREATE TRIGGER Ʈ���Ÿ�
 ON ���̺��
 AFTER ������ �ϸ�(INSERT OR UPDATE OR DELETE �� �ϳ� �ۼ�)
 AS
 BEGIN
  ����� �߻��Ѵ�. ������ �ǰ� �Ѵ�.
 END
*/


-- ����. ���� ��� ���̺� ���ڵ带 �Է��ϸ� '���Ի���� �Ի��ϸ� ȯ���մϴ�.'��� ------------------------------------------------
-- ���̺� ����
CREATE TABLE ���Ի��
(��� INT PRIMARY KEY,
 �̸� CHAR(20))

SELECT * FROM ���Ի��

-- Ʈ���� ����(INSERT TRIGGER)
CREATE TRIGGER ���INSERT
ON ���Ի��
AFTER INSERT -- INSERT,DELETE,UPDATE
AS
BEGIN
  PRINT '�Ի縦 ȯ���մϴ�!~~~'
END

-- Ʈ���� �߻� �۾�
INSERT INTO ���Ի�� VALUES(1, 'ȫ�浿')
INSERT INTO ���Ի�� VALUES(2, '�輱��')

SELECT * FROM ���Ի��

-- �ý��ۿ��� ������ ���ڵ� �Ѱ��� ����Ǿ� �ִ�. ���� �ֱ� ���ڵ常
-- �޸𸮿� ����Ǿ� �ִ� ���ڵ� �ҷ�����  INSERTED -> ���ڵ�� �Ѱ��̱⿡ WHERE���� ����ϸ� �� �ȴ�. Ʈ���� �۾� �ÿ��� �����ȴ�.
ALTER TRIGGER ���INSERT
ON ���Ի��
AFTER INSERT -- INSERT,DELETE,UPDATE
AS
BEGIN
  SELECT * FROM inserted -- ������ INSERT �� 1�� ���ڵ�
END

-- ���ڵ� �߰� => ������ ���ڵ常 ���
INSERT INTO ���Ի�� VALUES(3, '������')

SELECT * FROM ���Ի��

/*!!!! �߿� !!!!*/
ALTER TRIGGER ���INSERT
ON ���Ի��
AFTER INSERT -- INSERT,DELETE,UPDATE
AS
BEGIN
  SELECT �̸� + '�� ȯ���մϴ�.' FROM inserted -- ������ INSERT �� 1�� ���ڵ�
END

-- ���ڵ� �߰� => �̵��� �� ȯ���մϴ�. ���
INSERT INTO ���Ի�� VALUES(4, '�̵���')


/*************************************************/
CREATE TABLE ����1
(
�й� CHAR(5) NOT NULL,
���� INT NOT NULL,
���� INT NOT NULL,
���� INT NOT NULL,
���� INT DEFAULT 0,
��� INT DEFAULT 0
)

-- ����. ���̺��� ����� �й�, ����, ����, ���� ���� �Է��ϸ� �ڵ������� ������ ����� �Էµǵ��� Ʈ���� ���� ------------------------------------------------
CREATE TRIGGER ����1INSERT
ON ����1
AFTER INSERT
AS
BEGIN
  UPDATE ����1 SET ���� = (SELECT ���� + ���� + ���� FROM inserted), ��� = ((SELECT ���� + ���� + ���� FROM inserted)/3)
  -- WHERE ������ ��� �л� ����
  WHERE �й� = (SELECT �й� FROM inserted)
END

INSERT INTO ����1 VALUES('20231',88,90,78,0,0) 
INSERT INTO ����1 VALUES('20232',35,20,68,0,0) 
-- ù�� ° �ȳ��� INSERT �ι� ° �ȳ��� TRIGGER

-- ������ ������ �־��� �� ������ ��� �Է�
SELECT * FROM ����1


/*************************************************/
-- ����. �� ���̺� ���ο� ȸ���� ���ԵǸ� �����̺��� �������� �Ӽ��� ���� �������� ���̺� ȸ�������� ���ԵǴ� Ʈ���� ��������_INSERT�� ���� ------------------------------------------------

SELECT * FROM ��
SELECT * FROM ��������

CREATE TRIGGER ��������_INSERT
ON ��
AFTER INSERT
AS
BEGIN
  IF (SELECT �������� FROM INSERTED) = 1
    INSERT INTO �������� SELECT ��id, ����, ����ó FROM INSERTED
END

INSERT �� VALUES(344,'�ڿ���','01-446-4573',1020,1)
INSERT �� VALUES(443,'�ڼ�','02-346-4573',1020,0)
  
/**********INSERT ���� !! �߿� !! *********
 1. INSERT INTO ~~ VALUES()-- ���� ���� ä��� ����
 2. INSERT INTO ~~ SELECT ~~ FROM ~~ -- �ٸ� ���̺��� ���� �����ؼ� ä��� ��� !!!!!
 */


/*************************************************/
select * from �԰�
select * from ��ǰ

-- ����. �԰� ���̺� �԰� ���ڵ尡 ���Եȴٸ� ��ǰ ���̺� ��� ������ �����ض�. ------------------------------------------------
CREATE TRIGGER ��ǰ_INSERT
ON �԰�
AFTER INSERT
AS
BEGIN
    update ��ǰ set ������ = ������ + (SELECT �԰���� FROM INSERTED) where ��ǰ�ڵ� = (SELECT ��ǰ�ڵ� FROM INSERTED)
END

INSERT �԰� VALUES( 'P01', '202401', 5)
INSERT �԰� VALUES( 'P01', '202441', 8)