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
  foreign key (sede) references Sede(codiceMnemonico)
);

create table CarGroup(
  lettera char primary key,
  prezzoGiornaliero int
);

create table Indirizzo(
  città varchar(20) not null,
  civico int not null,
  via varchar (30) not null,
  cap character(5) not null,
  primary key (città, civico, via)
);

create table DatiBancari(
  contoCorrente character(10) primary key,
  circuito enum('visa', 'mastercard', 'american express', 'diner', 'bancoposta') not null,
  nomeBanca varchar(15) not null
);

create table ClienteNoleggio(
  numDocumento varchar(10) primary key,
  nome varchar(12) not null,
  cognome varchar(12) not null,
  età int not null,
  datiBancari character(10) not null,
  foreign key (datiBancari) references DatiBancari(contoCorrente)
);

create table sedePreferita(
  cliente varchar(10) primary key,
  sede character(5),
  foreign key (cliente) references ClienteNoleggio(numDocumento),
  foreign key (sede) references Sede(codiceMnemonico)
);

create table Prenotazione(
  numeroPrenotazione int primary key,
  orarioInizio dateTime not null,
  orarioFine dateTime not null,
  prezzo decimal(4,2) not null,
  sedeRitiro character(5) not null,
  sedeRilascio character(5) not null,
  cliente varchar(10) not null,
  carGroup char not null,
  foreign key (sedeRitiro) references Sede(codiceMnemonico),
  foreign key (sedeRilascio) references Sede(codiceMnemonico),
  foreign key (cliente) references ClienteNoleggio(numDocumento),
  foreign key (carGroup) references CarGroup(lettera)
);

create table LetteraNoleggio(
  numeroLettera int primary key,
  kmPercorsi int,
  tipo enum("aperta", "chiusa") not null,
  prenotazione int not null,
  datiBancari character(10) not null,
  foreign key (prenotazione) references Prenotazione(numeroPrenotazione),
  foreign key (datiBancari) references DatiBancari(contoCorrente)
);

create table Feedback(
  noleggio int auto_increment primary key,
  recensione text,
  voto integer not null,
  foreign key (noleggio) references LetteraNoleggio(numeroLettera),
  check (voto>=0 AND voto<=5)
);

create table indirizzoSede(
  sede character(5) primary key,
  città varchar(20) not null,
  civico int not null,
  via varchar(30) not null,
  unique (città, civico, via),
  foreign key (sede) references Sede(codiceMnemonico),
  foreign key (città, civico, via) references Indirizzo(città, civico, via)
);

create table residenzaCliente(
  cliente varchar(10) primary key,
  città varchar(20) not null,
  civico int not null,
  via varchar(30) not null,
  unique (città,civico,via),
  foreign key (cliente) references ClienteNoleggio(numDocumento),
  foreign key (città, civico, via) references Indirizzo(città, civico, via)
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
  foreign key (carGroup) references CarGroup(lettera),
  foreign key (casaAuto) references CasaAutomobilistica(nome)
);

create table AutovetturaVendita(
  targa character(7) primary key,
  immatricolazione date not null,
  km int not null,
  colore enum('blu', 'verde', 'viola', 'nero', 'bianco',
              'grigio', 'giallo', 'rosso', 'arancione') not null,
  prezzoVendita decimal(5,2) not null,
  carGroup char not null,
  casaAuto varchar(15) not null,
  foreign key (carGroup) references CarGroup(lettera),
  foreign key (casaAuto) references CasaAutomobilistica(nome)
);

create table AcquirenteVetturaUsata(
  nomeAzienda varchar(15) primary key,
  partitaIva character(11) not null,
  telefono bigInt not null,
  datiBancari character(10) unique not null,
  foreign key (datiBancari) references DatiBancari(contoCorrente)
);

create table Fornitore(
  nomeAziendaFornitore varchar(15) primary key,
  partitaIva character(11) not null,
  telefono bigInt not null,
  datiBancari character(10) unique not null,
  foreign key (datiBancari) references DatiBancari(contoCorrente)
);

create table sedeAttuale(
  autovetturaN character(7) primary key,
  sede character(5) not null,
  foreign key (autovetturaN) references AutovetturaNoleggiabile(targa),
  foreign key (sede) references Sede(codiceMnemonico)
);

