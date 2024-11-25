USE SampleDB
/*************************************************/
select * from 책
-- 스칼라 반환 함수 예제 1. 책테이블을 기반으로 책제목을 매개변수로 하여 책의 가격을 출력하는 스칼라 함수'fn_책가격’을 작성하고 실행하세요. ------------------------------------------------
create function fn_책가격(@책제목 varchar(30))
returns varchar(30)
as
begin
  return(select 가격 from 책 where 책제목 = @책제목)
end
-- 호출
select dbo.fn_책가격('파스타요리') as 도서가격
/*************************************************/
-- 인라인 테이블 반환 함수 예제. 책테이블을 기반으로 가격을 매개변수로 하여 가격1~가격2 사이의 책에 대하여 책제목, 분야, 가격을 출력하는 인라인 테이블 반환 함수 ‘fn_책list1’ 를 작성하고 실행하세요. (매개변수 가격2개) ------------------------------------------------
create function fn_책list1(@가격1 int, @가격2 int)
returns table
as
return(select 책제목, 분야, 가격
       from 책
       where 가격 between @가격1 and @가격2) -- 가격1과 가격2 사이의 책.
-- 호출
select * from dbo.fn_책list1(12000,15000)
/*************************************************/
-- 다중문 테이블 반환함수 예제. 문제2를 다중문 테이블 반환함수 'fn_책list2'로 작성하고 실행하세요.  ------------------------------------------------
create function fn_책list2(@최소 int, @최대 int)
returns @r table
(책제목 varchar(30),
 분야 varchar(30),
 가격 int)
as
begin
  insert into @r
  select 책제목, 분야, 가격
   from 책
   where 가격 between @최소 and @최대
  return
end
-- 호출
select * from dbo.fn_책list2(12000,15000)