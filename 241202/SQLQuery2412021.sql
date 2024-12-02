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
-- 예제.  ------------------------------------------------
-- 커서 선언
declare s_test cursor for
select 학번, 이름, 점수 from 성적
-- 커서 열기
open s_test
-- 담을 지역변수 선언 -- 여서부터
declare @학번 char(9), @이름 varchar(20), @점수 int
-- 한행씩 읽기
fetch next from s_test into @학번, @이름, @점수

while(@@FETCH_STATUS = 0) -- 시스템 변수의 값 확인
begin
  if(@점수 >= 90)
    select @학번, @이름, @점수
  fetch next from s_test into @학번, @이름, @점수
end
-- end 까지 한번에 실행
-- 커서 닫기, 메모리 할당 해제
close s_test
deallocate s_test
/*************************************************/
-- 임시 테이블 생성
create table #성적
(학번 char(9), 
 이름 varchar(20),
 점수 int)
-- 커서 선언
declare s_test cursor for
select 학번, 이름, 점수 from 성적
-- 커서 열기
open s_test
-- 담을 지역변수 선언 -- 여서부터
declare @학번 char(9), @이름 varchar(20), @점수 int
-- 한행씩 읽기_fetch를 while이전에 한번 입력 해야 참 거짓 진입 가능. 안그럼 null값이라 진입 불가.
fetch next from s_test into @학번, @이름, @점수

while(@@FETCH_STATUS = 0) -- 시스템 변수의 값 확인
begin
  if(@점수 >= 90)
    insert into #성적
	select @학번, @이름, @점수
  fetch next from s_test into @학번, @이름, @점수
end
-- end 까지 한번에 실행
-- 커서 닫기, 메모리 할당 해제
close s_test
deallocate s_test
-- 테이블 확인하기
select * from #성적 