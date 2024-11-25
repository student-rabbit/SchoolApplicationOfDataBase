USE SampleDB
/**********커서(Cursor)*********
 비절차적 언어(SQL)에서 개별적인 행 단위의 데이터 처리를 할 수 있는 개념. *한개씩 레코드 단위로 데이터 처리 == 절차적*
 비절차적 언어: 한개의 명령어만으로 원하는 모든 값을 출력할 수 있는 것
 순서
  1. 커서 선언(DECLARE)
  2. 커서 열기(OPEN)
  3. 반복적인 커서 작업=> 커서 데이터 가져오기(FETCH) + 처리
  4. 커서 닫기(CLOSE)
  5. 커서 할당 해제(DEALLOCATE)
*************************************************/
-- 예제. 성적 테이블에서 80점 이상 ------------------------------------------------
-- 1. 커서 선언- 개별 실행
declare s_test cursor for
select 학번, 이름, 점수 from 성적 where 점수 > 80
-- 2. 커서 열기 - 개별 실행
open s_test
-- 3. 변수 선언 - 4번과 동시 실행
declare @학번 char(9),
        @이름 char(20),
		@점수 int
-- 4. 한개 레코드 읽어오기
fetch next from s_test
into @학번, @이름, @점수
-- 반복문 조건 판단. 0은 성공, -1은 실패
while @@FETCH_STATUS = 0
begin
  select @학번, @이름, @점수
  fetch next from s_test
  into @학번, @이름, @점수
end
-- 5. 커서 닫기 - 개별 실행
close s_test
-- 6. 커서 할당 해제 - 개별 실행
deallocate s_test
/*************************************************/
-- 예제. 임시테이블 생성 ------------------------------------------------
create table #임시
(학번 char(9),
 이름 char(20),
 점수 int)
-- 1. 커서 선언- 개별 실행
declare s_test cursor for
select 학번, 이름, 점수 from 성적 where 점수 > 80
-- 2. 커서 열기 - 개별 실행
open s_test
-- 3. 변수 선언 - 4번과 동시 실행
declare @학번 char(9),
        @이름 char(20),
		@점수 int
-- 4. 한개 레코드 읽어오기
fetch next from s_test
into @학번, @이름, @점수
-- 반복문 조건 판단. 0은 성공, -1은 실패
while @@FETCH_STATUS = 0
begin
  insert into #임시 
  select @학번, @이름, @점수
  fetch next from s_test
  into @학번, @이름, @점수
end
-- 5. 커서 닫기 - 개별 실행
close s_test
-- 6. 커서 할당 해제 - 개별 실행
deallocate s_test
-- 결과 확인
select * from #임시
/*************************************************/
-- 예제. 책 테이블에서 출판사코드가 p003인 10% 할인가격, 나머지는 정상가로 출력 ------------------------------------------------
-- 커서 작업은 책제목, 분야, 출판사코드, 가격 열만 갖고 와서 작업할 것.
create table #책
(책제목 varchar(50),
 분야 varchar(20),
 출판사코드 char(5),
 가격 int)
-- 1. 커서 선언
declare s_test cursor for
select 책제목, 분야, 출판사코드, 가격 from 책
-- 2. 커서 열기
open s_test
-- 3. 변수 선언
declare @책제목 varchar(50),
        @분야 varchar(20),
        @출판사코드 char(5),
        @가격 int 
-- 4. 한개 레코드 읽어오기
fetch next from s_test
into @책제목, @분야, @출판사코드, @가격

while @@FETCH_STATUS = 0
begin
  if(@출판사코드 = 'p003')
    insert into #책 values(@책제목, @분야, @출판사코드, @가격*0.9)
  else
    insert into #책 values(@책제목, @분야, @출판사코드, @가격)
  fetch next from s_test
  into @책제목, @분야, @출판사코드, @가격
end
-- 5. 커서 닫기
close s_test
-- 6. 커서 할당 해제
deallocate s_test
-- 7. 실행
select * from #책
/*************************************************/
CREATE TABLE 장바구니
(구매번호 INT IDENTITY,
 구매제품 INT,
 구매량 INT,
 구매총액 INT)