create table noleggioAutovetturaNoleggiabile(
  contratto int auto_increment primary key,
  autovetturaN character(7) unique not null,
  foreign key (contratto) references LetteraNoleggio(numeroLettera),
  foreign key (autovetturaN) references AutovetturaNoleggiabile(targa)
);

create table noleggioAutovetturaVendita(
  contratto int auto_increment primary key,
  autovetturaN character(7) not null unique,
  foreign key (contratto) references LetteraNoleggio(numeroLettera),
  foreign key (autovetturaN) references AutovetturaVendita(targa)
);

create table Officina(
  nome varchar(15) primary key,
  orarioApertura time(1) not null,
  orarioChiusura time(1) not null,
  numTel bigInt not null,
  email varchar(30) not null
);

create table RiparazioniEffettuate(
  numeroRip int auto_increment primary key,
  data date not null,
  motivazione varchar(20) not null,
  costo decimal(4,2) not null,
  officina varchar(15) not null,
  foreign key (officina) references Officina(nome)
);

create table riparazioneAutovetturaN(
  riparazione int auto_increment primary key,
  autovetturaN character(7)  unique not null,
  foreign key (riparazione) references RiparazioniEffettuate(numeroRip),
  foreign key (autovetturaN) references AutovetturaNoleggiabile(targa)
);

create table riparazioneAutovetturaV(
  riparazione int auto_increment primary key,
  autovetturaV character(7) unique not null,
  foreign key (autovetturaV) references AutovetturaVendita(targa),
  foreign key (riparazione) references RiparazioniEffettuate(numeroRip)
);

create table indirizzoOfficina(
  officina varchar(15) primary key,
  città varchar(20) not null,
  civico int not null,
  via varchar(30) not null,
  unique (città, civico, via),
  foreign key (officina) references Officina(nome),
  foreign key (città, civico, via) references Indirizzo(città, civico, via)
);

create table FatturaVendita(
  numeroFattura bigInt primary key,
  importo decimal(5,2) not null,
  data date not null,
  autovettura character(7) not null,
  acquirente varchar(15) unique not null,
  foreign key (autovettura) references AutovetturaVendita(targa),
  foreign key (acquirente) references AcquirenteVetturaUsata(nomeAzienda)
);

create table FatturaAcquisto(
  nummeroFattura bigInt primary key,
  importo decimal(5,2) not null,
  data date not null,
  numVetture int not null,
  fornitore varchar(15) unique not null,
  foreign key (fornitore) references Fornitore(nomeAziendaFornitore)
);

create table acquistoAutovetturaNoleggiabili(
  fatturaN bigInt primary key,
  unique autovetturaN character(7),
  foreign key (fatturaN) references FatturaAcquisto(numeroFattura),
  foreign key (autovetturaN) references AutovetturaNoleggiabile(targa)
);

create table acquistoAutovetturaVendita(
  fatturaV bigInt primary key,
  autovetturaV character(7) unique not null,
  foreign key (fatturaV) references FatturaAcquisto(numeroFattura),
  foreign key (autovetturaV) references AutovetturaVendita(targa)
);

create table fornitoreCarGroup(
  fornitore varchar(15) primary key,
  carGroup char unique not null,
  foreign key (fornitore) references Fornitore(nomeAziendaFornitore),
  foreign key (carGroup) references CarGroup(lettera)
);

create table fornitoreCasa(
  fornitore varchar(15) primary key,
  casa varchar(15) unique not null,
  foreign key (fornitore) references Fornitore(nomeAziendaFornitore),
  foreign key (casa) references CasaAutomobilistica(nome)
);

create table indirizzoFornitore(
  fornitore varchar(15) primary key,
  città varchar(20) not null,
  civico int not null,
  via varchar(30) not null,
  unique (città, civico, via),
  foreign key (fornitore) references Fornitore(nomeAziendaFornitore),
  foreign key (città, civico, via) references Indirizzo(città, civico, via)
);

create table indirizzoAcquirente(
  acquirente varchar(15) primary key,
  città varchar(20) not null,
  civico int not null,
  via varchar(30) not null,
  unique (città, civico, via),
  foreign key (acquirente) references AcquirenteVetturaUsata(nomeAzienda),
  foreign key (città, civico, via) references Indirizzo(città, civico, via)
);
