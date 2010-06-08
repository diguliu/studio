CREATE TABLE Person (
  Cpf VARCHAR(255)  NOT NULL ,
  Name  VARCHAR(255)  NOT NULL  ,
  Address VARCHAR(255)  NULL  ,
  Email VARCHAR(255)  NOT NULL    ,
  Gender ENUM ('male', 'female') NULL,
  Birth_Date DATE NULL,
  Age INTEGER NULL,
  Phone1 VARCHAR(255),
  Phone2 VARCHAR(255),
PRIMARY KEY(Cpf))
TYPE=InnoDB;



CREATE TABLE Equipment (
  Equipment_ID INTEGER UNSIGNED  NOT NULL ,
  Model VARCHAR(255)  NULL  ,
  Description VARCHAR(255) NULL , 
  Equipment_Type VARCHAR(255) NOT NULL  ,
  ExternalPrice FLOAT  NOT NULL  ,
  InternalPrice FLOAT  NOT NULL    ,
PRIMARY KEY(Equipment_ID))
TYPE=InnoDB;



CREATE TABLE Band (
  Login VARCHAR(255)  NOT NULL ,
  Name VARCHAR(255)  NOT NULL  ,
  Style VARCHAR(255)  NULL  ,
  HomePage VARCHAR(255)  NULL  ,
  Pass VARCHAR(255)  NOT NULL    ,
PRIMARY KEY(Login))
TYPE=InnoDB;



CREATE TABLE Service (
  Service_ID INTEGER UNSIGNED  NOT NULL ,
  Name VARCHAR(255) NOT NULL  ,
  Price FLOAT NOT NULL  ,
  Description VARCHAR(255)  NULL    ,
PRIMARY KEY(Service_ID))
TYPE=InnoDB;



CREATE TABLE Member (
  Member_ID INTEGER UNSIGNED  NOT NULL,
  Person_Cpf VARCHAR(255)  NOT NULL    ,
PRIMARY KEY(Member_ID),
  FOREIGN KEY(Person_Cpf)
    REFERENCES Person(Cpf)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION)
TYPE=InnoDB;

CREATE TABLE Client (
  Login VARCHAR(255)  NOT NULL,
  Person_Cpf VARCHAR(255) NOT NULL,
  Pass VARCHAR(255) NOT NULL,
PRIMARY KEY(Login),
  FOREIGN KEY(Person_Cpf)
    REFERENCES Person(Cpf)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION)
TYPE=InnoDB;



CREATE TABLE Agenda (
  Agenda_ID INTEGER UNSIGNED  NOT NULL,
  Service_ID INTEGER UNSIGNED  NOT NULL,
  Band_Login VARCHAR(255)  NOT NULL,
  Date DATE NOT NULL,
  Time TIME NOT NULL,
  Status ENUM('reserved', 'done', 'canceled') NOT NULL,
  Duration INTEGER UNSIGNED NOT NULL,
  Room INTEGER UNSIGNED NOT NULL,
  Total_Price FLOAT  ,
PRIMARY KEY(Agenda_ID),
  FOREIGN KEY(Band_Login)
    REFERENCES Band(Login)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Service_ID)
    REFERENCES Service(Service_ID)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION)
TYPE=InnoDB;



CREATE TABLE Client_rents_Equipment (
  Rent_ID int NOT NULL,
  Equipment_ID INTEGER UNSIGNED  NOT NULL  ,
  Client_Login VARCHAR(255)  NOT NULL  ,
  Duration INTEGER UNSIGNED NOT NULL  ,
  Date DATE NOT NULL  ,
  Time TIME NOT NULL  ,
  Total_Price FLOAT  ,
  Status ENUM ('reserved', 'done', 'canceled') NOT NULL,
PRIMARY KEY(Rent_ID),
  FOREIGN KEY(Client_Login)
    REFERENCES Client(Login)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Equipment_ID)
    REFERENCES Equipment(Equipment_ID)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION)
TYPE=InnoDB;



CREATE TABLE Band_has_Member (
  Band_Login VARCHAR(255)  NOT NULL  ,
  Member_ID INTEGER UNSIGNED  NOT NULL  ,
PRIMARY KEY(Band_Login, Member_ID),
  FOREIGN KEY(Member_ID)
    REFERENCES Member(Member_ID)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Band_Login)
    REFERENCES Band(Login)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION)
TYPE=InnoDB;



CREATE TABLE Agenda_has_Equipment (
  Agenda_ID INTEGER UNSIGNED  NOT NULL  ,
  Equipment_ID INTEGER UNSIGNED  NOT NULL  ,
  Duration INTEGER UNSIGNED NOT NULL  ,
  Time TIME NOT NULL    ,
PRIMARY KEY(Agenda_ID, Equipment_ID),
  FOREIGN KEY(Agenda_ID)
    REFERENCES Agenda(Agenda_ID)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Equipment_ID)
    REFERENCES Equipment(Equipment_ID)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION)
TYPE=InnoDB;

CREATE INDEX band_members_index ON Band_has_Member (band_login);
CREATE INDEX person_gender_index ON Person (gender);
CREATE INDEX person_age_index ON Person (age);
CREATE INDEX equipment_agenda_index ON Agenda_has_Equipment (Equipment_ID);
CREATE INDEX equipment_client_index ON Client_rents_Equipment (Equipment_ID);



