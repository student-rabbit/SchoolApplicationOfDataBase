CREATE TRIGGER SCORE
ON ����1
AFTER INSERT
BEGIN
 UPDATE ����1
 SET ���� = (SELECT ���� + ���� + ���� FROM INSERTED) , ��� (SELECT (���� + ���� + ����) / 3.0 FROM INSERTED)
 WHERE �й� = (SELECT �й� FROM INSERTED)
 SELECT '�ѱݾ�' + CONVERT(VARCHAR, SUM(����))
END

CREATE FUNCTION FN_å����(@å���� VARCHAR(30))
RETURNS INT
AS
BEGIN
RETURN(SELECT ���� å�ǰ��� FROM å WHERE å���� = @å����)
END

SELECT DBO.FN_å����('�Ľ�Ÿ�丮') å�ǰ���

CREATE FUNCTION FN_åLIST1(@����1 INT, @����2 INT)
RETURNS TABLE
AS
  RETURN(SELECT å����, �о�, ���� FROM å WHERE ���� BETWEEN @����1 AND @����2)

SELECT * FROM DBO.FN_åLIST1(7000,10000)

CREATE FUNCTION FN_åLIST2(@����1 INT, @����2 INT)
RETURNS @å TABLE
(å���� VARCHAR(40), �о� VARCHAR(40), ���� INT)
AS
BEGIN
 INSERT INTO @å
 SELECT å����, �о�, ���� FROM å WHERE ���� BETWEEN @����1 AND @����2
 RETURN
END

WITH SCHEMABINDING
WITH ENCRYPTION

DECLARE S_TEST CURSOR FOR
SELECT * FROM ��ٱ��� WHERE ���ŷ� > 5 OR �����Ѿ� > 100000

OPEN S_TEST

DECLARE @���Ź�ȣ INT, @������ǰ INT, @���ŷ� INT, @�����Ѿ� INT

FETCH NEXT FROM S_TEST
INTO @���Ź�ȣ, @������ǰ, @���ŷ�, @�����Ѿ�

WHILE @@FETCH_STATUS = 0
BEGIN
 IF(@�����Ѿ� >= 10000)
  INSERT INTO #�������� VALUES(@���Ź�ȣ, @������ǰ, @���ŷ�, @�����Ѿ�*0.9), '���ŷ� ���(��������)')
 IF(@���ŷ� >= 5)
  INSERT INTO #�������� VALUES(@���Ź�ȣ, @������ǰ, @���ŷ�, @�����Ѿ�), '���ŷ� ���')
  FETCH NEXT FROM S_TEST INTO @���Ź�ȣ, @������ǰ, @���ŷ�, @�����Ѿ�
END

CLOSE S_TEST

DEALLOCATE S_TEST

SELECT * FROM #��������