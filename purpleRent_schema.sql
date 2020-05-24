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
);

create table sedePreferita(
  cliente int primary key,
  sede character(5),
  foreign key cliente references ClienteNoleggio(numDocumento),
  foreign key sede references Sede(codiceMnemonico)
);

create table Prenotazione(
  numeroPrenotazione int auto_increment primary key,
  orarioInizio dateTime not null,
  orarioFine dateTime not null,
  prezzo int not null,
  sedeRitiro character(5) not null,
  sedeRilascio character(5) not null,
  cliente int not null,
  carGroup char not null,
  foreign key sedeRitiro references Sede(codiceMnemonico),
  foreign key sedeRilascio references Sede(codiceMnemonico),
  foreign key cliente references ClienteNoleggio(numDocumento),
  foreign key carGroup references CarGroup(lettera),
);

create table CarGroup(
  lettera char primary key,
  prezzoGiornaliero int
);

create table LetteraNoleggio(
  numeroLettera int auto_increment primary key,
  kmPercorsi int not null,
  tipo enum("aperta", "chiusa") not null,
  prenotazione int auto_increment not null,
  datiBancari bigInt not null,
  foreign key prenotazione references Prenotazione(numeroPrenotazione),
  foreign key datiBancari references DatiBancari(contoCorrente)
);

create table Feedback(
  noleggio int auto_increment primary key,
  voto votoInt not null,
  recensione text,
  foreign key noleggio references LetteraNoleggio(numeroLettera)
);

--vincolo di dominio riferito al voto nel feedBack
create domain votoInt as
  integer check (value >= 0 and value <= 5);

create table Indirizzo(
  città varchar(20),
  civico int,
  via varchar (30),
  cap character(5) not null,
  primary key (città, civico, via)
);

create table indirizzoSede(
  sede character(5) primary key,
  città varchar(20),
  civico int,
  via varchar(30),
  unique (città, civico, via)
  foreign key sede references Sede(codiceMnemonico)
);

create table residenzaCliente(
  cliente varchar(10) primary key,
  città varchar(20),
  civico int,
  via varchar(30),
  unique (città,civico,via),
  foreign key cliente references ClienteNoleggio(numDocumento),
  foreign key (città,civico,via) references Indirizzo(città,civico,via),
);

create table DatiBancari(
  contoCorrente bigInt primary key,
  circuito enum('visa', 'mastercard', 'american express', 'diner', 'bancoposta'),
  nomeBanca varchar(15) not null
);

create table CasaAutomobilistica(
  nome varchar(15) primary key,
  nazione varchar(10) not null
);

create table AutovetturaNoleggiabile(
  targa character(7) primary key,
  immatricolazione date not null,
  km int not null,
  colore enum('blu', 'verde', 'viola', 'nero', 'bianco',
              'grigio', 'giallo', 'rosso', 'arancione') not null,
  disponibile boolean not null,
  carGroup char not null,
  casaAuto varchar(15) not null,
  foreign key carGroup references CarGroup(lettera)
  foreign key casaAuto references CasaAutomobilistica(nome)
);

create table AutovetturaVendita(
  targa character(7) primary key,
  immatricolazione date not null,
  km int not null,
  colore enum('blu', 'verde', 'viola', 'nero', 'bianco',
              'grigio', 'giallo', 'rosso', 'arancione') not null,
  prezzoVendita int not null,
  carGroup char not null,
  casaAuto varchar(15) not null,
  foreign key carGroup references CarGroup(lettera)
  foreign key casaAuto references CasaAutomobilistica(nome)
);

create table sedeAttuale(
  autovetturaN character(7) primary key,
  sede character(5) not null,
  foreign key autovetturaN references AutovetturaNoleggiabile(targa),
  foreign key sede references Sede(codiceMnemonico)
);

create table noleggioAutovetturaNoleggiabile(
  contratto int auto_increment primary key,
  unique autovetturaN charachter(7) not null,
  foreign key contratto references LetteraNoleggio(numeroLettera),
  foreign key autovetturaN references AutovetturaNoleggiabile(targa)
);

create table noleggioAutovetturaVendita(
  contratto int auto_increment primary key,
  unique autovetturaN charachter(7) not null,
  foreign key contratto references LetteraNoleggio(numeroLettera),
  foreign key autovetturaN references AutovetturaVendita(targa)
);

create table RiparazioniEffettuate(
  numeroRip int auto_increment primary key,
  data date,
  motivazione varchar(20),
  costo decimal(4,2),
  officina varchar(15),
  foreign key officina references Officina(nome)
);
