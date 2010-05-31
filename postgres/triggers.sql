/* Postgres */

/*------------------------------------------*/
/*-- Service Total Price Equipment Update --*/
/*------------------------------------------*/

create or replace function update_agenda()
returns trigger as $update_agenda$
declare
d integer;
begin
	if (TG_OP = 'INSERT' or TG_OP = 'UPDATE') then
		select duration into d from agenda where agenda_id=NEW.agenda_id;
		update agenda set duration=d where agenda_id=NEW.agenda_id;
		return NEW;
	elsif (TG_OP = 'DELETE') then
		select duration into d from agenda where agenda_id=OLD.agenda_id;
		update agenda set duration=d where agenda_id=OLD.agenda_id;
		return OLD;
	end if;
	return null;
end;
$update_agenda$
language plpgsql;

drop trigger if exists call_agenda_trigger on agenda_has_equipment;
create trigger call_agenda_trigger after update or insert or delete on agenda_has_equipment
for each row execute procedure update_agenda();

/*-------------------------*/
/*-- Service Total Price --*/
/*-------------------------*/

create or replace function service_price()
returns trigger as $service_price$
declare
	service_price float;
	equipments_price float;
begin
	select NEW.duration*service.price into service_price
	from service where service_id = NEW.service_id;

	select sum(ahe.duration*e.internalprice) into equipments_price
	from agenda_has_equipment as ahe inner join equipment as e
	on ahe.equipment_id = e.equipment_id where ahe.agenda_id = NEW.agenda_id;

	if equipments_price is null then
		equipments_price = 0;
	end if;

	NEW.total_price := service_price+equipments_price;
	return NEW;
end;
$service_price$
language plpgsql;

drop trigger if exists calculate_service_price on agenda;
create trigger calculate_service_price before update or insert on agenda
for each row execute procedure service_price();

/*----------------------*/
/*-- Rent Total Price --*/
/*----------------------*/

create or replace function rent_price()
returns trigger as $rent_price$
declare
	equipments_price float;
begin
	equipments_price = 0;
	select sum(cre.duration*e.externalprice) into equipments_price
	from client_rents_equipment as cre inner join equipment as e
	on cre.equipment_id = e.equipment_id where cre.client_login = NEW.client_login;

	if equipments_price is null then
		equipments_price = 0;
	end if;

	NEW.total_price := equipments_price;
	return NEW;
end;
$rent_price$
language plpgsql;

drop trigger if exists calculate_rent_price on client_rents_equipment;
create trigger calculate_rent_price before update or insert on client_rents_equipment
for each row execute procedure rent_price();

