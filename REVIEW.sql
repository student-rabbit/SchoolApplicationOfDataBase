-- 1. 테이블 titles 에서 price(가격)의 값이 널이 아닌 모든 레코드를  검색하시오. 
SELECT price
FROM titles
WHERE PRICE IS NOT NULL

-- 2. 테이블 titles 는 책에 관한 정보테이블이다. 
-- type(책의 분야)을 출력하되  type의 같은 값은 하나만 출력되도록 하시오(중복제거).
SELECT distinct type
FROM titles

-- 3. 테이블 titles에서 책코드(title_id), 책제목(title)과 책분야(type)를 출력하시오.
-- 이때, 각 항목의 제목은 다음과 같이 title_id는 ‘책코드’로 
-- 책제목과 책분야를 결합하여 ‘책제목(분야)’로 나타나도록 하고 
-- 관련 데이터도 책제목다음에 괄호안에 분야가 나타나도록 문자결합하시오. 
SELECT title_id AS '책코드', title + '(' + type + ')' AS '책제목(분야)'
FROM TITLES

-- 4. 책판매 테이블 sales에서 판매량(qty)이 상위 10  에 해당하는 판매레코드를 출력하시오.
-- 출력내용은  판매량이 같은 레코드까지 검색되도록 하시오.
SELECT top 10 qty
FROM SALES
order by qty desc

-- 5. 앞서 4번의 실행결과를 임시테이블 ‘우수판매서적’이란 이름으로 테이블을 생성하시오.
SELECT top 10 * into 우수판매서적
FROM SALES
ORDER BY QTY DESC

SELECT *
FROM 우수판매서적

-- 6. 테이블 sales에서 서점(stor_id)별 qty 에 대한 평균 판매량을 출력하시오.
SELECT stor_id, AVG(QTY) AS '평균 판매량' FROM SALES
GROUP BY stor_id

-- 7. 테이블 titles 에서 title_id값이 'BU1111','PS2106','TC7777','BU2075' 인 레코드의
-- title_id와 title을 검색하시오. 
SELECT *
FROM TITLES
WHERE TITLE_ID IN('BU1111','PS2106','TC7777','BU2075')
