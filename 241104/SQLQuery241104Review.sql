USE SampleDB
/********** 추가된 레코드 *********
 임시 테이블: INSERTED
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
/*************************************************/
select * from 기증내역
select * from 물품
-- 예제. 기증내역에 레코드를 추가하면 물품의 수량이 변경 ------------------------------------------------
create trigger 기증insert
on 기증내역
after insert
as
begin 
    update 물품 set 수량 = 수량 + (SELECT 기증수량 FROM INSERTED) 
	            where 물품코드 = (SELECT 물품코드 FROM INSERTED)
END
-- 추가할 레코드
insert 기증내역 values('p01', '김철수', 10)
insert 기증내역 values('p02', '이도령', 10)
/*************************************************/
-- 예제. 장바구니 테이블에 레코드가 삽입될때마다 총 금액이 출력되는 트리거를 생성하세요. 또한, 트리거를 동작시키도록 장바구니 테이블에 레코드를 삽입하는 구문을 작성하세요. ------------------------------------------------
create table 장바구니
(번호 int identity,
 상품 char(30),
 가격 int)
-- 확인
select * from 장바구니
-- 레코드 추가
insert 장바구니 values('가방', 2400)
-- 트리거 작성
create trigger 장바구니insert
on 장바구니
after insert
as
begin
  select '총금액 :' + convert(varchar,sum(가격))  from 장바구니
end
-- 레코드 추가 한번에 한 insert씩 작성
insert 장바구니 values('열쇠', 2600)
insert 장바구니 values('두부', 2300)
insert 장바구니 values('우유', 3700)