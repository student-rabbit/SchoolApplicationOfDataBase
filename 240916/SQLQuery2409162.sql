--  PUBS
------------------------------------------------
/**********VIEW*********
 ���� �����ϴ� ���̺��� �ƴ϶� �ʿ�� �ϴ� Į���� ��Ƽ� �������� ���̺�
 �� ������ ��ȸ���� SELECT ������ �״�� Ȱ��. SELECT ������ �� ������ ����� ����.

 * ����ϴ� ���� *
 - ���Ǽ�
 - ����

 * �� ������ Į������ �ݵ�� �ʿ��ϴ�.

 CREATE VIEW ��� -- �ش� �̸����� �˻�����
 AS
 SELECT ���� -- ����ϰ��� �ϴ� �׸�
 FROM ���̺�
 WHERE
*/

SELECT *
FROM TITLES

CREATE VIEW V1
AS
SELECT 
       CONVERT(CHAR(30), TITLE) ��������
FROM TITLES

SELECT *
FROM V1
------------------------------------------------------------------------------------------------
USE PUBS
CREATE TABLE EMP
	(��� CHAR(9) PRIMARY KEY,
	 �̸� CHAR(30) NOT NULL,
	 �۾���ȣ INT NOT NULL,
	 �۾����õ� INT NULL)

INSERT INTO EMP
	SELECT EMP_ID, CONVERT(CHAR(30), FNAME + ' ' + LNAME), JOB_ID, JOB_LVL
	FROM EMPLOYEE

SELECT *
FROM EMP

-- ����. EMP ���̺��� ������� ���, �̸�, �۾����õ��� �̷���� �� 'EMP_LIST1'�� �����Ͻÿ�. ------------------------------------------------
CREATE VIEW EMP_LIST1
AS
SELECT
       ���,
	   �̸�,
	   �۾����õ�
FROM EMP

SELECT *
FROM EMP_LIST1

-- ����. �� 'EMP_LIST1'�� ���� ���ڵ带 �Է��ϰ� ���̺� 'EMP'�� �� 'EMP_LIST1'�� �����͸� ���غ���.------------------------------------------------
-- ���ڵ� : ���(A123456), �̸�(ȫ�浿), �۾����õ�(40)
INSERT EMP_LIST1
VALUES('A123456', 'ȫ�浿', 40)
-- ���� �߻�: �� '�۾���ȣ'�� NULL ���� ������ �� ����.

-- ����. EMP ���̺��� ������� ���, �̸�, �۾���ȣ�� �̷���� �� 'EMP_LIST2'�� �����Ͻÿ�.------------------------------------------------
CREATE VIEW EMP_LIST2
AS
SELECT
       ���,
	   �̸�,
	   �۾���ȣ
FROM EMP

SELECT *
FROM EMP_LIST2

-- ����. �� 'EMP_LIST2'�� ���� ���ڵ带 �Է��ϰ� ���̺� 'EMP'�� �� 'EMP_LIST2'�� �����͸� ���غ���.------------------------------------------------
-- ���ڵ� : ���(A123457), �̸�(�輱��), �۾���ȣ(12)
INSERT EMP_LIST2
VALUES('A123457', '�輱��', 12)

-- ����. EMP ���̺��� ������� �۾���ȣ �� �ο����� ���ؼ� �� 'EMP_LIST3'�� �����Ͻÿ�. ------------------------------------------------
CREATE VIEW EMP_LIST3
AS
SELECT
       �۾���ȣ,
	   COUNT(*) �ο���
FROM EMP
GROUP BY �۾���ȣ 

SELECT *
FROM EMP_LIST3