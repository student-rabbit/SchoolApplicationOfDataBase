USE SampleDB
/**********트리거(Trigger)*********
 CREATE TRIGGER 트리거명
 ON 테이블명
 AFTER 무엇을 하면(INSERT OR UPDATE OR DELETE 중 하나 작성)
 AS
 BEGIN
  어떤일이 발생한다. 저절로 되게 한다.
 END
*/


-- 예제. 신입 사원 테이블에 레코드를 입력하면 '신입사원이 입사하면 환영합니다.'출력 ------------------------------------------------
-- 테이블 생성
CREATE TABLE 신입사원
(사번 INT PRIMARY KEY,
 이름 CHAR(20))

SELECT * FROM 신입사원

-- 트리거 생성(INSERT TRIGGER)
CREATE TRIGGER 사원INSERT
ON 신입사원
AFTER INSERT -- INSERT,DELETE,UPDATE
AS
BEGIN
  PRINT '입사를 환영합니다!~~~'
END

-- 트리거 발생 작업
INSERT INTO 신입사원 VALUES(1, '홍길동')
INSERT INTO 신입사원 VALUES(2, '김선달')

SELECT * FROM 신입사원

-- 시스템에는 마지막 레코드 한개만 저장되어 있다. 가장 최근 레코드만
-- 메모리에 저장되어 있는 레코드 불러보기  INSERTED -> 레코드는 한개이기에 WHERE절을 사용하면 안 된다. 트리거 작업 시에만 생성된다.
ALTER TRIGGER 사원INSERT
ON 신입사원
AFTER INSERT -- INSERT,DELETE,UPDATE
AS
BEGIN
  SELECT * FROM inserted -- 마지막 INSERT 된 1개 레코드
END

-- 레코드 추가 => 성춘향 레코드만 출력
INSERT INTO 신입사원 VALUES(3, '성춘향')

SELECT * FROM 신입사원

/*!!!! 중요 !!!!*/
ALTER TRIGGER 사원INSERT
ON 신입사원
AFTER INSERT -- INSERT,DELETE,UPDATE
AS
BEGIN
  SELECT 이름 + '님 환영합니다.' FROM inserted -- 마지막 INSERT 된 1개 레코드
END

-- 레코드 추가 => 이도령 님 환영합니다. 출력
INSERT INTO 신입사원 VALUES(4, '이도령')


/*************************************************/
CREATE TABLE 성적1
(
학번 CHAR(5) NOT NULL,
영어 INT NOT NULL,
수학 INT NOT NULL,
국어 INT NOT NULL,
총점 INT DEFAULT 0,
평균 INT DEFAULT 0
)

-- 예제. 테이블을 만들고 학번, 국어, 영어, 수학 값을 입력하면 자동적으로 총점과 평균이 입력되도록 트리거 생성 ------------------------------------------------
CREATE TRIGGER 성적1INSERT
ON 성적1
AFTER INSERT
AS
BEGIN
  UPDATE 성적1 SET 총점 = (SELECT 영어 + 수학 + 국어 FROM inserted), 평균 = ((SELECT 영어 + 수학 + 국어 FROM inserted)/3)
  -- WHERE 없으면 모든 학생 수정
  WHERE 학번 = (SELECT 학번 FROM inserted)
END

INSERT INTO 성적1 VALUES('20231',88,90,78,0,0) 
INSERT INTO 성적1 VALUES('20232',35,20,68,0,0) 
-- 첫번 째 안내는 INSERT 두번 째 안내는 TRIGGER

-- 국영수 점수만 넣었는 데 총점과 평균 입력
SELECT * FROM 성적1


/*************************************************/
-- 예제. 고객 테이블에 새로운 회원이 가입되면 고객테이블의 뉴스레터 속성에 따라 뉴스레터 테이블에 회원내역이 삽입되는 트리거 뉴스레터_INSERT를 생성 ------------------------------------------------

SELECT * FROM 고객
SELECT * FROM 뉴스레터

CREATE TRIGGER 뉴스레터_INSERT
ON 고객
AFTER INSERT
AS
BEGIN
  IF (SELECT 뉴스레터 FROM INSERTED) = 1
    INSERT INTO 뉴스레터 SELECT 고객id, 고객명, 연락처 FROM INSERTED
END

INSERT 고객 VALUES(344,'박영석','01-446-4573',1020,1)
INSERT 고객 VALUES(443,'박석','02-346-4573',1020,0)
  
/**********INSERT 구문 !! 중요 !! *********
 1. INSERT INTO ~~ VALUES()-- 직접 값을 채우는 구문
 2. INSERT INTO ~~ SELECT ~~ FROM ~~ -- 다른 테이블에서 값을 복사해서 채우는 방법 !!!!!
 */


/*************************************************/
select * from 입고
select * from 상품

-- 예제. 입고 테이블에 입고 레코드가 삽입된다면 상품 테이블에 재고 수량을 수정해라. ------------------------------------------------
CREATE TRIGGER 상품_INSERT
ON 입고
AFTER INSERT
AS
BEGIN
    update 상품 set 재고수량 = 재고수량 + (SELECT 입고수량 FROM INSERTED) where 상품코드 = (SELECT 상품코드 FROM INSERTED)
END

INSERT 입고 VALUES( 'P01', '202401', 5)
INSERT 입고 VALUES( 'P01', '202441', 8)