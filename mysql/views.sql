/* Views */

/* Informações sobre a banda */
CREATE OR REPLACE VIEW Band_Information AS
SELECT Band.Name, Band.Style, Band.HomePage, Person.Name as Member_Name, Person.Phone1, Person.Email FROM Band
INNER JOIN Band_Has_Member
ON Band_Has_Member.Band_Login = Band.Login
INNER JOIN Member
ON Member.Member_ID = Band_Has_Member.Member_ID
INNER JOIN Person
ON Person.Cpf = Member.Person_Cpf
Order by Band.Name asc;

/*-------------------*/

/* Agendamentos */
CREATE OR REPLACE VIEW Show_Agenda AS
SELECT b.Name, a.Date, a.Time, a.Duration, a.Room, a.Status 
FROM Band b
INNER JOIN Agenda a
ON a.Band_Login = b.Login
Order by a.Date asc;

