create table Sede(
  codiceMnemonico character(5) primary key,
  orarioApertura time not null,
  orarioChiusura time not null,
  telefono character(10) not null,
  email varchar(30) not null
);

create table Dipendente(
  id int primary key,
  nome varchar(12) not null,
  cognome varchar(12) not null,
  anniAnzianità int,
  sede character(5) not null,
  foreign key (sede) references Sede(codiceMnemonico) on delete cascade
);

create table CarGroup(
  lettera char primary key,
  prezzoGiornaliero int not null
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
  circuito enum('visa', 'mastercard', 'american express', 'diner') not null,
  nomeBanca varchar(15) not null
);

create table ClienteNoleggio(
  numDocumento varchar(10) primary key,
  nome varchar(12) not null,
  cognome varchar(12) not null,
  età int not null,
  datiBancari character(10) not null,
  foreign key (datiBancari) references DatiBancari(contoCorrente) on delete cascade
);

create table sedePreferita(
  cliente varchar(10) primary key,
  sede character(5),
  foreign key (cliente) references ClienteNoleggio(numDocumento) on delete cascade,
  foreign key (sede) references Sede(codiceMnemonico) on delete cascade
);

create table Prenotazione(
  numeroPrenotazione varchar(6) primary key,
  orarioInizio dateTime not null,
  orarioFine dateTime not null,
  prezzo decimal(5,2) not null,
  sedeRitiro character(5) not null,
  sedeRilascio character(5) not null,
  cliente varchar(10) not null,
  carGroup char not null,
  foreign key (sedeRitiro) references Sede(codiceMnemonico) on delete cascade,
  foreign key (sedeRilascio) references Sede(codiceMnemonico) on delete cascade,
  foreign key (cliente) references ClienteNoleggio(numDocumento) on delete cascade,
  foreign key (carGroup) references CarGroup(lettera) on delete cascade
);

create table LetteraNoleggio(
  numeroLettera varchar(6) primary key,
  kmPercorsi int,
  tipo enum("aperta", "chiusa") not null,
  prenotazione varchar(6) unique not null,
  datiBancari character(10) not null,
  foreign key (prenotazione) references Prenotazione(numeroPrenotazione) on delete cascade,
  foreign key (datiBancari) references DatiBancari(contoCorrente) on delete cascade
);

create table Feedback(
  noleggio varchar(6) primary key,
  recensione text,
  voto integer not null,
  foreign key (noleggio) references LetteraNoleggio(numeroLettera) on delete cascade,
  check (voto>=0 AND voto<=5)
);

create table indirizzoSede(
  sede character(5) primary key,
  città varchar(20) not null,
  civico int not null,
  via varchar(30) not null,
  unique (città, civico, via),
  foreign key (sede) references Sede(codiceMnemonico) on delete cascade,
  foreign key (città, civico, via) references Indirizzo(città, civico, via)
  on delete cascade
);

create table residenzaCliente(
  cliente varchar(10) primary key,
  città varchar(20) not null,
  civico int not null,
  via varchar(30) not null,
  unique (città,civico,via),
  foreign key (cliente) references ClienteNoleggio(numDocumento) on delete cascade,
  foreign key (città, civico, via) references Indirizzo(città, civico, via) on delete cascade
);

create table CasaAutomobilistica(
  nome varchar(15) primary key,
  nazione varchar(10) not null
);

create table AutovetturaNoleggiabile(
  targa character(7) primary key,
  km int not null,
  colore enum('blu', 'verde', 'viola', 'nero', 'bianco',
              'grigio', 'giallo', 'rosso', 'arancione') not null,
  disponibile boolean not null,
  carGroup char not null,
  casaAuto varchar(15) not null,
  foreign key (carGroup) references CarGroup(lettera) on delete cascade,
  foreign key (casaAuto) references CasaAutomobilistica(nome) on delete cascade
);

create table AutovetturaVendita(
  targa character(7) primary key,
  km int not null,
  colore enum('blu', 'verde', 'viola', 'nero', 'bianco',
              'grigio', 'giallo', 'rosso', 'arancione') not null,
  prezzoVendita decimal(6,2),
  carGroup char not null,
  casaAuto varchar(15) not null,
  foreign key (carGroup) references CarGroup(lettera) on delete cascade,
  foreign key (casaAuto) references CasaAutomobilistica(nome) on delete cascade
);

create table AcquirenteVetturaUsata(
  nomeAzienda varchar(15) primary key,
  partitaIva character(11) not null,
  telefono bigInt not null,
  datiBancari character(10) unique not null,
  foreign key (datiBancari) references DatiBancari(contoCorrente) on delete cascade
);

