Use SampleDB
/**********저장 프로시저 생성**********/
CREATE PROC #p1
AS
SELECT 이름, 점수 FROM 성적

ALTER PROC #p1
AS
SELECT 이름, 점수 FROM 성적
WHERE 점수>=90

-- 호출
EXEC #p1

/**********저장 프로시저 매개변수 생성**********/
ALTER PROC #p1
  @점수 INT   -- 매개변수 선언 방법
AS
SELECT 이름, 점수 FROM 성적
WHERE 점수>=@점수

-- 호출
EXEC #p1 95


ALTER PROC #p1
  @이름 CHAR(20)   -- 매개변수 선언 방법
AS
SELECT 점수 FROM 성적
WHERE 이름>=@이름

-- 호출
EXEC #p1 '송혜교'


ALTER PROC #p1
  @이름 CHAR(20), @점수 INT OUTPUT  -- 매개변수 선언 방법
AS
SELECT @점수 = 점수 FROM 성적 -- 여기서 @점수는 OUTPUT 변수
WHERE 이름>=@이름

-- 호출
DECLARE @점수 INT
EXEC #p1 '송혜교', @점수 OUTPUT -- 변수명은 같아도 문제가 없다.
SELECT @점수   -- 결과 확인 방법