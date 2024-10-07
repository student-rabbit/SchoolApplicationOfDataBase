USE SampleDB

-- WHILE 문
DECLARE  @i INT = 1, @sum INT = 0
WHILE @i <= 100
BEGIN
  SELECT @sum+=@i -- @sum = @sum + @i
  SET @i+=1 -- @i = @i + 1
END
SELECT @sum 합계  -- 누적값 출력

EXEC('SELECT * FROM 성적')

/*
 CREATE TABLE A1(ID INT)
 CREATE TABLE A2(ID INT)
 CREATE TABLE A3(ID INT)
 ...
 CREATE TABLE A20(ID INT)
*/
DECLARE @sql VARCHAR(100) = 1, @j INT = 1
WHILE @j <= 100
BEGIN
  SELECT @sql = @sql + CONVERT(VARCHAR,@j) + '(ID INT)'
  EXEC(@sql)
END