create table Fornitore(
  nomeAziendaFornitore varchar(20) primary key,
  partitaIva character(11) not null,
  telefono bigInt not null,
  datiBancari character(10) unique not null,
  foreign key (datiBancari) references DatiBancari(contoCorrente) on delete cascade
);

create table sedeAttuale(
  autovetturaN character(7) primary key,
  sede character(5) not null,
  foreign key (autovetturaN) references AutovetturaNoleggiabile(targa) on delete cascade,
  foreign key (sede) references Sede(codiceMnemonico) on delete cascade
);

create table noleggioAutovetturaNoleggiabile(
  contratto varchar(6) primary key,
  autovetturaN character(7) not null,
  foreign key (contratto) references LetteraNoleggio(numeroLettera) on delete cascade,
  foreign key (autovetturaN) references AutovetturaNoleggiabile(targa) on delete cascade
);

create table noleggioAutovetturaVendita(
  contratto varchar(6) primary key,
  autovetturaV character(7) not null,
  foreign key (contratto) references LetteraNoleggio(numeroLettera) on delete cascade,
  foreign key (autovetturaV) references AutovetturaVendita(targa) on delete cascade
);

create table Officina(
  nome varchar(15) primary key,
  orarioApertura time(1) not null,
  orarioChiusura time(1) not null,
  numTel character(10) not null,
  email varchar(30) not null
);

create table RiparazioniEffettuate(
  numeroRip character(5) primary key,
  data date not null,
  motivazione text not null,
  costo decimal(5,2) not null,
  officina varchar(15) not null,
  partiSostituite varchar(20),
  foreign key (officina) references Officina(nome) on delete cascade
);

create table RicambiVettura(
  idRicambio character(5) primary key,
  ricambio varchar(20)
);

create table sostituzione(
  numeroRiparazione character(5),
  partiSostituite varchar(20),
  primary key(numeroRiparazione,partiSostituite),
  foreign key (numeroRiparazione) references RiparazioniEffettuate(numeroRip)
  on delete cascade,
  foreign key (partiSostituite) references RicambiVettura(idRicambio)
  on delete cascade
);

create table riparazioneAutovetturaN(
  riparazione character(5) primary key,
  autovetturaN character(7) not null,
  foreign key (riparazione) references RiparazioniEffettuate(numeroRip) on
  delete cascade,
  foreign key (autovetturaN) references AutovetturaNoleggiabile(targa) on
  delete cascade
);

create table riparazioneAutovetturaV(
  riparazione character(5) primary key,
  autovetturaV character(7) not null,
  foreign key (autovetturaV) references AutovetturaVendita(targa) on delete cascade,
  foreign key (riparazione) references RiparazioniEffettuate(numeroRip) on delete cascade
);

create table indirizzoOfficina(
  officina varchar(15) primary key,
  città varchar(20) not null,
  civico int not null,
  via varchar(30) not null,
  unique (città, civico, via),
  foreign key (officina) references Officina(nome) on delete cascade,
  foreign key (città, civico, via) references Indirizzo(città, civico, via) on delete cascade
);

create table FatturaVendita(
  numeroFattura character(7) primary key,
  importo decimal(9,2) not null,
  data date not null,
  autovettura character(7) not null,
  acquirente varchar(15) not null,
  foreign key (autovettura) references AutovetturaVendita(targa) on delete cascade,
  foreign key (acquirente) references AcquirenteVetturaUsata(nomeAzienda) on delete cascade
);

create table FatturaAcquisto(
  numeroFattura character(7) primary key,
  importo decimal(9,2) not null,
  data date not null,
  numVetture int not null,
  fornitore varchar(20) not null,
  foreign key (fornitore) references Fornitore(nomeAziendaFornitore) on delete cascade
);

create table acquistoAutovetturaNoleggiabili(
  fatturaN character(7) not null,
  autovetturaN character(7) primary key,
  foreign key (fatturaN) references FatturaAcquisto(numeroFattura) on delete cascade,
  foreign key (autovetturaN) references AutovetturaNoleggiabile(targa) on
  delete cascade
);

create table acquistoAutovetturaVendita(
  fatturaV character(7) not null,
  autovetturaV character(7) primary key,
  foreign key (fatturaV) references FatturaAcquisto(numeroFattura) on delete cascade,
  foreign key (autovetturaV) references AutovetturaVendita(targa) on delete cascade
);

create table fornitoreCarGroup(
  fornitore varchar(20),
  carGroup char,
  primary key (fornitore, carGroup),
  foreign key (fornitore) references Fornitore(nomeAziendaFornitore) on delete cascade,
  foreign key (carGroup) references CarGroup(lettera) on delete cascade
);

