-- =====================================================================
-- 영업맵 업데이트: 날짜·시간 입력 (등록 / 활동 / 재접촉)
-- SQL Editor 새 쿼리 창(+)에 붙여넣고 한 번만 실행. 기존 데이터는 유지됩니다.
-- =====================================================================
alter table public.prospects  add column if not exists reg_date   date;
alter table public.prospects  add column if not exists reg_time   time;
alter table public.activities add column if not exists visit_time time;
alter table public.recontacts add column if not exists due_time   time;

-- 이미 있는 기록은 실제 입력했던 시각으로 채워두기
update public.prospects
   set reg_date = (created_at at time zone 'Asia/Seoul')::date,
       reg_time = to_char(created_at at time zone 'Asia/Seoul', 'HH24:MI')::time
 where reg_date is null;

update public.activities
   set visit_time = to_char(created_at at time zone 'Asia/Seoul', 'HH24:MI')::time
 where visit_time is null;
