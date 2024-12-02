USE SampleDB
/*********************트리거 기말고사 연습 문제들****************************/
-- 중요!!!!!!
 -- 검색 select from where
 -- 입력 insert into values 
 -- 삭제 delete from where 
 -- 수정 update set where 

create table e1
(사번 int,
이름 char(20),
직급 char(10))

create table total
(직급 char(10),
총인원 int)
insert total values('사원',0)
insert total values('대리',0)
insert total values('과장',0)
insert total values('부장',0)

select * from e1
select * from total
/*************************************************/
-- 트리거 예제 1. e1테이블에 사원레코드가 입력되면 total레코드에 입력된 사원의 직급의 총인원이 +1 누적되는 insert 트리거를 작성 ------------------------------------------------
create trigger e1_insert
on e1
after insert
as
begin
  update total
    set 총인원 = 총인원 + 1 
	where 직급 = (select 직급 from inserted) 
end
-- 레코드 입력
insert into e1 values(111,'홍길동','사원')
insert into e1 values(222,'김선달','사원')
insert into e1 values(123,'성춘향','대리')
/*************************************************/
-- 트리거 예제 2. e1 테이블의 직급이 수정되면 total테이블의 해당 직급에 대한 총인원도 수정되는 update트리거를 작성------------------------------------------------
create trigger e1_update
on e1
after update
as
begin
  update total
    set 총인원 = 총인원 - 1 
	where 직급 = (select 직급 from deleted) 
  update total
    set 총인원 = 총인원 + 1 
	where 직급 = (select 직급 from inserted) 
end
-- 레코드 수정
update e1 set 직급 = '대리' where 이름 = '홍길동'
/*************************************************/
-- 트리거 예제 3. e1테이블의 사원이 퇴사(삭제) 되면 total테이블의 총인원도 반영되는 delete트리거를 작성 ------------------------------------------------
create trigger e1_delete
on e1
after delete
as
begin
  update total
    set 총인원 = 총인원 - 1 
	where 직급 = (select 직급 from deleted)
end
-- 레코드 삭제
delete from e1 where 이름 = '홍길동'
/**************************************************************************************************/
select datediff(yy, '2003/11/11', getdate())

-- 사용자 정의 함수 예제 4. datadiff()함수는 두 날짜간의 차이를 출력하는 함수이다. 이 datediff()함수를 사용하여 내가 태어날 날부터 지금까지 몇 개월살았는지, 며칠 살았는지를 출력하는 스칼라 함수를 작성하고 실행하세요. [참고] datediff(dd, 첫 번째날짜, 두 번째 날짜) ------------------------------------------------
create function birth(@dd date)
returns int
as
begin
  return(datediff(dd, @dd, getdate()))
end
-- 실행
select dbo.birth('2003/12/19') 살아온날수
/*************************************************/
-- 사용자 정의 함수 예제 5. 앞의 문제를 인라인 테이블 반환함수로 작성하세요 ------------------------------------------------
create function birth1(@dd date)
returns table
as
  return(select datediff(dd, @dd, getdate()) 살아온날)
-- 실행
select * from dbo.birth1('2003/12/19')
/*************************************************/
-- 사용자 정의 함수 예제 6. 다중문 테이블 반환함수로 작성하세요.  ------------------------------------------------
create function birth2(@dd date)
returns @r table
(살아온날 int)
as
begin
  insert into @r
  select datediff(dd, @dd, getdate())
  return
end
-- 실행
select * from dbo.birth2('2003/12/19')
/*************************************************/
-- 사용자 정의 함수 예제 7. 배화 카페의 음료 가격은 다음과 같다. 아메리카노- 3000, 카페라떼 - 3500, 오렌지쥬스 - 4000, 망고쥬스 - 4500 음료별 잔의 수를 입력받아 음료, 잔의 수, 합계를 출력하는 다중문 테이블 함수를 작성 ------------------------------------------------
create function cafe(@menu char(20), @num int)
returns @r table
(menu varchar(20),
 num int,
 price int)
as
begin
  insert into @r
  select @menu, @num,
  case @menu 
    when '아메리카노' then @num*3000
    when '카페라떼' then @num*3500
    when '오렌지쥬스' then @num*4000
    when '망고쥬스' then @num*4500
  end
  return
end
-- 레코드 입력
select * from dbo.cafe('아메리카노',2)
/**************************************************************************************************/
create table #학과
(구분 char(20), 학과명 varchar(30), 전화 char(13))

select * from 학과

-- 커서 예제 8.  테이블 학과에서 학과명, 전화를 커서로 읽어들여 #학과테이블에 다음과 같이 데이터를 채우는 커서 작업을 하세요. ------------------------------------------------
-- 커서 선언
declare s_test cursor for
select 학과명, 전화 from 학과
-- 커서 열기
open s_test
--데이터 가져오기
declare @구분 char(20), @학과명 varchar(30), @전화 char(13)

fetch next from s_test into @학과명, @전화

while (@@FETCH_STATUS = 0)
begin
  select @구분 = 
  case @학과명
    when '컴퓨터공학' then '공과대학'
    when '식품영양' then '이과대학'
	else '문과대학'
  end
  insert into #학과
  values(@구분, @학과명, @전화)
  fetch next from s_test into @학과명, @전화
end
-- 커서 닫기
close s_test
-- 커서 할당 해제
deallocate s_test
-- 확인
select * from #학과