create table fornitoreCasa(
  fornitore varchar(20),
  casa varchar(15),
  primary key (fornitore, casa),
  foreign key (fornitore) references Fornitore(nomeAziendaFornitore) on delete cascade,
  foreign key (casa) references CasaAutomobilistica(nome) on delete cascade
);

create table indirizzoFornitore(
  fornitore varchar(20) primary key,
  città varchar(20) not null,
  civico int not null,
  via varchar(30) not null,
  unique (città, civico, via),
  foreign key (fornitore) references Fornitore(nomeAziendaFornitore) on delete cascade,
  foreign key (città, civico, via) references Indirizzo(città, civico, via) on delete cascade
);

create table indirizzoAcquirente(
  acquirente varchar(15) primary key,
  città varchar(20) not null,
  civico int not null,
  via varchar(30) not null,
  unique (città, civico, via),
  foreign key (acquirente) references AcquirenteVetturaUsata(nomeAzienda) on delete cascade,
  foreign key (città, civico, via) references Indirizzo(città, civico, via) on delete cascade
);

create table tmpAutovetturaContratti(
  numeroLettera varchar(6) primary key,
  targa character(7) not null
);


-- --------------------------------TRIGGER--------------------------------------



-- TRIGGER per vincolo 6
-- L’attributo attualmente disponibile dell’entità Autovettura Noleggiabile deve essere
-- settato a false quando un’autovettura viene assegnata a un contratto di noleggio.

DELIMITER //
create trigger attualmenteDisponibile
  after insert on noleggioAutovetturaNoleggiabile
  for each row
  BEGIN
    update AutovetturaNoleggiabile
    set AutovetturaNoleggiabile.disponibile = false
    where AutovetturaNoleggiabile.targa = new.autovetturaN;
  END //
DELIMITER ;



-- TRIGGER per vincolo 6
--
DELIMITER //
create trigger cliente21anni
  before insert on ClienteNoleggio
  for each row
  BEGIN
    if (new.età < 21) then
      signal sqlstate '45000'
      set message_text = 'Errore: età cliente non conforme al regolamento';
    end if ;
  END //
DELIMITER ;





DELIMITER //
create trigger dataPrenotazione
  before insert on Prenotazione
  for each row
  BEGIN
    if (new.orarioInizio > new.orarioFine) then
      signal sqlstate '45000'
      set message_text = 'Errore: data inizio prenotazione successiva a data fine';
    end if ;
  END //
DELIMITER ;



-- TRIGGER per il vincolo
DELIMITER //
create trigger vendiVetturaVecchia
  after update on AutovetturaNoleggiabile
  for each row
  BEGIN
      if(new.km > 150000) then
        insert into AutovetturaVendita values (new.targa, new.km, new.colore,
                                               null, new.cargroup, new.casaAuto);
        insert into noleggioAutovetturaVendita values (
                          (select numeroLettera from tmpAutovetturaContratti),
                          (select targa from tmpAutovetturaContratti));
        delete from tmpAutovetturaContratti;
      end if;
  END //
DELIMITER ;




-- TRIGGER vincoli 4-7

-- Dopo la chiusura di un contratto il chilometraggio delle vetture deve essere aggiornato
-- con i km percorsi dal cliente.

-- L’attributo attualmente disponibile dell’entità Autovettura Noleggiabile associata
-- ad un contratto di noleggio deve essere settato a true quando il contratto viene chiuso.

DELIMITER //
create trigger chiusuraContratto
  after update on LetteraNoleggio
  for each row
  BEGIN
    declare targaSelect character(7);
    declare kmtot int;

    set targaSelect = (select targa
                       from noleggioAutovetturaNoleggiabile as na, AutovetturaNoleggiabile as a
                        where new.numeroLettera = na.contratto
                          and a.targa = na.autovetturaN);

    if (new.tipo = 'chiusa') then
      update AutovetturaNoleggiabile
      set km = km + new.kmPercorsi,
          disponibile = true
      where targa = targaSelect;
    end if;

    set kmtot = (select km
                  from noleggioAutovetturaNoleggiabile as na, AutovetturaNoleggiabile as a
                  where new.numeroLettera = na.contratto
                  and a.targa = na.autovetturaN);
    if(kmtot >= 150000) then
      insert into tmpAutovetturaContratti values (new.numeroLettera, targaSelect);
      delete
      from AutovetturaNoleggiabile
      where AutovetturaNoleggiabile.targa = targaSelect;

    end if;
  END //
DELIMITER ;
