USE SampleDB
/**********Ŀ��(Cursor)*********
 �������� ���(SQL)���� �������� �� ������ ������ ó���� �� �� �ִ� ����. *�Ѱ��� ���ڵ� ������ ������ ó�� == ������*
 �������� ���: �Ѱ��� ��ɾ���� ���ϴ� ��� ���� ����� �� �ִ� ��
 ����
  1. Ŀ�� ����(DECLARE)
  2. Ŀ�� ����(OPEN)
  3. �ݺ����� Ŀ�� �۾�=> Ŀ�� ������ ��������(FETCH) + ó��
  4. Ŀ�� �ݱ�(CLOSE)
  5. Ŀ�� �Ҵ� ����(DEALLOCATE)
*************************************************/
-- ����.  ------------------------------------------------
-- Ŀ�� ����
declare s_test cursor for
select �й�, �̸�, ���� from ����
-- Ŀ�� ����
open s_test
-- ���� �������� ���� -- ��������
declare @�й� char(9), @�̸� varchar(20), @���� int
-- ���྿ �б�
fetch next from s_test into @�й�, @�̸�, @����

while(@@FETCH_STATUS = 0) -- �ý��� ������ �� Ȯ��
begin
  if(@���� >= 90)
    select @�й�, @�̸�, @����
  fetch next from s_test into @�й�, @�̸�, @����
end
-- end ���� �ѹ��� ����
-- Ŀ�� �ݱ�, �޸� �Ҵ� ����
close s_test
deallocate s_test
/*************************************************/
-- �ӽ� ���̺� ����
create table #����
(�й� char(9), 
 �̸� varchar(20),
 ���� int)
-- Ŀ�� ����
declare s_test cursor for
select �й�, �̸�, ���� from ����
-- Ŀ�� ����
open s_test
-- ���� �������� ���� -- ��������
declare @�й� char(9), @�̸� varchar(20), @���� int
-- ���྿ �б�_fetch�� while������ �ѹ� �Է� �ؾ� �� ���� ���� ����. �ȱ׷� null���̶� ���� �Ұ�.
fetch next from s_test into @�й�, @�̸�, @����

while(@@FETCH_STATUS = 0) -- �ý��� ������ �� Ȯ��
begin
  if(@���� >= 90)
    insert into #����
	select @�й�, @�̸�, @����
  fetch next from s_test into @�й�, @�̸�, @����
end
-- end ���� �ѹ��� ����
-- Ŀ�� �ݱ�, �޸� �Ҵ� ����
close s_test
deallocate s_test
-- ���̺� Ȯ���ϱ�
select * from #���� 