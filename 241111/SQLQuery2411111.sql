USE SampleDB
/********** 추가된 레코드 *********
 임시 테이블: INSERTED
 삭제된 임시 테이블 : deleted
**********update 트리거 작업*********
 deleted는 수정 전의 레코드 값이 저장된다. == 빼기
 inserted는 수정 후의 레코드 값이 저장된다. == 더한다.
**********트리거(Trigger)*********
 CREATE TRIGGER 트리거명
 ON 작동한/발생하는 테이블명
 AFTER 무엇을 하면(INSERT OR UPDATE OR DELETE 중 하나 작성)
 AS
 BEGIN
  어떤일이 발생한다. 저절로 되게 한다.
  수정하게 될 테이블
 END
***********************************
트리거 특징
1. 수동으로 실행시킬 수 없다.
2. 매개변수가 없다.
3. 트랜잭션의 일부로 처리된다.
4. 트리거가 또 다른 트리거를 실행시킬 수 있다.
5. Check 제약을 이용한 데이터의 무결성 유지보다. 진보된 제약을 구현한다.
***********************************
insert
 insert into 테이블명 values()

delete
 delete from 테이블명 where

update
 update 테이블명 set 수정내역 where
*************************************************/
-- 예제. 입고 수량이 수정되면 상품 테이블의 재고 수량이 변경 ------------------------------------------------
create trigger 입고insert
on 입고
after insert
as
begin 
  update 상품 set 재고수량 = 재고수량 + (select 입고수량 from inserted)
  where 상품코드 = (select 상품코드 from inserted)
end 
--
create trigger 입고delete   
on 입고  
after delete --!!!!!!!  
as  
begin  
   update 상품 set 재고수량 = 재고수량 - (select 입고수량 from deleted)  
   where 상품코드 = (select 상품코드 from deleted)  
end
--
insert into 입고 values('P01', '2024/11/11', 5)
--
select * from 입고
select * from 상품
-- update 트리거
create trigger 입고update
on 입고
after update
as
begin
  update 상품
   set 재고수량 = 재고수량-(select 입고수량 from deleted)+(select 입고수량 from inserted)
   where 상품코드 = (select 상품코드 from inserted)
end
-- update 레코드 작성
update 입고 set 입고수량 = 10 where 입고번호 = 2
/************************************************
-- 예제. 기증내역테이블과 물품테이블에서 기증내역의 수량이 수정되면 물품테이블이 수정되도록 트리거를 작성하시오. ------------------------------------------------
 트리거를 작성한 후 정상적으로 작동하는 것을 확인하기 위해 다음 SQL문을 실행하시오.
 update 기증내역 set 기증수량=5  where 번호=3
*/
create trigger 물품delete  
on 기증내역   
after delete   
as  
begin 
  update 물품
   set 수량 = 수량 - (select 기증수량 from deleted )    
   where  물품코드 = (select 물품코드 from deleted)   
end
--
create trigger 물품insert  
on 기증내역  
after insert  
as  
begin  
  update 물품
   set 수량 = 수량 + (select 기증수량 from inserted )  
   where 물품코드 = (select 물품코드 from inserted)   
end
--
select * from 기증내역
select * from 물품
-- update 트리거 작성
create trigger 기증update
on 기증내역
after update
as
begin
 update 물품
  set 수량 = 수량 - (select 기증수량 from deleted) + (select 기증수량 from inserted)
  where 물품코드 = (select 물품코드 from inserted)
end
-- update 레코드 생성
update 기증내역 set 기증수량=5  where 번호=3