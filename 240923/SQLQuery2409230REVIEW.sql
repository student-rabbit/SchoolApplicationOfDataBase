-- SampleDB
------------------------------------------------
/**********VIEW*********
 전체 테이블을 다 보여주지 않고 일부만 보여주는 방법
 CREATE VIEW V1
 AS
 SELECT 학번,
		이름
 FROM 성적
*/

CREATE VIEW V1
AS
SELECT 학번,
		이름
FROM 성적

ALTER VIEW V1
AS
SELECT 학번,
		이름,
		점수
FROM 성적 
WHERE 점수 >= 80

SELECT *
FROM V1

ALTER VIEW V1
AS
SELECT 학번,
		이름,
		점수
FROM 성적
WHERE 점수 >= 80
WITH CHECK OPTION  -- 조건을 무조건 유지하라
