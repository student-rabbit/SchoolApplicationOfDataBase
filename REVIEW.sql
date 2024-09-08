-- 1. ���̺� titles ���� price(����)�� ���� ���� �ƴ� ��� ���ڵ带  �˻��Ͻÿ�. 
SELECT price
FROM titles
WHERE PRICE IS NOT NULL

-- 2. ���̺� titles �� å�� ���� �������̺��̴�. 
-- type(å�� �о�)�� ����ϵ�  type�� ���� ���� �ϳ��� ��µǵ��� �Ͻÿ�(�ߺ�����).
SELECT distinct type
FROM titles

-- 3. ���̺� titles���� å�ڵ�(title_id), å����(title)�� å�о�(type)�� ����Ͻÿ�.
-- �̶�, �� �׸��� ������ ������ ���� title_id�� ��å�ڵ塯�� 
-- å����� å�о߸� �����Ͽ� ��å����(�о�)���� ��Ÿ������ �ϰ� 
-- ���� �����͵� å��������� ��ȣ�ȿ� �о߰� ��Ÿ������ ���ڰ����Ͻÿ�. 
SELECT title_id AS 'å�ڵ�', title + '(' + type + ')' AS 'å����(�о�)'
FROM TITLES

-- 4. å�Ǹ� ���̺� sales���� �Ǹŷ�(qty)�� ���� 10  �� �ش��ϴ� �Ǹŷ��ڵ带 ����Ͻÿ�.
-- ��³�����  �Ǹŷ��� ���� ���ڵ���� �˻��ǵ��� �Ͻÿ�.
SELECT top 10 qty
FROM SALES
order by qty desc

-- 5. �ռ� 4���� �������� �ӽ����̺� ������Ǹż������̶� �̸����� ���̺��� �����Ͻÿ�.
SELECT top 10 * into ����Ǹż���
FROM SALES
ORDER BY QTY DESC

SELECT *
FROM ����Ǹż���

-- 6. ���̺� sales���� ����(stor_id)�� qty �� ���� ��� �Ǹŷ��� ����Ͻÿ�.
SELECT stor_id, AVG(QTY) AS '��� �Ǹŷ�' FROM SALES
GROUP BY stor_id

-- 7. ���̺� titles ���� title_id���� 'BU1111','PS2106','TC7777','BU2075' �� ���ڵ���
-- title_id�� title�� �˻��Ͻÿ�. 
SELECT *
FROM TITLES
WHERE TITLE_ID IN('BU1111','PS2106','TC7777','BU2075')
