/**********SQL 프로그래밍*********
 SQL 구문은 순차적으로 진행할 수 없다. == 비절차적이다.
 SQL 프로그래밍에서는 순차적으로 절차적인 흉내를 낼 수 있게 한다.
*/

/**********USE문********
 데이터베이스 영역으로 바꾸는 명령어
 USE 데이터베이스
*/

USE SampleDB
SELECT *
FROM 성적


/**********PRINT*********
 오로지 문자만 출력
 결과 탭이 없다. == 테이블에서 가져온 것이 아니다.
 메시지를 보여줄 때 사용. 
 잘못 실행되었을 때 사용한다. "잘못 실행되었습니다!"
*/

PRINT '오늘 아침 드시고 오셨어요?'

/**********GOTO*********
 사용하지는 말고 이해만 한다.
 실행 순서를 강제적으로 변경할 때 사용
*/

/**********IF*********
 참, 거짓에 따라 실행이 두 가지로 달라지는 경우
 IF (조건식)
	
 ELSE
*/

-- 종류가 코트인 제품의 평균 가격
SELECT AVG(가격)
FROM 제품
WHERE 종류='코트'

-- IF문 사용하기
IF (SELECT AVG(가격)
	FROM 제품
	WHERE 종류='코트') >= 100000
  PRINT '가격이 비싸네요.'
ELSE
  PRINT '가격이 좋은데요!!'


-- 1) IF문 예제. 제품테이블에서 제품의 종류중 ‘코트’가 있는 확인하여 
-- 코트가 있으면 '재고가 있습니다.'
-- 코트가 없으면 '재고가 없습니다.' 를 출력하시오.------------------------------------------------
IF (SELECT COUNT(종류)
	FROM 제품
	WHERE 종류='코트') > 0
  PRINT '재고가 있습니다.'
ELSE
  PRINT '재고가 없습니다'


-- 2) 변수 예제. 변수 '@avg' 를 정의하고 titles테이블의 모든 책의 책가격(price)의 평균을 구해서 평균값을 변수'@avg'로 넣어 출력하시오. ------------------------------------------------

DECLARE @a INT, @b int
-- 변수명이 먼저 나오고 자료형이 나중에 나온다. 한개 당 한개씩

SELECT @a, @b
-- 이 select 는 출력용

SELECT @a = 1, @b = 1
--이 select 에서는 여러 변수에 값 넣는 것 가능.(입력용 '='으로 구분.)

SET @a=1
-- set에서는 한 번씩만 가능하다.

USE pubs
-- 변수 예제. 변수 '@avg' 를 정의하고 
DECLARE @avg int

-- titles테이블의 모든 책의 책가격(price)의 평균을 구해서
SELECT avg(price) FROM titles

-- 평균값을 변수'@avg'로 넣어 
SET @avg = (SELECT avg(price) FROM titles)

/** 중요 **/
SELECT @avg = avg(price) FROM titles
-- 이렇게 작성하는 것이 좋다.

-- 출력하시오
SELECT @avg

-- 비절차적 언어이기에 한번에 출력해야 한다.-- 결과 -- 
DECLARE @avg int
SELECT @avg = avg(price) FROM titles
SELECT @avg


/**********CASE*********
 IF 문은 딱 두가지만 판단할 수 있다.
 CASE는 여러 경우를 판단할 수 있다.
 SELECT 교수명, 
 CASE 전공명 -- 바꿀 부분만 별도로 한 줄로 만들기
   WHEN 전공명이 이러한 값이라면 THEN 이렇게 해라
   WHEN THEN   -- 들여쓰기 해서 작성하기 한눈에 보기 편하다.
   WHEN THEN   -- 필요한 만큼 WHEN THEN 작성.
   ELSE
 END AS 열이름작성
 FROM 교수
 */

USE SampleDB

SELECT *
FROM 교수

SELECT 교수명, 
CASE 전공명 -- 바꿀 부분만 별도로 한 줄로 만들기
  WHEN '유아심리' THEN '유심'
  WHEN '알고리즘' THEN '알고'
  WHEN '아동복지' THEN '아복'
  WHEN '임상영양' THEN '임상'
  ELSE '기타전공'
END AS 줄인전공명
FROM 교수

-- 3) 예제. 단순 CASE문 다음은 테이블 '제품'에서 제품명,색상,가격을 출력하는 SQL구문이다. 실행해보시오.------------------------------------------------
-- 이 SQL구문에서 색상이 영어로 출력되는데 다음처럼  색상이 한글로 출력되도록 하시오.
--'BLACK' → '검정색’| 'YELLOW' → '노란색' | 'BROWN' → '갈색' | 'BLUE' → '파랑색' | 그 외 → '기타'

SELECT 제품명, 
CASE 색상
  WHEN 'BLACK'  THEN '검정색'
  WHEN 'YELLOW' THEN '노란색'
  WHEN 'BROWN'  THEN '갈색'
  WHEN 'BLUE'   THEN '파랑색'
  ELSE '기타'
END AS 색상한글
, 가격
FROM 제품 


/*** 체크할 값이 구간 범위에 있는 경우(단일값이 아닌)
 범위를 작성할 때는 큰 것부터.
*/

SELECT 이름, 점수
FROM 성적

SELECT 이름,
CASE -- 단일값일 때만 CASE 옆에 작성
  WHEN 점수 >= 80 THEN '높은 점수'
  WHEN 점수 >= 70 THEN '보통 점수'
  ELSE '낮은 점수'
END '점수 현황'
FROM 성적

-- 4) 범위가 있는 CASE문 예제. 테이블 '제품'에서 제품 가격이 15만원 이상이면 '고가', 10만원 이상이면 '중가', 10만원 미만이면 '저가'로 나타나도록 CASE 문을 작성하자.------------------------------------------------
SELECT *
FROM 제품

SELECT 제품명,
CASE
  WHEN 가격 >= 150000 THEN '고가'
  WHEN 가격 >= 100000 THEN '중가'
  ELSE '저가'
END AS '가격현황'
, 가격
FROM 제품

-- 5) 범위가 있는 CASE문 예제. titles테이블에서 책제목과 아래의 가격범위에 따라 ‘고가’,’보통’,’저렴’ 을 출력하시오. ------------------------------------------------
-- 20달러이상 : 고가 | 11~19달러 : 보통 | 0~10달러  : 저렴
USE pubs
SELECT TITLE,
CASE
  WHEN PRICE >= 20 THEN '고가'
  WHEN PRICE >= 11 THEN '보통'
  ELSE '저렴'
END AS '가격현황'
, PRICE
FROM TITLES


/**********WAITFOR*********
 WAITFOR TIME '24시 기준으로 시간 작성' -- 이미 지났으면 실행 안됨.
 WAITFOR DELAY '현재 시간 기준으로 몇 시간 후 실행'
*/

WAITFOR TIME '12:19:30' 
PRINT '여러분들 배고프죠?'

WAITFOR DELAY '00:00:05'
PRINT '여러분들 배고프죠?'










