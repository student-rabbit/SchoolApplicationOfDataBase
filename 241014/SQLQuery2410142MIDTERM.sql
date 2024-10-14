USE SampleDB
-- 1. ���� ���̺��� ������� �ǹ������ ����� ���� ������ �ۼ��ϼ���. 
create table #pvt
(���� char(20), �б� char(20), �Ǹŷ� int)
insert into #pvt values('����','1�б�',27),('����','2�б�',46),('����','3�б�',50),('����','4�б�',34),
('������','1�б�',32),('������','2�б�',38),('������','3�б�',29),('������','4�б�',27)
select * from #pvt

SELECT *
FROM #pvt
PIVOT (SUM(�Ǹŷ�) FOR �б� IN("1�б�", "2�б�", "3�б�", "4�б�")) AS PVT 

-- 2. ����1�� �ǹ������ ���ǹ��ϼ���.
SELECT * INTO #UNPVT
FROM #pvt
PIVOT (SUM(�Ǹŷ�) FOR �б� IN("1�б�", "2�б�", "3�б�", "4�б�")) AS PVT 

SELECT ����, �б�, �Ǹŷ�
FROM #UNPVT
UNPIVOT(�Ǹŷ� FOR �б� IN("1�б�", "2�б�", "3�б�", "4�б�")) AS UNPVT 


-- 3. ��ǰ ���̺��� ������ 5����~10���������� ��ǰ�鸸 ����ϴ� �並 �����ϰ� ������ �並 ����ϴ� ������ �ۼ��ϼ���. 
SELECT * FROM ��ǰ

CREATE VIEW V1
AS
SELECT *
FROM ��ǰ
WHERE ���� BETWEEN 50000 AND 100000

-- ����
SELECT * FROM V1


-- 4-1. 1~100���� ���� �� Ȧ���� ���� ���Ͽ� ����ϼ���. (while�� ���)
DECLARE @i INT = 1, @sum INT = 0

WHILE (@i <= 100)
BEGIN 
    IF(@i%2=1)
	   SET @sum+=@i
	SET @i+=1
END
SELECT @sum '���հ�'


-- 5-1. ��ǰ���̺��� �� �� ���ڵ徿�� �о� ������ ��WHITE���� ��ǰ���� ����ϼ���. (while�� ���)
SELECT * FROM ��ǰ
DECLARE @k INT = 1

WHILE @k <= 12
BEGIN
    IF(SELECT ���� FROM ��ǰ WHERE ��ǰ��ȣ = @k)='WHITE'
      SELECT * FROM ��ǰ WHERE ��ǰ��ȣ = @k
    SET @k+=1
END
-------------------------------------------������� �������� ����. �Ʒ� ���� Ŭ��濡�� Ȯ���ϱ�
-- 6-1. ������Ȳ���̺��� ������ ������ ����ϴ� ���ν��� #p1�� ���ν��� ���๮ �ۼ�
CREATE PROC #p1
AS
SELECT �����, ����
FROM ������Ȳ

-- 6-2. ������Ȳ���̺��� ������� �Ű������� ������� ������ ����ϴ� ���ν����� ���ν��� ���๮ �ۼ�
CREATE PROC #p2
  @����� VARCHAR(100)
AS
SELECT ����
FROM ������Ȳ
WHERE ����� = @�����

EXEC #p2 '������'

-- 7. ������Ȳ���̺��� ������� �Ű������� ������� ������ output�Ű������� �޾� ���� ���ν�����. ���ν��� ���๮ �ۼ�
CREATE PROC #p3
  @����� VARCHAR(100), @���� VARCHAR(100) OUTPUT
AS
SELECT @����=����
FROM ������Ȳ
WHERE ����� = @�����

DECLARE @���� VARCHAR(100)
EXEC #p3 '������', @���� OUTPUT
SELECT @����

-- 8. ������Ȳ���̺��� �������� �Ű������� �Ͽ� �ش� ������ �ϴ� ����� �ο����� return ������ ��ȯ�ϴ� ���ν����� ���ν��� ���๮�� �ۼ��ϼ���.
CREATE PROC #p3
  @����� VARCHAR(100), @���� VARCHAR(100) OUTPUT
AS
SELECT @����=����
FROM ������Ȳ
WHERE ����� = @�����

DECLARE @���� VARCHAR(100)
EXEC #p3 '������', @���� OUTPUT
SELECT @����