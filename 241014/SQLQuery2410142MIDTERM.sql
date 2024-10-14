USE SampleDB
-- 1. 다음 테이블을 기반으로 피벗결과를 만들기 위한 구문을 작성하세요. 
create table #pvt
(차종 char(20), 분기 char(20), 판매량 int)
insert into #pvt values('경차','1분기',27),('경차','2분기',46),('경차','3분기',50),('경차','4분기',34),
('중형차','1분기',32),('중형차','2분기',38),('중형차','3분기',29),('중형차','4분기',27)
select * from #pvt

SELECT *
FROM #pvt
PIVOT (SUM(판매량) FOR 분기 IN("1분기", "2분기", "3분기", "4분기")) AS PVT 

-- 2. 문제1의 피벗결과를 언피벗하세요.
SELECT * INTO #UNPVT
FROM #pvt
PIVOT (SUM(판매량) FOR 분기 IN("1분기", "2분기", "3분기", "4분기")) AS PVT 

SELECT 차종, 분기, 판매량
FROM #UNPVT
UNPIVOT(판매량 FOR 분기 IN("1분기", "2분기", "3분기", "4분기")) AS UNPVT 


-- 3. 제품 테이블에서 가격이 5만원~10만원사이의 제품들만 출력하는 뷰를 생성하고 생성된 뷰를 출력하는 구문을 작성하세요. 
SELECT * FROM 제품

CREATE VIEW V1
AS
SELECT *
FROM 제품
WHERE 가격 BETWEEN 50000 AND 100000

-- 실행
SELECT * FROM V1


-- 4-1. 1~100까지 정수 중 홀수의 합을 구하여 출력하세요. (while문 사용)
DECLARE @i INT = 1, @sum INT = 0

WHILE (@i <= 100)
BEGIN 
    IF(@i%2=1)
	   SET @sum+=@i
	SET @i+=1
END
SELECT @sum '총합계'


-- 5-1. 제품테이블에서 한 개 레코드씩을 읽어 색상이 ‘WHITE’인 제품들을 출력하세요. (while문 사용)
SELECT * FROM 제품
DECLARE @k INT = 1

WHILE @k <= 12
BEGIN
    IF(SELECT 색상 FROM 제품 WHERE 제품번호 = @k)='WHITE'
      SELECT * FROM 제품 WHERE 제품번호 = @k
    SET @k+=1
END
-------------------------------------------여기까지 수업에서 진행. 아래 내용 클라썸에서 확인하기
-- 6-1. 팀장현황테이블에서 사원명과 업무를 출력하는 프로시저 #p1과 프로시저 실행문 작성
CREATE PROC #p1
AS
SELECT 사원명, 업무
FROM 팀장현황

-- 6-2. 팀장현황테이블에서 사원명을 매개변수로 사원명의 업무를 출력하는 프로시저와 프로시저 실행문 작성
CREATE PROC #p2
  @사원명 VARCHAR(100)
AS
SELECT 업무
FROM 팀장현황
WHERE 사원명 = @사원명

EXEC #p2 '마동석'

-- 7. 팀장현황테이블에서 사원명을 매개변수로 사원명의 업무를 output매개변수로 받아 내는 프로시저와. 프로시저 실행문 작성
CREATE PROC #p3
  @사원명 VARCHAR(100), @업무 VARCHAR(100) OUTPUT
AS
SELECT @업무=업무
FROM 팀장현황
WHERE 사원명 = @사원명

DECLARE @업무 VARCHAR(100)
EXEC #p3 '마동석', @업무 OUTPUT
SELECT @업무

-- 8. 팀장현황테이블에서 업무명을 매개변수로 하여 해당 업무를 하는 사원의 인원수를 return 값으로 반환하는 프로시저와 프로시저 실행문도 작성하세요.
CREATE PROC #p3
  @사원명 VARCHAR(100), @업무 VARCHAR(100) OUTPUT
AS
SELECT @업무=업무
FROM 팀장현황
WHERE 사원명 = @사원명

DECLARE @업무 VARCHAR(100)
EXEC #p3 '마동석', @업무 OUTPUT
SELECT @업무