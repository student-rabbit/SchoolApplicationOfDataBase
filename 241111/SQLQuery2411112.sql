/************************2024_트리거.hwp*************************/
-- 예제1. 성적1 테이블에 학생레코드가 입력되면 총점 테이블의 합계가 누적되도록 insert트리거를 생성 ------------------------------------------------
create table 성적1
(학번 int,
 학과 char(2),
 이름 char(20),
 점수 int)
--
create table 총점
(학과 char(2),
 합계 int) 
--
insert 총점 values('d1',0),('d2',0),('d3',0)
--
select * from 성적1
select * from 총점
-- 트리거 생성
create trigger 학생insert
on 성적1
after insert
as
begin
  update 총점
  set 합계 = 합계 + (select 점수 from inserted) 
  where 학과 = (select 학과 from inserted) 
end
-- 레코드 입력
insert into 성적1 values(1, 'd1', '홍길동', 80)
insert into 성적1 values(2, 'd1', '김선달', 85)
insert into 성적1 values(3, 'd2', '최영희', 100)
insert into 성적1 values(4, 'd3', '박철수', 77)
/*************************************************/
-- 예제2. 성적1 테이블에 학생레코드가 삭제되면 총점 테이블의 합계가 수정되도록 delete트리거를 생성 ------------------------------------------------
create trigger 학생delete
on 성적1
after delete
as
begin
 update 총점
  set 합계 = 합계 - (select 점수 from deleted) 
  where 학과 = (select 학과 from deleted) 
end
-- 레코드 삭제
delete 성적1 where 이름 = '박철수'
/*************************************************/
-- 예제3. 성적1 테이블에 점수가 수정되면 총점 테이블의 합계가 수정되도록 update 트리거를 생성 ------------------------------------------------
create trigger 총점update
on 성적1
after update
as
begin
 update 총점
  set 합계 = 합계 - (select 점수 from deleted) + (select 점수 from inserted)
  where 학과 = (select 학과 from inserted)
end
-- 레코드 수정
update 성적1 set 점수 = 90 where 학번 = 2
/*************************************************/
-- 예제4. 티켓 테이블을 생성하고 그룹이 티켓을 구입할 때마다 티켓 유형별 매수에 따라 총가격을 출력하는 트리거를 트리거 발생 구문도 작성하세요. ------------------------------------------------
create table 티켓
(번호 int identity,
 아동 int,
 청소년 int, 
 성인 int)
--
select * from 티켓
-- 트리거 생성
create trigger 티켓insert
on 티켓
after insert
as
begin
 select 아동*2000+청소년*3000+성인*5000 총금액 from inserted
end
-- 레코드 입력
insert 티켓 values(2,1,2)
insert 티켓 values(2,0,2)
insert 티켓 values(2,1,2)
/*************************************************/
-- 예제5. 문제4의 티켓 테이블에서 아동, 청소년, 성인 중 하나라도 티켓 유형 매수가 수정되면 총가격을 다시 계산해서 출력하는 트리거를 작성하고 트리거 발생 구문도 작성하세요. ------------------------------------------------
create trigger 티켓update
on 티켓
after update
as
begin
 select 아동*2000+청소년*3000+성인*5000 총금액 from inserted
end
-- 레코드 수정
update 티켓 set 아동 = 10 where 번호 = 7