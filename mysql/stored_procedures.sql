/* Mysql */

/*--------------------------*/
/*-- Update Agenda Status --*/
/*--------------------------*/

DELIMITER $
CREATE PROCEDURE Update_Agenda_Status ()
BEGIN
       Update Agenda
       SET Status = 'Done'
       WHERE (Date - CURDATE()) < 3 and Status != "Canceled";
END;$
DELIMITER ;

