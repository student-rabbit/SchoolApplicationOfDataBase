USE SAMPLEDB

-- 아래의 두가지 문장 비교하기
PRINT '오늘 식사는 하고 오셨나요~~~'
-- 메세지만 출력_비정형화된 결과

SELECT '오늘 식사는 하고 오셨나요?'
-- 표의 모양으로 나옴 - 파일로 다운받을 수 있음_정형화된 결과

/*
IF ()
~~~
ELSE
~~~
*/

CASE 색상 
	WHEN 'BLACK'  THEN '검정'
	WHEN 'WHITE'  THEN '흰색'
	WHEN 'YELLOW' THEN '노랑'
	END '기타색'
END 색상

WAITFOR TIME '10:16:10' -- 시:분:초 정확하게 작성하기
PRINT '오늘 식사는 하고 오셨나요~~~'

WAITFOR DELAY '00:00:05' -- 현재를 기준으로 몇 초 후 실행.