USE SampleDB
-- output매개변수 예제10. 테이블 ‘제품’과 ‘판매’를 기반으로 제품의 판매수량을 구하는 프로시저를 작성하시오. 이때, 입력 매개변수는 ‘제품명’으로 output매개변수는 제품명에 해당하는 ‘판매수량’을 출력하도록 하시오. (다음 sql문을 적절하게 수정하여 프로시저를 작성할 것) ------------------------------------------------
/*
예) 판매수량을 구하는 sql문: 
 SELECT 판매수량
 FROM 제품 join 판매
 on  제품.제품번호=판매.제품번호
 WHERE 제품.제품명=@제품명  
 */
SELECT * FROM 제품
SELECT * FROM 판매

-- 입력 매개변수 제품명
CREATE PROC #p2
  @제품명 VARCHAR(100)
AS
  SELECT 판매수량
  FROM 제품 JOIN 판매
  on  제품.제품번호=판매.제품번호
  WHERE 제품.제품명=@제품명
  
-- OUTPUT 매개변수 판매수량
ALTER PROC #p2
  @제품명 VARCHAR(100), @판매수량 INT OUTPUT
AS
  SELECT @판매수량 = 판매.판매수량
  FROM 제품 JOIN 판매
  on  제품.제품번호=판매.제품번호
  WHERE 제품.제품명=@제품명

-- 호출
DECLARE @판매수량 INT
EXEC #p2 '후드점퍼', @판매수량 OUTPUT
SELECT @판매수량 판매수량


/**********RETURN*********
 결과값을 호출하는 쪽에다가 준다. output과는 사용 용도가 약간 다르다.
 실행 성공/실패 여부를 확인하기 위해서 사용한다.
 *** RETURN 변수는 반드시 **INT**여야 한다.
*/

-- VER 01
CREATE PROC #p2
  @제품명 VARCHAR(100)
AS
DECLARE  @판매수량 INT -- *****
  SELECT @판매수량 =SUM(판매수량)
  FROM 제품 JOIN 판매
  on  제품.제품번호=판매.제품번호
  WHERE 제품.제품명=@제품명
RETURN @판매수량  -- *****

-- VER 02
ALTER PROC #p2
  @제품명 VARCHAR(100)
AS
DECLARE  @판매수량 INT -- *****
  SELECT 판매.판매수량
  FROM 제품 JOIN 판매
  on  제품.제품번호=판매.제품번호
  WHERE 제품.제품명=@제품명
  SET @판매수량 = @@ROWCOUNT -- 결과 레코드 갯수
RETURN @판매수량  -- *****

-- 실행
DECLARE @A INT
EXEC @A = #p2 '롱코트'
SELECT @A


-- return 값이 있는 프로시저 생성1 예제 12.  제품 테이블에서 해당 제품의 종류를 입력받아 이 제품의 개수를 결과로 반환하도록 프로시저를 생성하시오.( return 사용) ------------------------------------------------
SELECT COUNT(*) FROM 제품 WHERE 종류 ='코트'

ALTER PROC #p3
  @종류 VARCHAR(100)
AS
DECLARE @개수 INT
  SELECT @개수 = COUNT(종류) /***중요***/
  FROM 제품
  WHERE 종류 = @종류
RETURN @개수

-- 실행
DECLARE @A INT
EXEC @A = #p3 '코트'
SELECT @A


-- return 값이 있는 프로시저 생성2 예제 13. 테이블 ‘제품’에서 매개변수 값 ‘종류’의 값에 따라 제품의 가격을 10%인상하는 프로시저를 생성하시오. 이때, return 결과는 몇 개의 레코드가 인상적용 되었는지 개수를 출력하세요. 참고) select @@rowcount (sql문이 적용된 레코드갯수) ------------------------------------------------
CREATE PROC #p4
  @종류 VARCHAR(20)
AS
  SELECT 제품명, 가격, 가격 * 1.1 인상가격
  FROM 제품
  WHERE 종류 = @종류
RETURN @@ROWCOUNT

DECLARE @R INT
EXEC @R = #p4 '코트'
SELECT @R