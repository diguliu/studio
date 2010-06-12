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
		select duration into d from agendas where id=NEW.id;
		update agendas set duration=d where id=NEW.id;
		return NEW;
	elsif (TG_OP = 'DELETE') then
		select duration into d from agendas where id=OLD.id;
		update agenda set duration=d where id=OLD.id;
		return OLD;
	end if;
	return null;
end;
$update_agenda$
language plpgsql;

drop trigger if exists call_agenda_trigger on internal_rents;
create trigger call_agenda_trigger after update or insert or delete on internal_rents
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
	from services where id = NEW.id;

	select sum(ahe.duration*e.internal_price) into equipments_price
	from internal_rents as ahe inner join equipments as e
	on ahe.id = e.id where ahe.id = NEW.id;

	if equipments_price is null then
		equipments_price = 0;
	end if;

	NEW.total_price := service_price+equipments_price;
	return NEW;
end;
$service_price$
language plpgsql;

drop trigger if exists calculate_service_price on agendas;
create trigger calculate_service_price before update or insert on agendas
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
	select sum(cre.duration*e.external_price) into equipments_price
	from external_rents as cre inner join equipments as e
	on cre.id = e.id where cre.login = NEW.login;

	if equipments_price is null then
		equipments_price = 0;
	end if;

	NEW.total_price := equipments_price;
	return NEW;
end;
$rent_price$
language plpgsql;

drop trigger if exists calculate_rent_price on external_rents;
create trigger calculate_rent_price before update or insert on external_rents
for each row execute procedure rent_price();

