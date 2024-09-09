/* 
***** PARTITION BY *****
기존의 순위 함수와 같이 사용하나 ORDER BY 앞에 사용한다.
그룹을 만들어서 그 그룹 내에서 순위를 매긴다.
*/

SELECT PUB_ID, TYPE, PRICE
FROM TITLES

-- 같은 PUB_ID(PUB_ID 그룹)에서 낮은 거부터 순위를 매긴다.
SELECT 
	DENSE_RANK() OVER (PARTITION BY PUB_ID ORDER BY PRICE) AS 순위,
	PUB_ID, TYPE, PRICE
FROM TITLES


-- 연습 문제 9번 -----------------------------
SELECT 
	TITLE_ID, PUBDATE,
	RANK() OVER (ORDER BY PUBDATE) AS RANK
FROM TITLES


-- 연습 문제 10번 -----------------------------
SELECT 
	TITLE_ID, QTY,
	DENSE_RANK() OVER (ORDER BY QTY DESC) AS 순위
FROM SALES


-- 연습 문제 11번 -----------------------------
SELECT 
	ROW_NUMBER() OVER (PARTITION BY STOR_ID ORDER BY QTY),
	STOR_ID, QTY
FROM SALES