-- SampleDB
------------------------------------------------
/**********VIEW*********
 ��ü ���̺��� �� �������� �ʰ� �Ϻθ� �����ִ� ���
 CREATE VIEW V1
 AS
 SELECT �й�,
		�̸�
 FROM ����
*/

CREATE VIEW V1
AS
SELECT �й�,
		�̸�
FROM ����

ALTER VIEW V1
AS
SELECT �й�,
		�̸�,
		����
FROM ���� 
WHERE ���� >= 80

SELECT *
FROM V1

ALTER VIEW V1
AS
SELECT �й�,
		�̸�,
		����
FROM ����
WHERE ���� >= 80
WITH CHECK OPTION  -- ������ ������ �����϶�
