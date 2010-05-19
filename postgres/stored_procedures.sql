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
