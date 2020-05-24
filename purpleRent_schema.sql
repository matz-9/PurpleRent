create table Sede(
  codiceMnemonico character(5) primary key,
  orarioApertura time,
  orarioChiusura time,
  telefono bigInt,
  email varchar(30)
);

create table Dipendente(
  id int primary key,
  nome varchar(12),
  cognome varchar(12),
  anniAnzianità int,
  sede character(5) not null,
  foreign key (sede) references Sede(codiceMnemonico)
);

create table ClienteNoleggio(
  
);

create table sedePreferita(
  cliente int primary key
  sede
);
