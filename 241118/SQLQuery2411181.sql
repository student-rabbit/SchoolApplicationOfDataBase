USE SampleDB
/**********사용자 정의 함수********
이름을 인수로 넘겨주면 함수 생성한 후에는 호출
 호출 당하는 쪽 : 매개변수(==그릇)
 호출하는 쪽 : 인수(== 실제값)
**********스칼라 함수: 결과값이 1개이다.********
ver1 - 값을 넘겨주는 것이 없을 때
 create function fn1()
 returns int -- return 하는 자료형/타입
 as
 begin
   return(10+20) -- 결과값을 던진다.
 end
 -- 함수 실행
 select dbo.fn1() -- 반드시 dbo.가 들어가야 실행된다.
***************************
ver2 - 값을 넘겨주는 것이 있다면 매개변수 사용한다.
 create function fn1(@a int, @b int)
 returns int -- return 하는 자료형
 as
 begin
   return(@a + @b) -- 결과값을 던진다.
 end
 -- 함수 실행
 select dbo.fn1(4,5) -- 반드시 dbo.가 들어가야 실행된다.
*************************************************/
-- 1. 스칼라 반환 함수 생성 - 딱 1개 값을 호출하는 쪽으로 반환하는 함수
create function msg()
returns varchar(30)
as
begin
  return('홍길동님 환영합니다!')
end
-- 호출
select dbo.msg() 환영메시지
/*************************************************/
-- 1. 스칼라 반환 함수 생성 - 인수 입력 시
create function msg1(@name varchar(10))
returns varchar(30)
as
begin
  return(@name+'님 환영합니다.~~~!')
end
-- 호출
select dbo.msg1('홍길동') 환영메시지
/*************************************************/
/*-- 예제1. 팀장현황 테이블을 기반으로 업무를 입력받아 해당 업무를 하는 직원의 수를 반환하는 함수 ‘fn_업무’를 작성해보자. 스칼라 값을 반환하는 함수로 작성할 것.
 집계 함수: count(), sum(), avg(), max(), min()
 괄호 안에는 맨 위의 제목열을 입력해야 한다. 집계 함수는 null을 카운트 하지 않는다.------------------------------------------------*/
select * 
from 팀장현황

create function dbo.fn_업무(@업무 varchar(20))
returns int
as
begin
  return(select count(*) 
         from 팀장현황 
		 where 업무 = @업무)
end
-- 호출
select dbo.fn_업무('영업') as 결과값
/*************************************************/
-- 예제. 성적 테이블에서 이름에 해당하는 학생의 점수를 출력하는 스칼라 반환 함수 ------------------------------------------------
select * 
from 성적

create function dbo.fn_점수(@이름 varchar(20))
returns int
as
begin
  return(select 점수
         from 성적 
         where 이름 = @이름)
end
-- 호출
select dbo.fn_점수('박보검') as 점수
/*************************************************/
-- 예제. 2개 점수를 인수로 넘기면 2개 점수 사이의 학생 수를 반환하는 스칼라 반환 함수
-- 80 ~ 90점 사이의 학생 수를 구하기 ------------------------------------------------
create function dbo.fn_학생수(@최소 int, @최대 int)
returns int
as
begin
  return(select count(*)
         from 성적 
         where 점수 between @최소 and @최대)
end
-- 호출
select dbo.fn_학생수(80,90) as 학생수
/**********인라인 테이블 반환함수*********
 결과가 테이블이다.
 값이 여러 개인 테이블 모양.
 create function 함수명
 returns table
 as
 return()
*************************************************/
-- 예제3. 성적테이블에서 점수가 입력값 이상 되는 레코드를 반환하는 인라인 테이블 반환 함수 ‘fn_점수1’를 작성하시오. 실행결과) 점수 90점 이상되는 결과 ------------------------------------------------
create function dbo.fn_점수1(@점수1 int)
returns table
as
return(select *
       from 성적 
       where 점수 >= @점수1)
-- 호출
select * from dbo.fn_점수1(90)
/*************************************************/
-- 예제. 2개 점수를 인수로 넘기면 2개 점수 사이의 학생들 데이터를 반환하는 인라인 테이블 반환함수 ------------------------------------------------
create function fn_점수2(@최소 int, @최대 int)
returns table
as
return(select * 
       from 성적 
       where 점수 between @최소 and @최대)
-- 호출
select * from dbo.fn_점수2(85,90)
/*************************************************/
-- 예제. 책 테이블과 출판사 테이블을 조인해서 해당 분야의 책들에 대한 책제목, 출판사명, 가격 출력해라.  ------------------------------------------------
select * from 책
select * from 출판사

create function fn_분야(@분야 varchar(20))
returns table
as
return(select 책제목, 출판사명, 가격 
       from 책 join 출판사 
	   on 책.출판사코드 = 출판사.출판사코드 
	   where 분야 = @분야)
-- 호출
select * from dbo.fn_분야('경제')
/**********다중문 테이블 반환 함수*********
임시 테이블을 만들어서 데이터를 채우고 그 임시 테이블을 반환하는 함수
 create function 함수명()
 returns @테이블명 table
 ()
 as
 begin
   insert into @테이블명
   select ~~
   return
 end
*/
/*************************************************/
-- 예제.  ------------------------------------------------
create function fn_학생리스트(@점수 int)
returns @r table
(학번 char(9),
 이름 char(20),
 점수 int)
as
begin
  insert into @r
  select 학번, 이름, 점수 
   from 성적 
   where 점수>=@점수
  return
end
-- 호출
select * from dbo.fn_학생리스트(90)
/*************************************************/
-- 예제. 2개 점수 사이의 학생들의 학번, 이름, 점수를 출력하는 다중문 테이블 변환함수 ------------------------------------------------
create function fn_학생리스트범위(@최소 int, @최대 int)
returns @r table
(학번 char(9),
 이름 char(20),
 점수 int)
with encryption -- 암호화(작성한 구문 못 보게 하는 방법
as
begin
  insert into @r
  select 학번, 이름, 점수 
   from 성적 
   where 점수 between @최소 and @최대
  return
end
-- 호출
select * from dbo.fn_학생리스트범위(80,90)
-- 구문 보는 방법
sp_helptext fn_학생리스트범위 
/*************************************************/
/**********개체명을 수정하는 방법*********
select * from 성적

sp_rename 성적, 배화성적 -- A를 B로 이름을 수정하는 구문
select * from 배화성적
**********의존하는 개체 수정 금지 옵션*********
with schemabinding
1. select 다음 모든 열 선택 X (select * 금지)
2. from 다음 테이블 명 앞 dbo. 붙이기
*/
-- 예제 ------------------------------------------------
create function fn_점수3(@이름 varchar(20))
returns int
with schemabinding
as
begin
  return(select 점수
         from dbo.성적 
         where 이름 = @이름)
end
-- 이름 변경해보기
sp_rename 성적, 배화성적