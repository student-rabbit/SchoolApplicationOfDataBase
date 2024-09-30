USE SampleDB
------------------------------------------------
/**********WHILE*********
 WHILE
 BEGIN -- 중괄호 역할
 END
*/

-- 예제. 1~30 출력하기 ------------------------------------------------
DECLARE @i INT = 1 -- 변수 선언_메모리 공간을 만들어주세요

WHILE @i <= 30
BEGIN 
	SELECT @i '@i'
	SET @i+=1 -- @i=@i+1 동일한 의미
END

-- 예제. 1~30 출력하고, 누적값도 구한다. ------------------------------------------------
DECLARE @k INT = 1 -- 변수 선언_메모리 공간을 만들어주세요
DECLARE @j INT = 0

WHILE @k <= 30
BEGIN 
	SELECT @k '@i'
	SELECT @j += @k    -- @j = @j + @k과 동일한 의미
	SET @k+=1          -- @i=@i+1 동일한 의미
END
SELECT @j '총합계'

--6) WHILE문 예제. 테이블 '제품'에서 제품번호가 처음엔 1번이 출력되고, 두 번째로 2번이 출력되고 계속해서 다음 순으로 끝까지 출력되도록 while 문을 사용하여 한 번에 하나의 제품번호가 출력되도록 하시오. ------------------------------------------------
SELECT * FROM 제품

DECLARE @a int = 1
WHILE @a <= 12
BEGIN
	SELECT * FROM 제품 WHERE 제품번호 = @a
	SET @a += 1
END


------------------------------------------------
/**********EXECUTE*********
 괄호 안에 있는 내용을 실행해라.
*/

DECLARE @sql VARCHAR(100)
SET @sql = 'SELECT * FROM 제품' -- @sql 안에 들어있는 것은 문자
EXEC(@sql) -- @sql안에 있는 문자를 실행

EXEC('SELECT * FROM 성적')

DECLARE @sql1 VARCHAR(100), @t VARCHAR(30) = ' 성적' -- 공백 한칸 주의하세요.
SET @sql1 = 'SELECT * FROM' -- 테이블 명은 뺐음
SET @sql1 += @t -- 구문을 결합:SELECT * FROM 성적
EXEC(@sql1) -- @sql안에 있는 문자를 실행


------------------------------------------------
/********** 동적 테이블 생성 *********
 WHILE과 EXEC 사용
*/


-- 예제. 테이블 명 A1 ~ A20 만들기 ------------------------------------------------
/* 
 CREATE TABLE a1(ID INT)
 CREATE TABLE a2(ID INT)
           ...
 CREATE TABLE a20(ID INT)
*/

DECLARE @b INT = 1
DECLARE @sql2 VARCHAR(100)
WHILE @b <=20
BEGIN
	SET @sql2 = 'CREATE TABLE a' + CONVERT(VARCHAR,@b) + '(ID INT)'
	-- EXEC(@sql2) -- 생성문
	SELECT @sql2 -- 출력문
	SET @b += 1
END

-- 예제. 테이블 명 A1 ~ A20 삭제하기 ------------------------------------------------
DECLARE @c INT = 1
DECLARE @sql3 VARCHAR(100)
WHILE @c <=20
BEGIN
	SET @sql3 = 'DROP TABLE a' + CONVERT(VARCHAR,@c) + '(ID INT)'
	-- EXEC(@sql2) -- 생성문
	SELECT @sql3 -- 출력문
	SET @c += 1
END


------------------------------------------------
/********** NULL IF *********
 두 개 값이 같은지 판별하는 함수
 NULIF(표현식1, 표현식2)
 표현식1과 표현식2가 같으면 NULL이 나오고 다르면 표현식1이 나온다.
*/

SELECT NULLIF(2,2) -- NULL 출력
SELECT NULLIF(3,4) -- 같지 않으므로 첫번째 값 '3' 출력

DECLARE @d INT, @e INT
SELECT @d = 점수 FROM 성적 WHERE 이름 = '박보검'
SELECT @e = 점수 FROM 성적 WHERE 이름 = '정혜인'
SELECT NULLIF(@d, @e)

------------------------------------------------
/********** COALESCE *********
 여러개 값을 체크할 때
 널이 아닌 첫번째 값을 갖고 온다.
 COALESCE(a, b, c, d)
*/

SELECT COALESCE(NULL, 1000, 2000, NULL)

-- 7) COALESCE함수 예제. '사원업무'테이블을 기반으로 각 사원의 연봉을 계산하시오. 이때, 연봉계산식에서 시급으로 받는 사람은 시급* 40*52 로 계산하고(의미:시급*40(주당 시간)*52(주/년간)), 연봉으로 받는 사람은 연봉값 그대로 출력하고, 수당으로 받는 사람은 판매수량 * 3000 으로 계산할 것 ------------------------------------------------
SELECT * FROM 사원업무
SELECT 사번, 이름, COALESCE(시급*40*52, 연봉, 판매수량*3000, NULL) '사원의 연봉' FROM 사원업무

------------------------------------------------
/********** TRY CATCH *********
 예외 처리 구문
 실행에 실패했을 때 CATCH 문 출력.
 BEGIN TRY
 	SELECT문
 END TRY
 BEGIN CATCH
 	오류를 처리하는 SQL문
 END CATCH

*/

BEGIN TRY
	SELECT 1/0
END TRY
BEGIN CATCH
	select '0으로 나누기를 시도했습니다. 오류입니다.'
END CATCH

BEGIN TRY
	drop table baewha
END TRY
BEGIN CATCH
	select '없는 테이블을 삭제하려고 했습니다.'
END CATCH

BEGIN TRY
	drop table baewha
END TRY
BEGIN CATCH
	select ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_SEVERITY(), ERROR_LINE()
END CATCH