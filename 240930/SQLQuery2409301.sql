USE SampleDB
------------------------------------------------
/**********WHILE*********
 WHILE
 BEGIN -- �߰�ȣ ����
 END
*/

-- ����. 1~30 ����ϱ� ------------------------------------------------
DECLARE @i INT = 1 -- ���� ����_�޸� ������ ������ּ���

WHILE @i <= 30
BEGIN 
	SELECT @i '@i'
	SET @i+=1 -- @i=@i+1 ������ �ǹ�
END

-- ����. 1~30 ����ϰ�, �������� ���Ѵ�. ------------------------------------------------
DECLARE @k INT = 1 -- ���� ����_�޸� ������ ������ּ���
DECLARE @j INT = 0

WHILE @k <= 30
BEGIN 
	SELECT @k '@i'
	SELECT @j += @k    -- @j = @j + @k�� ������ �ǹ�
	SET @k+=1          -- @i=@i+1 ������ �ǹ�
END
SELECT @j '���հ�'

--6) WHILE�� ����. ���̺� '��ǰ'���� ��ǰ��ȣ�� ó���� 1���� ��µǰ�, �� ��°�� 2���� ��µǰ� ����ؼ� ���� ������ ������ ��µǵ��� while ���� ����Ͽ� �� ���� �ϳ��� ��ǰ��ȣ�� ��µǵ��� �Ͻÿ�. ------------------------------------------------
SELECT * FROM ��ǰ

DECLARE @a int = 1
WHILE @a <= 12
BEGIN
	SELECT * FROM ��ǰ WHERE ��ǰ��ȣ = @a
	SET @a += 1
END


------------------------------------------------
/**********EXECUTE*********
 ��ȣ �ȿ� �ִ� ������ �����ض�.
*/

DECLARE @sql VARCHAR(100)
SET @sql = 'SELECT * FROM ��ǰ' -- @sql �ȿ� ����ִ� ���� ����
EXEC(@sql) -- @sql�ȿ� �ִ� ���ڸ� ����

EXEC('SELECT * FROM ����')

DECLARE @sql1 VARCHAR(100), @t VARCHAR(30) = ' ����' -- ���� ��ĭ �����ϼ���.
SET @sql1 = 'SELECT * FROM' -- ���̺� ���� ����
SET @sql1 += @t -- ������ ����:SELECT * FROM ����
EXEC(@sql1) -- @sql�ȿ� �ִ� ���ڸ� ����


------------------------------------------------
/********** ���� ���̺� ���� *********
 WHILE�� EXEC ���
*/


-- ����. ���̺� �� A1 ~ A20 ����� ------------------------------------------------
/* 
 CREATE TABLE a1(ID INT)
 CREATE TABLE a2(ID INT)
           ...
 CREATE TABLE a20(ID INT)
*/

DECLARE @b INT = 1
DECLARE @sql2 VARCHAR(100)
WHILE @b <=20
BEGIN
	SET @sql2 = 'CREATE TABLE a' + CONVERT(VARCHAR,@b) + '(ID INT)'
	-- EXEC(@sql2) -- ������
	SELECT @sql2 -- ��¹�
	SET @b += 1
END

-- ����. ���̺� �� A1 ~ A20 �����ϱ� ------------------------------------------------
DECLARE @c INT = 1
DECLARE @sql3 VARCHAR(100)
WHILE @c <=20
BEGIN
	SET @sql3 = 'DROP TABLE a' + CONVERT(VARCHAR,@c) + '(ID INT)'
	-- EXEC(@sql2) -- ������
	SELECT @sql3 -- ��¹�
	SET @c += 1
END


------------------------------------------------
/********** NULL IF *********
 �� �� ���� ������ �Ǻ��ϴ� �Լ�
 NULIF(ǥ����1, ǥ����2)
 ǥ����1�� ǥ����2�� ������ NULL�� ������ �ٸ��� ǥ����1�� ���´�.
*/

SELECT NULLIF(2,2) -- NULL ���
SELECT NULLIF(3,4) -- ���� �����Ƿ� ù��° �� '3' ���

DECLARE @d INT, @e INT
SELECT @d = ���� FROM ���� WHERE �̸� = '�ں���'
SELECT @e = ���� FROM ���� WHERE �̸� = '������'
SELECT NULLIF(@d, @e)

------------------------------------------------
/********** COALESCE *********
 ������ ���� üũ�� ��
 ���� �ƴ� ù��° ���� ���� �´�.
 COALESCE(a, b, c, d)
*/

SELECT COALESCE(NULL, 1000, 2000, NULL)

-- 7) COALESCE�Լ� ����. '�������'���̺��� ������� �� ����� ������ ����Ͻÿ�. �̶�, �������Ŀ��� �ñ����� �޴� ����� �ñ�* 40*52 �� ����ϰ�(�ǹ�:�ñ�*40(�ִ� �ð�)*52(��/�Ⱓ)), �������� �޴� ����� ������ �״�� ����ϰ�, �������� �޴� ����� �Ǹż��� * 3000 ���� ����� �� ------------------------------------------------
SELECT * FROM �������
SELECT ���, �̸�, COALESCE(�ñ�*40*52, ����, �Ǹż���*3000, NULL) '����� ����' FROM �������

------------------------------------------------
/********** TRY CATCH *********
 ���� ó�� ����
 ���࿡ �������� �� CATCH �� ���.
 BEGIN TRY
 	SELECT��
 END TRY
 BEGIN CATCH
 	������ ó���ϴ� SQL��
 END CATCH

*/

BEGIN TRY
	SELECT 1/0
END TRY
BEGIN CATCH
	select '0���� �����⸦ �õ��߽��ϴ�. �����Դϴ�.'
END CATCH

BEGIN TRY
	drop table baewha
END TRY
BEGIN CATCH
	select '���� ���̺��� �����Ϸ��� �߽��ϴ�.'
END CATCH

BEGIN TRY
	drop table baewha
END TRY
BEGIN CATCH
	select ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_SEVERITY(), ERROR_LINE()
END CATCH