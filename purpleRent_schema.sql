create table Sede(
  codiceMnemonico character(5) primary key,
  orarioApertura time not null,
  orarioChiusura time not null,
  telefono bigInt not null,
  email varchar(30) not null
);

create table Dipendente(
  id int primary key,
  nome varchar(12) not null,
  cognome varchar(12) not null,
  anniAnzianità int,
  sede character(5) not null,
  foreign key sede references Sede(codiceMnemonico)
);

create table ClienteNoleggio(
  numDocumento varchar(10) primary key,
  nome varchar(12) not null,
  cognome varchar(12) not null,
  età int not null,
  datiBancari bigInt not null,
  foreign key datiBancari references DatiBancari(contoCorrente)
); *

create table sedePreferita(
  cliente int primary key,
  sede character(5),
  foreign key cliente references ClienteNoleggio(numDocumento),
  foreign key sede references Sede(codiceMnemonico)
); *

create table Prenotazione(
  numeroPrenotazione int auto_increment primary key ,
  orarioInizio dateTime,
  orarioFine dateTime,
  prezzo int,
  sedeRitiro,
  sedeRilascio,
  cliente int,
  carGroup
  foreign key
);

create table CarGroup(
  lettera,
  prezzoGiornaliero
);
