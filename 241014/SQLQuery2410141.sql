USE SampleDB
-- output�Ű����� ����10. ���̺� ����ǰ���� ���Ǹš��� ������� ��ǰ�� �Ǹż����� ���ϴ� ���ν����� �ۼ��Ͻÿ�. �̶�, �Է� �Ű������� ����ǰ�������� output�Ű������� ��ǰ���� �ش��ϴ� ���Ǹż������� ����ϵ��� �Ͻÿ�. (���� sql���� �����ϰ� �����Ͽ� ���ν����� �ۼ��� ��) ------------------------------------------------
/*
��) �Ǹż����� ���ϴ� sql��: 
 SELECT �Ǹż���
 FROM ��ǰ join �Ǹ�
 on  ��ǰ.��ǰ��ȣ=�Ǹ�.��ǰ��ȣ
 WHERE ��ǰ.��ǰ��=@��ǰ��  
 */
SELECT * FROM ��ǰ
SELECT * FROM �Ǹ�

-- �Է� �Ű����� ��ǰ��
CREATE PROC #p2
  @��ǰ�� VARCHAR(100)
AS
  SELECT �Ǹż���
  FROM ��ǰ JOIN �Ǹ�
  on  ��ǰ.��ǰ��ȣ=�Ǹ�.��ǰ��ȣ
  WHERE ��ǰ.��ǰ��=@��ǰ��
  
-- OUTPUT �Ű����� �Ǹż���
ALTER PROC #p2
  @��ǰ�� VARCHAR(100), @�Ǹż��� INT OUTPUT
AS
  SELECT @�Ǹż��� = �Ǹ�.�Ǹż���
  FROM ��ǰ JOIN �Ǹ�
  on  ��ǰ.��ǰ��ȣ=�Ǹ�.��ǰ��ȣ
  WHERE ��ǰ.��ǰ��=@��ǰ��

-- ȣ��
DECLARE @�Ǹż��� INT
EXEC #p2 '�ĵ�����', @�Ǹż��� OUTPUT
SELECT @�Ǹż��� �Ǹż���


/**********RETURN*********
 ������� ȣ���ϴ� �ʿ��ٰ� �ش�. output���� ��� �뵵�� �ణ �ٸ���.
 ���� ����/���� ���θ� Ȯ���ϱ� ���ؼ� ����Ѵ�.
 *** RETURN ������ �ݵ�� **INT**���� �Ѵ�.
*/

-- VER 01
CREATE PROC #p2
  @��ǰ�� VARCHAR(100)
AS
DECLARE  @�Ǹż��� INT -- *****
  SELECT @�Ǹż��� =SUM(�Ǹż���)
  FROM ��ǰ JOIN �Ǹ�
  on  ��ǰ.��ǰ��ȣ=�Ǹ�.��ǰ��ȣ
  WHERE ��ǰ.��ǰ��=@��ǰ��
RETURN @�Ǹż���  -- *****

-- VER 02
ALTER PROC #p2
  @��ǰ�� VARCHAR(100)
AS
DECLARE  @�Ǹż��� INT -- *****
  SELECT �Ǹ�.�Ǹż���
  FROM ��ǰ JOIN �Ǹ�
  on  ��ǰ.��ǰ��ȣ=�Ǹ�.��ǰ��ȣ
  WHERE ��ǰ.��ǰ��=@��ǰ��
  SET @�Ǹż��� = @@ROWCOUNT -- ��� ���ڵ� ����
RETURN @�Ǹż���  -- *****

-- ����
DECLARE @A INT
EXEC @A = #p2 '����Ʈ'
SELECT @A


-- return ���� �ִ� ���ν��� ����1 ���� 12.  ��ǰ ���̺����� �ش� ��ǰ�� ������ �Է¹޾� �� ��ǰ�� ������ ����� ��ȯ�ϵ��� ���ν����� �����Ͻÿ�.( return ���) ------------------------------------------------
SELECT COUNT(*) FROM ��ǰ WHERE ���� ='��Ʈ'

ALTER PROC #p3
  @���� VARCHAR(100)
AS
DECLARE @���� INT
  SELECT @���� = COUNT(����) /***�߿�***/
  FROM ��ǰ
  WHERE ���� = @����
RETURN @����

-- ����
DECLARE @A INT
EXEC @A = #p3 '��Ʈ'
SELECT @A


-- return ���� �ִ� ���ν��� ����2 ���� 13. ���̺� ����ǰ������ �Ű����� �� ���������� ���� ���� ��ǰ�� ������ 10%�λ��ϴ� ���ν����� �����Ͻÿ�. �̶�, return ����� �� ���� ���ڵ尡 �λ����� �Ǿ����� ������ ����ϼ���. ����) select @@rowcount (sql���� ����� ���ڵ尹��) ------------------------------------------------
CREATE PROC #p4
  @���� VARCHAR(20)
AS
  SELECT ��ǰ��, ����, ���� * 1.1 �λ󰡰�
  FROM ��ǰ
  WHERE ���� = @����
RETURN @@ROWCOUNT

DECLARE @R INT
EXEC @R = #p4 '��Ʈ'
SELECT @R