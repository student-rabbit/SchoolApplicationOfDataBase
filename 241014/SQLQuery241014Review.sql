Use SampleDB
/**********���� ���ν��� ����**********/
CREATE PROC #p1
AS
SELECT �̸�, ���� FROM ����

ALTER PROC #p1
AS
SELECT �̸�, ���� FROM ����
WHERE ����>=90

-- ȣ��
EXEC #p1

/**********���� ���ν��� �Ű����� ����**********/
ALTER PROC #p1
  @���� INT   -- �Ű����� ���� ���
AS
SELECT �̸�, ���� FROM ����
WHERE ����>=@����

-- ȣ��
EXEC #p1 95


ALTER PROC #p1
  @�̸� CHAR(20)   -- �Ű����� ���� ���
AS
SELECT ���� FROM ����
WHERE �̸�>=@�̸�

-- ȣ��
EXEC #p1 '������'


ALTER PROC #p1
  @�̸� CHAR(20), @���� INT OUTPUT  -- �Ű����� ���� ���
AS
SELECT @���� = ���� FROM ���� -- ���⼭ @������ OUTPUT ����
WHERE �̸�>=@�̸�

-- ȣ��
DECLARE @���� INT
EXEC #p1 '������', @���� OUTPUT -- �������� ���Ƶ� ������ ����.
SELECT @����   -- ��� Ȯ�� ���