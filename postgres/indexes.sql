CREATE INDEX band_members_index on band_has_member (band_login);
CREATE INDEX person_age_index on person (age);
CREATE INDEX equipment_agenda_index on agenda_has_equipment (equipment_id);
CREATE INDEX equipment_client_index on client_rents_equipment (equipment_id);
