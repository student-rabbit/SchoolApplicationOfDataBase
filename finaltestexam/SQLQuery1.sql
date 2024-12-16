CREATE TRIGGER SCORE
ON 성적1
AFTER INSERT
BEGIN
 UPDATE 성적1
 SET 총점 = (SELECT 영어 + 수학 + 국어 FROM INSERTED) , 평균 (SELECT (영어 + 수학 + 국어) / 3.0 FROM INSERTED)
 WHERE 학번 = (SELECT 학번 FROM INSERTED)
 SELECT '총금액' + CONVERT(VARCHAR, SUM(가격))
END

CREATE FUNCTION FN_책가격(@책제목 VARCHAR(30))
RETURNS INT
AS
BEGIN
RETURN(SELECT 가격 책의가격 FROM 책 WHERE 책제목 = @책제목)
END

SELECT DBO.FN_책가격('파스타요리') 책의가격

CREATE FUNCTION FN_책LIST1(@가격1 INT, @가격2 INT)
RETURNS TABLE
AS
  RETURN(SELECT 책제목, 분야, 가격 FROM 책 WHERE 가격 BETWEEN @가격1 AND @가격2)

SELECT * FROM DBO.FN_책LIST1(7000,10000)

CREATE FUNCTION FN_책LIST2(@가격1 INT, @가격2 INT)
RETURNS @책 TABLE
(책제목 VARCHAR(40), 분야 VARCHAR(40), 가격 INT)
AS
BEGIN
 INSERT INTO @책
 SELECT 책제목, 분야, 가격 FROM 책 WHERE 가격 BETWEEN @가격1 AND @가격2
 RETURN
END

WITH SCHEMABINDING
WITH ENCRYPTION

DECLARE S_TEST CURSOR FOR
SELECT * FROM 장바구니 WHERE 구매량 > 5 OR 구매총액 > 100000

OPEN S_TEST

DECLARE @구매번호 INT, @구매제품 INT, @구매량 INT, @구매총액 INT

FETCH NEXT FROM S_TEST
INTO @구매번호, @구매제품, @구매량, @구매총액

WHILE @@FETCH_STATUS = 0
BEGIN
 IF(@구매총액 >= 10000)
  INSERT INTO #구매총평 VALUES(@구매번호, @구매제품, @구매량, @구매총액*0.9), '구매랙 우수(할인적용)')
 IF(@구매량 >= 5)
  INSERT INTO #구매총평 VALUES(@구매번호, @구매제품, @구매량, @구매총액), '구매량 우수')
  FETCH NEXT FROM S_TEST INTO @구매번호, @구매제품, @구매량, @구매총액
END

CLOSE S_TEST

DEALLOCATE S_TEST

SELECT * FROM #구매총평