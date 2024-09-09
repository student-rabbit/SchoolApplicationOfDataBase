/* 
***** PARTITION BY *****
������ ���� �Լ��� ���� ����ϳ� ORDER BY �տ� ����Ѵ�.
�׷��� ���� �� �׷� ������ ������ �ű��.
*/

SELECT PUB_ID, TYPE, PRICE
FROM TITLES

-- ���� PUB_ID(PUB_ID �׷�)���� ���� �ź��� ������ �ű��.
SELECT 
	DENSE_RANK() OVER (PARTITION BY PUB_ID ORDER BY PRICE) AS ����,
	PUB_ID, TYPE, PRICE
FROM TITLES


-- ���� ���� 9�� -----------------------------
SELECT 
	TITLE_ID, PUBDATE,
	RANK() OVER (ORDER BY PUBDATE) AS RANK
FROM TITLES


-- ���� ���� 10�� -----------------------------
SELECT 
	TITLE_ID, QTY,
	DENSE_RANK() OVER (ORDER BY QTY DESC) AS ����
FROM SALES


-- ���� ���� 11�� -----------------------------
SELECT 
	ROW_NUMBER() OVER (PARTITION BY STOR_ID ORDER BY QTY),
	STOR_ID, QTY
FROM SALES