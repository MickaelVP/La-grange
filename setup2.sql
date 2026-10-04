-- À lancer dans Supabase > SQL Editor (complément de setup.sql)
create or replace function reset_answers(req bigint, only_no boolean) returns void language plpgsql security definer set search_path=public as $$
begin
  if not exists(select 1 from requests where id=req and by_user=auth.uid()) then raise exception 'non autorisé'; end if;
  delete from answers where request_id=req and (not only_no or verdict='no');
end $$;
