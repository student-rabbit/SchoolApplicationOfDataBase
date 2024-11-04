USE SampleDB
/**********delete*********
e.g. 신입사원이 퇴사를 했다.
임시테이블: deleted
**********트리거(Trigger)*********
 CREATE TRIGGER 트리거명
 ON 작동한/발생하는 테이블명
 AFTER 무엇을 하면(INSERT OR UPDATE OR DELETE 중 하나 작성)
 AS
 BEGIN
  어떤일이 발생한다. 저절로 되게 한다.
  수정하게 될 테이블
 END
*/
create table 신입사원
(사번 int,
 이름 char(20))

select * from 신입사원

CREATE trigger 사원msg  
on 신입사원  
after insert  
as  
begin  
  select 이름+ '님 환영합니다.!!~~~~' from inserted  
end

insert 신입사원 values(1, '홍길동')
insert 신입사원 values(2, '홍길순')
insert 신입사원 values(3, '김철동')
insert 신입사원 values(4, '김철수')

create trigger 사원delete
on 신입사원
after delete
as
begin
  select 이름 + '님 퇴사하셨군요.. 아쉽네요' from deleted
end

delete from 신입사원 where 사번 = 4
/*************************************************/
-- 예제. 고객 테이블에서 회원이 탈퇴하면 뉴스레터 테이블에서 해당 회원 내역도 삭제하는 트리거 뉴스레터del을 생성 ------------------------------------------------
select * from 고객
select * from 뉴스레터

CREATE TRIGGER 뉴스레터_INSERT
ON 고객
AFTER INSERT
AS
BEGIN
  IF (SELECT 뉴스레터 FROM INSERTED) = 1
    INSERT INTO 뉴스레터 SELECT 고객id, 고객명, 연락처 FROM INSERTED
END
-- 레코드 생성
INSERT 고객 VALUES(344,'박영석','01-446-4573',1020,1)
INSERT 고객 VALUES(443,'박석','02-346-4573',1020,0)
INSERT 고객 VALUES(324,'최영희','031-921-3312',755,1)
INSERT 고객 VALUES(714,'원지애','02-363-8765',1100,1)
--트리거 생성
create trigger 고객delete
on 고객
after delete
as
begin
  -- if (select 뉴스레터 from deleted = 1) 굳이 작성하지 않아도 된다.
    delete from 뉴스레터 where 고객id = (select 고객id from deleted)
end
-- 레코드 삭제
delete from 고객 where 고객명 = '최영희'
delete from 고객 where 고객명 = '박석'

/*******************
-- insert
insert into 테이블명 values()

-- delete
delete from 테이블명 where

-- update
update 테이블명 set 수정내역 where
********************/
/*************************************************/
-- 예제. 입고 상품이 삭제 된다면 상품에 재고수량을 맞게 수정하시오 ------------------------------------------------
select * from 입고
select * from 상품

create trigger 입고insert
on 입고
after insert
as
begin 
  update 상품 set 재고수량=재고수량+(select 입고수량 from inserted)
              where 상품코드=(select 상품코드 from inserted)
end 
-- 레코드 생성
insert 입고 values('P01', '2024/11/04', 10)
insert 입고 values('P01', '2024/11/04', 10
--트리거 생성
create trigger 반품delete
on 입고
after delete
as
begin
  update 상품 set 재고수량 = 재고수량 - (select 입고수량 from deleted)
              where 상품코드=(select 상품코드 from deleted)
end
-- 레코드 삭제
delete from 입고 where 입고번호 = 2
/*************************************************/
select * from 기증내역
select * from 물품
-- 트리거 생성
create trigger 기증delete
on 기증내역
after delete
as
begin 
    update 물품 set 수량 = 수량 - (select 기증수량 from deleted) 
	            where 물품코드 = (select 물품코드 from deleted)
END
-- 레코드 삭제
delete from 기증내역 where 기증자 = '이도령'