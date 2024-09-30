USE SampleDB

-- 예제. #학생 테이블을 생성하고 성적테이블에서 데이터를 복사해서 INSERT 하기 ------------------------------------------------
-- 임시테이블 실행
CREATE TABLE  #학생 (
 번호 int,
 학번  char(9) NOT NULL,
 이름 varchar(20) NULL,
 반 char(10) NULL,
 성별  char(2) NULL,
 점수  int )

CREATE TABLE  #결과 (
 번호 int,
 학번  char(9) NOT NULL,
 이름 varchar(20) NULL,
 점수  int ,
 비고 char(20))

SELECT * FROM #학생
SELECT * FROM #결과

INSERT #학생
SELECT * FROM 성적

SELECT * FROM #학생

-- 예제. 한명씩 점수를 읽어서 90점 이상인가 판별하고 그렇다면 #결과 테이블에 삽입, 비고란에는 GOOD입력  ------------------------------------------------
DECLARE @i INT = 1

WHILE @i <= 20
BEGIN
	IF(SELECT * FROM #학생 WHERE 번호 = @i) >= 90
		INSERT #결과
		SELECT 번호, 학번, 이름, 점수,'good' FROM #학생 WHERE 번호 = @i
	SET @i += 1
END

