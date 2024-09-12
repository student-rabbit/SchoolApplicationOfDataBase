/*
* SELECT 테이블 열이름(칼럼명; 보고 싶은 특정열)
* FROM 테이블명
* ORDER BY 정렬할 기준 열 ASC(기본값)/DESC
*
* 오름차순(아래로 갈수록 커진다.) = ASC(ASCending)
* 내림차순(아래로 갈수록 작아진다.)DESC(DESCending)
*/


-- 데이터 정렬하기
-- 점수에 따라 오름차순 정렬
SELECT
       학번,
	   이름,
	   점수
FROM 성적
ORDER BY 점수

-- 점수에 따라 내림차순 정렬
SELECT
       학번,
	   이름,
	   점수
FROM 성적
ORDER BY 점수 DESC

-- 아래 결과들의 차이점 확인해보기
SELECT
       학번,
	   이름, 
	   반,
	   점수
FROM 성적
ORDER BY 반 DESC, 점수 ASC
-- 반은 내림차순, 점수는 오름차순 정렬

SELECT
       학번,
	   이름, 
	   반,
	   점수
FROM 성적
ORDER BY 점수, 반 DESC
-- 점수는 오름차순(ASC) 생략, 반은 내림차순


/*****************
* 중복 데이터 제거하기
* DISTINCT
*****************/
SELECT 
       DISTINCT 종류
FROM 제품


/*****************
* 상위 n 개만 출력하기
* TOP n
*****************/
-- 성적 테이블의 데이터 중 상위 5명의 학생들만 조회하기
-- 앞에서 5개 행의 값만 결과로 출력
SELECT
       TOP 5 *
FROM 성적

-- 점수로 1등-5등 출력하기 - 내림차순 정렬
SELECT 
       TOP 5 이름,
	   점수
FROM 성적
ORDER BY 점수 DESC
-- 같은 순위임에도 불구하고 점수가 같은 나머지 학생 출력되지 않았다.

/*****************
* 같은 점수까지 포함해서 출력
* WITH TIES
*****************/
SELECT
       TOP 5 WITH TIES 이름,
	   점수
FROM 성적
ORDER BY 점수 DESC

/*****************
* 비율에 해당하는 레코드 가져오기
* 앞에서 25퍼센트의 레코드 출력
* 상위 몇 퍼센트를 원한다면 ORDER BY 사용하기
*****************/
SELECT
       TOP 25 PERCENT 이름,
	   점수
FROM 성적