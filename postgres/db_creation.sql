CREATE DOMAIN gender as varchar check (value in ('male', 'female'));
CREATE DOMAIN status as varchar check (value in ('reserved', 'done', 'canceled'));

CREATE TABLE Person (
  Cpf  VARCHAR NOT NULL ,
  Name  VARCHAR  NOT NULL  ,
  Address VARCHAR,
  Email VARCHAR,
  Gender gender,
  Birth_Date Date, 
  Age INTEGER,
  Phone1 VARCHAR,
  Phone2 VARCHAR,
PRIMARY KEY(Cpf));

CREATE TABLE Equipment (
  Equipment_ID INTEGER  NOT NULL ,
  Model VARCHAR    ,
  Description VARCHAR,
  Equipment_Type VARCHAR    ,
  External_Price FLOAT NOT NULL ,
  Internal_Price FLOAT NOT NULL     ,
PRIMARY KEY(Equipment_ID));




CREATE TABLE Band (
  Login VARCHAR  NOT NULL ,
  Name VARCHAR   NOT NULL ,
  Style VARCHAR    ,
  HomePage VARCHAR    ,
  Pass VARCHAR   NOT NULL   ,
PRIMARY KEY(Login));



CREATE TABLE Service (
  Service_ID INTEGER  NOT NULL ,
  Name VARCHAR  NOT NULL  ,
  Price FLOAT   NOT NULL ,
  Description VARCHAR    ,
PRIMARY KEY(Service_ID));




CREATE TABLE Member (
  Member_ID INTEGER   NOT NULL ,
  Person_Cpf VARCHAR   NOT NULL   ,
PRIMARY KEY(Member_ID),
  FOREIGN KEY(Person_Cpf)
    REFERENCES Person(Cpf));


CREATE TABLE Client (
  Login VARCHAR  NOT NULL ,
  Person_Cpf VARCHAR   NOT NULL ,
  Pass VARCHAR   NOT NULL   ,
PRIMARY KEY(Login)  ,
  FOREIGN KEY(Person_Cpf)
    REFERENCES Person(Cpf));


CREATE TABLE Agenda (
  Agenda_ID INTEGER    NOT NULL ,
  Service_ID INTEGER   NOT NULL ,
  Band_Login VARCHAR   NOT NULL ,
  Date DATE NOT NULL   ,
  Time TIME  NOT NULL  ,
  Duration INTEGER   NOT NULL  ,
  Room INTEGER   NOT NULL    ,
  Status status NOT NULL,
  Total_Price FLOAT  ,
PRIMARY KEY(Agenda_ID)    ,
  FOREIGN KEY(Band_Login)
    REFERENCES Band(Login),
  FOREIGN KEY(Service_ID)
    REFERENCES Service(Service_ID));


CREATE TABLE Client_rents_Equipment (
  Rent_ID int NOT NULL,
  Equipment_ID INTEGER   NOT NULL  ,
  Client_Login VARCHAR  NOT NULL  ,
  Duration INTEGER  NOT NULL  ,
  Date DATE NOT NULL  ,
  Time TIME NOT NULL  ,
  Total_Price FLOAT  ,
  Status status NOT NULL,
PRIMARY KEY(Rent_ID),
  FOREIGN KEY(Client_Login)
    REFERENCES Client(Login),
  FOREIGN KEY(Equipment_ID)
    REFERENCES Equipment(Equipment_ID)
);

CREATE TABLE Band_has_Member (
  Band_Login VARCHAR  NOT NULL  ,
  Member_ID INTEGER   NOT NULL  ,
PRIMARY KEY(Band_Login, Member_ID),
  FOREIGN KEY(Member_ID)
    REFERENCES Member(Member_ID),
  FOREIGN KEY(Band_Login)
    REFERENCES Band(Login)
);

CREATE TABLE Agenda_has_Equipment (
  Agenda_ID INTEGER   NOT NULL  ,
  Equipment_ID INTEGER   NOT NULL  ,
  Duration INTEGER  NOT NULL  ,
  Time TIME NOT NULL    ,
PRIMARY KEY(Agenda_ID, Equipment_ID, Duration, Time),
  FOREIGN KEY(Agenda_ID)
    REFERENCES Agenda(Agenda_ID),
  FOREIGN KEY(Equipment_ID)
    REFERENCES Equipment(Equipment_ID)
);

