/*
* SELECT 테이블 열이름(칼럼명; 보고 싶은 특정열)
* FROM 테이블명
* WHERE 검색할 행의 조건
*
* 연산자는 이해하기 쉽게 작성하는 것이 좋다.
*/

-- 책 테이블에서 요리 분야의 책만 조회
SELECT *
FROM 책
WHERE 분야 = '요리'

-- 성적 테이블에서 점수가 90점 이상인 학생들을 조회
-- <Worst CASE>
SELECT *
FROM 성적
WHERE 점수 !< 90

-- <Good CASE> 
SELECT *
FROM 성적
WHERE 점수 >= 90
-- 결과는 동일하나 !< 보다 >=를 사용하는 것이 이해하기에는 쉽다.




