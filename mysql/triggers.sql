/* Mysql */

/*-------------------------*/
/*-- Service Total Price --*/
/*-------------------------*/

DELIMITER $
CREATE TRIGGER total_service_price BEFORE UPDATE ON Agenda
     FOR EACH ROW
     BEGIN

    SET @service_price = 0;
    SET @equipments_price = 0;

    INSERT INTO @service_price
    SELECT  Agenda.duration*Service.Price
    FROM Agenda INNER JOIN Service
    ON Agenda.Service_ID = Service.Service_ID
    WHERE Agenda.Agenda_ID = NEW.Agenda_ID;

    INSERT INTO @equipments_price
        SELECT SUM(ahe.Duration*e.InternalPrice)
    FROM Agenda_has_Equipment AS ahe INNER JOIN Equipment AS e
    ON ahe.Equipment_ID = e.Equipment_ID WHERE ahe.Agenda_ID = NEW.Agenda_ID;

	IF @equipments_price IS NULL THEN
		equipments_price = 0;
	END IF;

    SET NEW.Total_Price = @service_price + @equipments_price;

     END;$
DELIMITER ;

DELIMITER $
CREATE TRIGGER total_service_price BEFORE INSERT ON Agenda
     FOR EACH ROW
     BEGIN

    SET @service_price = 0;
    SET @equipments_price = 0;

    INSERT INTO @service_price
    SELECT  Agenda.duration*Service.Price
    FROM Agenda INNER JOIN Service
    ON Agenda.Service_ID = Service.Service_ID
    WHERE Agenda.Agenda_ID = NEW.Agenda_ID;

    INSERT INTO @equipments_price
        SELECT SUM(ahe.Duration*e.InternalPrice)
    FROM Agenda_has_Equipment AS ahe INNER JOIN Equipment AS e
    ON ahe.Equipment_ID = e.Equipment_ID WHERE ahe.Agenda_ID = NEW.Agenda_ID;

	IF @equipments_price IS NULL THEN
		equipments_price = 0;
	END IF;

    SET NEW.Total_Price = @service_price + @equipments_price;

     END;$
DELIMITER ;

/*----------------------*/
/*-- Rent Total Price --*/
/*----------------------*/

DELIMITER $
CREATE TRIGGER total_rent_price BEFORE UPDATE ON Client_rents_Equipment
     FOR EACH ROW
     BEGIN

    SET @equipments_price = 0;

    INSERT INTO @equipments_price
        SELECT SUM(cre.Duration*e.ExternalPrice)
    FROM Client_rents_Equipment AS cre INNER JOIN Equipment AS e
    ON cre.Equipment_ID = e.Equipment_ID WHERE cre.Client_Login = NEW.Client_Login;

	IF @equipments_price IS NULL THEN
		equipments_price = 0;
	END IF;

    SET NEW.Total_Price = @equipments_price;

     END;$
DELIMITER ;

DELIMITER $
CREATE TRIGGER total_rent_price BEFORE INSERT ON Client_rents_Equipment
     FOR EACH ROW
     BEGIN

    SET @equipments_price = 0;

    INSERT INTO @equipments_price
        SELECT SUM(cre.Duration*e.ExternalPrice)
    FROM Client_rents_Equipment AS cre INNER JOIN Equipment AS e
    ON cre.Equipment_ID = e.Equipment_ID WHERE cre.Client_Login = NEW.Client_Login;

	IF @equipments_price IS NULL THEN
		equipments_price = 0;
	END IF;

    SET NEW.Total_Price = @equipments_price;

     END;$
DELIMITER ;