INSERT 장바구니 VALUES(3,5,45000)
INSERT 장바구니 VALUES(1,1,20000)
INSERT 장바구니 VALUES(2,11,220000)
INSERT 장바구니 VALUES(4,2,60000)
INSERT 장바구니 VALUES(5,3,15000)
INSERT 장바구니 VALUES(3,7,21000)

select * from 장바구니

CREATE TABLE #구매총평
(구매번호 INT,
 구매제품 int,
 구매량 int,
 구매총액 int,
 구매총평 VARCHAR(30))

-- 예제. 구매량이 5이상이거나 구매총액이 10만원 이상인 레코드들을 모아 커서 선언. #구매총평 테이블에 입력 ------------------------------------------------
-- 1. 커서 선언
declare s_test cursor for
select * from 장바구니 where 구매량 > 5 or 구매총액 >100000
-- 2. 커서 열기
open s_test
-- 3. 변수 선언
declare @구매번호 INT,
        @구매제품 int,
        @구매량 int,
        @구매총액 int
-- 4. 한개 레코드 읽어오기
fetch next from s_test
into @구매번호,@구매제품,@구매량, @구매총액
-- 예제.구매총액이 10만원 이상이면 구매총액을 10%할인하고‘구매액 우수(할인적용)’이란 구매총평, 구매량이 5이상이면 ‘구매량 우수’란 구매총평을 기재  ------------------------------------------------
while @@FETCH_STATUS = 0
begin
  if(@구매총액>=100000)
    insert into #구매총평 values(@구매번호,@구매제품,@구매량, @구매총액*0.9, '구매액 우수(할인 적용)')
  if(@구매량>=5)
    insert into #구매총평 values(@구매번호,@구매제품,@구매량, @구매총액, '구매량 우수')
  fetch next from s_test
  into @구매번호,@구매제품,@구매량, @구매총액
end
-- 5. 커서 닫기
close s_test
-- 6. 커서 할당 해제
deallocate s_test
-- 7. 실행
select * from #구매총평
/*************************************************/
-- 예제. scroll 은 랜덤하게 레코드 이동이 가능. ------------------------------------------------
-- 1. 커서 선언- 개별 실행
declare s_test scroll cursor for
select 학번, 이름, 점수 from 성적 where 점수 > 80
-- 2. 커서 열기 - 개별 실행
open s_test
-- 3. 변수 선언 - 4번과 동시 실행
declare @학번 char(9),
        @이름 char(20),
		@점수 int
-- 4. 한개 레코드 읽어오기
fetch next from s_test
into @학번, @이름, @점수

select @학번, @이름, @점수
-- 5. 뒤로 돌아가기 - scroll 이 있을 경우에만 가능.
declare @학번 char(9),
        @이름 char(20),
		@점수 int

fetch prior from s_test
into @학번, @이름, @점수

select @학번, @이름, @점수
-- 5. 마지막 학생 확인해보기 - scroll 이 있을 경우에만 가능.
declare @학번 char(9),
        @이름 char(20),
		@점수 int

fetch last from s_test
into @학번, @이름, @점수

select @학번, @이름, @점수
-- 5. 첫번째 학생 확인해보기 - scroll 이 있을 경우에만 가능.
declare @학번 char(9),
        @이름 char(20),
		@점수 int

fetch first from s_test
into @학번, @이름, @점수

select @학번, @이름, @점수
-------------------------- 동기 방법
select * from 성적

begin tran
update 성적 set 점수 = 85 where 이름 = '조정석'  -- 임시 영역까지 수정됨.

declare @학번 char(9),
        @이름 char(20),
		@점수 int

fetch last from s_test
into @학번, @이름, @점수

select @학번, @이름, @점수

close s_test
deallocate s_test
-------------------------- 비 동기 방법?? 교재 확인해보기
declare s_test insensitive cursor for
select 학번, 이름, 점수 from 성적 where 점수 > 80

open s_test

declare @학번 char(9),
        @이름 char(20),
		@점수 int

fetch next from s_test
into @학번, @이름, @점수

select @학번, @이름, @점수

update 성적 set 점수 = 85 where 이름 = '여진구' 

close s_test
deallocate s_test

rollback