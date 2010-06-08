/* Postgres */

/*--------------------------*/
/*-- Update Agenda Status --*/
/*--------------------------*/

create or replace function update_agenda_status()
returns void as $agenda_status$
declare
begin
	update agenda set status = 'done'
	where date - current_date < 3 and status != 'canceled';
end;
$agenda_status$
language plpgsql;

/*-------------------------*/
/*-- Members Information --*/
/*-------------------------*/

create or replace function members_information(varchar)
returns setof band_information as $members_information$
	select * from band_information where login=$1;
$members_information$
language sql;

/*-------------------*/
/*-- Agenda by Day --*/
/*-------------------*/

create or replace function agenda_by_day(date)
returns setof agenda_information as $agenda_by_day$
	select * from agenda_information where date=$1;
$agenda_by_day$
language sql;

/*-------------------*/
/*-- Band Schedule --*/
/*-------------------*/

create or replace function band_schedule(varchar)
returns setof agenda_information as $band_schedule$
	select * from agenda_information where login=$1;
$band_schedule$
language sql;

