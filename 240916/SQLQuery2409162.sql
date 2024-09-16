--  PUBS
------------------------------------------------
/**********VIEW*********
 실제 존재하는 테이블이 아니라 필요로 하는 칼럼만 모아서 가상으로 테이블
 뷰 구문은 조회문인 SELECT 구문을 그대로 활용. SELECT 구문만 잘 익히면 어렵지 않음.

 * 사용하는 목적 *
 - 편의성
 - 보안

 * 뷰 생성시 칼럼명이 반드시 필요하다.

 CREATE VIEW 뷰명 -- 해당 이름으로 검색가능
 AS
 SELECT 구문 -- 출력하고자 하는 항목
 FROM 테이블
 WHERE
*/

SELECT *
FROM TITLES

CREATE VIEW V1
AS
SELECT 
       CONVERT(CHAR(30), TITLE) 줄인제목
FROM TITLES

SELECT *
FROM V1
------------------------------------------------------------------------------------------------
USE PUBS
CREATE TABLE EMP
	(사번 CHAR(9) PRIMARY KEY,
	 이름 CHAR(30) NOT NULL,
	 작업번호 INT NOT NULL,
	 작업숙련도 INT NULL)

INSERT INTO EMP
	SELECT EMP_ID, CONVERT(CHAR(30), FNAME + ' ' + LNAME), JOB_ID, JOB_LVL
	FROM EMPLOYEE

SELECT *
FROM EMP

-- 예시. EMP 테이블을 기반으로 사번, 이름, 작업숙련도로 이루어진 뷰 'EMP_LIST1'을 생성하시오. ------------------------------------------------
CREATE VIEW EMP_LIST1
AS
SELECT
       사번,
	   이름,
	   작업숙련도
FROM EMP

SELECT *
FROM EMP_LIST1

-- 예시. 뷰 'EMP_LIST1'에 다음 레코드를 입력하고 테이블 'EMP'와 뷰 'EMP_LIST1'의 데이터를 비교해보자.------------------------------------------------
-- 레코드 : 사번(A123456), 이름(홍길동), 작업숙련도(40)
INSERT EMP_LIST1
VALUES('A123456', '홍길동', 40)
-- 오류 발생: 열 '작업번호'에 NULL 값을 삽입할 수 없다.

-- 예시. EMP 테이블을 기반으로 사번, 이름, 작업번호로 이루어진 뷰 'EMP_LIST2'를 생성하시오.------------------------------------------------
CREATE VIEW EMP_LIST2
AS
SELECT
       사번,
	   이름,
	   작업번호
FROM EMP

SELECT *
FROM EMP_LIST2

-- 예시. 뷰 'EMP_LIST2'에 다음 레코드를 입력하고 테이블 'EMP'와 뷰 'EMP_LIST2'의 데이터를 비교해보자.------------------------------------------------
-- 레코드 : 사번(A123457), 이름(김선달), 작업번호(12)
INSERT EMP_LIST2
VALUES('A123457', '김선달', 12)

-- 예시. EMP 테이블을 기반으로 작업번호 별 인원수를 구해서 뷰 'EMP_LIST3'을 생성하시오. ------------------------------------------------
CREATE VIEW EMP_LIST3
AS
SELECT
       작업번호,
	   COUNT(*) 인원수
FROM EMP
GROUP BY 작업번호 

SELECT *
FROM EMP_LIST3