USE SampleDB

-- ����. #�л� ���̺��� �����ϰ� �������̺��� �����͸� �����ؼ� INSERT �ϱ� ------------------------------------------------
-- �ӽ����̺� ����
CREATE TABLE  #�л� (
 ��ȣ int,
 �й�  char(9) NOT NULL,
 �̸� varchar(20) NULL,
 �� char(10) NULL,
 ����  char(2) NULL,
 ����  int )

CREATE TABLE  #��� (
 ��ȣ int,
 �й�  char(9) NOT NULL,
 �̸� varchar(20) NULL,
 ����  int ,
 ��� char(20))

SELECT * FROM #�л�
SELECT * FROM #���

INSERT #�л�
SELECT * FROM ����

SELECT * FROM #�л�

-- ����. �Ѹ� ������ �о 90�� �̻��ΰ� �Ǻ��ϰ� �׷��ٸ� #��� ���̺� ����, �������� GOOD�Է�  ------------------------------------------------
DECLARE @i INT = 1

WHILE @i <= 20
BEGIN
	IF(SELECT * FROM #�л� WHERE ��ȣ = @i) >= 90
		INSERT #���
		SELECT ��ȣ, �й�, �̸�, ����,'good' FROM #�л� WHERE ��ȣ = @i
	SET @i += 1
END

