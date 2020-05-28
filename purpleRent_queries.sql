
-- -------------------------- OPERAZIONE 1 -------------------------------
-- visualizza, data una prenotazione, dati cliente e sedi associate

DELIMITER //
create procedure visualizzaPrenotazione(p varchar(5))
  BEGIN
    select nome, cognome, numDocumento, sedeRitiro, sedeRilascio
    from prenotazione, clienteNoleggio
    where prenotazione.cliente = clienteNoleggio.numDocumento
          and p = prenotazione.numeroPrenotazione;
  END//
DELIMITER ;
-- ----------------------------------------------------------------------





-- -------------------------- OPERAZIONE 2 -------------------------------
-- effettua una prenotazione

DELIMITER //
create FUNCTION calcolaPrezzo(gruppo char, inizio dateTime, fine dateTime)
    RETURNS int deterministic
  BEGIN
    Declare prezzo int;
    set prezzo = (select prezzoGiornaliero
                  from carGroup
                  where gruppo = carGroup.lettera);
    RETURN (prezzo * dateDiff(fine, inizio));
  END //
DELIMITER ;

DELIMITER //
create procedure creaPrenotazione(numeroP character(6), orarioIn dateTime, orarioFi dateTime,
  sedeRit character(5), sedeRil character(5), cliente varchar(10), gruppo char)
  BEGIN
    declare prezzo decimal(5,2);
    set prezzo = (select calcolaPrezzo(gruppo, orarioIn, orarioFi));
    insert into prenotazione values (
      numeroP, orarioIn, orarioFi, prezzo,
        sedeRit, sedeRil, cliente, gruppo);
  END //
DELIMITER ;
-- ----------------------------------------------------------------------





-- -------------------------- OPERAZIONE 3 -------------------------------
-- visualizza lettera di noleggio,prenotazione associata e autovettura assegnata

DELIMITER //
create procedure visualizzaContratto(l varchar(6))
  BEGIN
    select numeroLettera, kmPercorsi, tipo, prenotazione, targa, casaAuto
    from LetteraNoleggio, AutovetturaNoleggiabile, noleggioAutovetturaNoleggiabile
    where noleggioAutovetturaNoleggiabile.contratto  = l
      and LetteraNoleggio.numeroLettera = l
      and noleggioAutovetturaNoleggiabile.autovetturaN = AutovetturaNoleggiabile.targa
    UNION
    select numeroLettera,kmPercorsi,tipo,prenotazione,targa,casaAuto
    from LetteraNoleggio,AutovetturaVendita, noleggioAutovetturaVendita
    where noleggioAutovetturaVendita.contratto = l
      and LetteraNoleggio.numeroLettera = l
      and noleggioAutovetturaVendita.autovetturaV = AutovetturaVendita.targa;
  END//
DELIMITER ;

-- call creaPrenotazione(7013 , '2020-04-05 09:11' , '2020-04-09 09:11' , '61040' ,
--  '41261' , 'RJ51230KL7' , 'L');//
-- ----------------------------------------------------------------------





-- ---------------------------- TRIGGER ---------------------------------
-- trigger per rendere un'autovettura non disponibile quando si crea un contratto
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
-- ----------------------------------------------------------------------





-- -------------------------- OPERAZIONE 4 -------------------------------
-- crea un lettera di noleggio associata ad una prenotazione,
-- assegnando  una autovettura ( aggiornando la disponibilità attuale )
-- e i dati bancari per il pagamento.
DELIMITER //
create procedure creaLetteraNoleggio(numeroLettera varchar(6), kmPercorsi int, tipo enum("aperta", "chiusa"),
                                      prenotazione varchar(6),datiBancari character(10))
  BEGIN
    declare automobile character(7);
    set automobile = (select targa
                      from AutovetturaNoleggiabile as aN, Prenotazione as pr
                      where aN.disponibile = true
                          and pr.numeroPrenotazione = prenotazione
                          and aN.carGroup = pr.carGroup
                      limit 1);

    insert into LetteraNoleggio values(numeroLettera, kmPercorsi, tipo, prenotazione, datiBancari);
    insert into noleggioAutovetturaNoleggiabile values(numeroLettera, automobile);

  END//
DELIMITER ;
-- call creaPrenotazione('P07013' , '2020-04-05 09:11' , '2020-04-09 09:11' , '61040' ,'41261' , 'RJ51230KL7' , 'L');
-- call creaLetteraNoleggio('L00013', null, 'aperta', 'P07013', '1233958372');
-- FUNZIONA DIO BONOOOOOOOOOOOOOOOOOOOOOOOOOOOO
-- ----------------------------------------------------------------------





-- -------------------------- OPERAZIONE 5 -------------------------------
-- trova fornitori che vendono un’autovettura BMW gruppo H
DELIMITER //
  create procedure trovaFornitori()
  BEGIN
    select nomeAziendaFornitore
    from fornitore, fornitoreCasa, fornitoreCarGroup
    where fornitoreCarGroup.fornitore = fornitore.nomeAziendaFornitore and
          fornitoreCasa.fornitore = fornitore.nomeAziendaFornitore and
          fornitoreCarGroup.carGroup = 'H' and fornitoreCasa.casa = 'BMW';
  END //
DELIMITER ;
-- ----------------------------------------------------------------------





-- -------------------------- OPERAZIONE 6 -------------------------------
-- estrai il nome della sede con il maggior numero di ritiri autovetture
DELIMITER //
create procedure trovaSedeMaxRitiri()
  BEGIN
    create view ritiri(sede,città,num) as
        select sede,città,count(*) as num
        from prenotazione,indirizzoSede
        where prenotazione.sedeRitiro=indirizzoSede.sede
        group by sedeRitiro;
    select *
    from ritiri
    where ritiri.num= ( select max(num)
                        from ritiri );
    drop view ritiri;
  END//
DELIMITER ;
-- ----------------------------------------------------------------------





-- -------------------------- OPERAZIONE 7 -------------------------------
-- identifica il car group più richiesto nel 2019
DELIMITER //
create procedure carGroupPiuRichiesto(out carg char) -- con "out" si indica la var in cui salvo il risultato
  BEGIN
    create view prenotazioni(carGroup, prenotato) as
        select carGroup, count(*) as prenotato
        from Prenotazione
        where year(Prenotazione.orarioInizio) = 2019
        group by carGroup;

    select *
    from prenotazioni
    where prenotato = (select max(prenotato)
                       from prenotazioni);
    select carGroup
    into carg -- il risultato viene salvato dentro carg
    from prenotazioni
    where prenotato = (select max(prenotato)
                       from prenotazioni);

    drop view prenotazioni;
  END//
DELIMITER ;
-- call carGroupPiuRichiesto();
-- ----------------------------------------------------------------------





-- -------------------------- OPERAZIONE 8 -------------------------------
-- estrai i nomi delle aziende che hanno fornito le vetture del car group più richiesto nel 2019 (operazione 7)
DELIMITER //
create procedure aziendaTopCarGroup()
  BEGIN

    call carGroupPiuRichiesto(@res);

    select targa, f.nomeAziendaFornitore
    from AutovetturaNoleggiabile as aN, acquistoAutovetturaNoleggiabili as aAn, FatturaAcquisto as fA, Fornitore as f
    where aN.carGroup = (select @res)
          and aAn.autovetturaN = aN.targa
          and aAn.fatturaN = fA.numeroFattura
          and f.nomeAziendaFornitore = fA.fornitore
    UNION
    select targa, f.nomeAziendaFornitore
    from AutovetturaVendita as aV, acquistoAutovetturaVendita as aAv, FatturaAcquisto as fA, Fornitore as f
    where aV.carGroup = (select @res)
          and aAv.autovetturaV = aV.targa
          and aAv.fatturaV = fA.numeroFattura
          and f.nomeAziendaFornitore = fA.fornitore;

  END//
DELIMITER ;
-- call aziendaTopCarGroup();
-- ----------------------------------------------------------------------






-- -------------------------- OPERAZIONE 9 -------------------------------
-- l’azienda deve riscuotere il pagamento relativo ad un noleggio:
-- estrai il numero del conto corrente associato ad una lettera di noleggio
DELIMITER //
create procedure estraiConto(contratto varchar(6))
  BEGIN
    select nome, cognome, LetteraNoleggio.datiBancari, numeroLettera
    from LetteraNoleggio, ClienteNoleggio
    where LetteraNoleggio.numeroLettera = contratto
          and ClienteNoleggio.datiBancari = LetteraNoleggio.datiBancari; -- omissibile
  END//
DELIMITER ;
-- call estraiConto('L00006');
-- ----------------------------------------------------------------------





-- -------------------------- OPERAZIONE 10 -------------------------------
-- varia i prezzi di tutti i car group per una certa cifra:
-- l'operazione consiste nell'inserire come input di una procedura il numero
-- int che sarà l'aggiunta sul prezzo del car group in base alla Lettera
DELIMITER //
create procedure modificaPrezzo(aggiunta int)
  BEGIN
    update carGroup set prezzoGiornaliero = prezzoGiornaliero + aggiunta
  END//
DELIMITER ;
-- call modificaPrezzo(20);

-- ----------------------------------------------------------------------





-- -------------------------- OPERAZIONE 11 -------------------------------
-- Calcola la somma del denaro previsto incassato dalle prenotazioni
-- nell’ultimo anno per ogni tipologia di Car group

DELIMITER //
create procedure incassoCarGroup()
  BEGIN
    select carGroup, sum(prezzo) as totale
    from Prenotazione
    where year(Prenotazione.orarioInizio) = 2019
    group by carGroup;
  END//
DELIMITER ;
-- call incassoCarGroup();
-- ----------------------------------------------------------------------


-------------------------- OPERAZIONE 12 -------------------------------
-- L’azienda propone delle offerte : reperisci i contatti telefonici
-- dei clienti che hanno noleggiato nell’ultimo anno con almeno due
-- prenotazioni e con età maggiore di 45.

DELIMITER //
create procedure clientiFidati()
  BEGIN
    create view clientePrenotazione(cliente,pren) as
        select cliente, count(*) as pren
        from Prenotazione
        group by cliente;

        select nome,cognome,pren
        from ClienteNoleggio,clientePrenotazione
        where pren >= 2
          and clientePrenotazione.cliente = ClienteNoleggio.numDocumento;

        drop view clientePrenotazione;
  END //

  DELIMITER ;

  -- call clientiFidati();

-- ------------------------------------------------------------------------

-- -------------------------- OPERAZIONE 13 -------------------------------
-- verifica la sede attuale di un'autovettura
-- l'operazione consiste nell'inserire in input ad una procedura trovaSede()
-- il varchar targa per trovare la rispettiva sede in cui è disponibile, essendo
-- un'autovettura AutovetturaNoleggiabile
-- nel caso in cui la targa appartenga ad un'autovettura in vendita la procedura
-- deve restituire un empity set
DELIMITER //
create procedure trovaSede(targauto char(7))
  BEGIN
    select sedeattuale.sede,città
    from sedeattuale,indirizzosede,autovetturanoleggiabile
    where autovetturanoleggiabile.targa=sedeattuale.autovetturaN and
    sedeattuale.sede=indirizzosede.sede and autovetturanoleggiabile.targa=targauto;
  END //
  DELIMITER ;
-- CALL trovaSede('op560po');
-- ----------------------------------------------------------------------



-- -------------------------- OPERAZIONE 14 -------------------------------
-- Individua la casa automobilistica a cui appartengono il maggior numero di
-- autovetture noleggiabili della flotta dell’azienda

DELIMITER //
create procedure casaAutoFlotta()
  BEGIN
    create view totxCasa(carGroup, totale) as
      select casaAuto, count(*) as totale
      from AutovetturaNoleggiabile
      group by casaAuto;

    select *
    from totxCasa
    where totale = ( select max(totale)
                      from totxCasa);

    drop view totxCasa;
  END//
DELIMITER ;
-- call casaAutoFlotta();
-- ----------------------------------------------------------------------





-- -------------------------- OPERAZIONE 15 -------------------------------
-- Estrai i nomi e p.iva delle aziende che hanno acquistato vetture con una fattura
-- di valore superiore a 10.000 euro
DELIMITER //
create procedure fattureDieciK()
  BEGIN
    select distinct nomeAzienda
    from FatturaVendita as f, AcquirenteVetturaUsata as a
    where importo >= 10000 and a.nomeAzienda = f.acquirente;
  END//
DELIMITER ;
-- call fattureDieciK();
-- ----------------------------------------------------------------------





-- -------------------------- OPERAZIONE 16 -------------------------------
-- Estrai i nomi e p.iva delle aziende che hanno acquistato vetture con una fattura
-- di valore superiore a 10.000 euro
DELIMITER //
create procedure ()
  BEGIN

  END//
DELIMITER ;
-- call fattureDieciK();
-- ----------------------------------------------------------------------



-- CREATE FUNCTION CiaoMondo(ciao varchar(3)) RETURNS VARCHAR(3) deterministic
  -- BEGIN
    -- RETURN (ciao);
  -- END$$
-- -------------------------- OPERAZIONE 17 -------------------------------
-- Cambia la sede attuale di un’autovettura
-- l'operazione consiste nel cambiare la sede con una sede data in input ad una
-- procedura cambiaSede()
DELIMITER //
create procedure cambiaSede(newS char(5),targ char(7) )
  BEGIN
    update sedeattuale set sede = newS where autovetturaN=targ;
  END//
DELIMITER ;
-- CALL cambiaSede('61031','FQ647JK);
-- ----------------------------------------------------------------------


-- -------------------------- OPERAZIONE 18 ------------------------------
-- Visualizza le riparazioni effettuate su una vettura
--  in vendita, inclusa l’officina interessata

DELIMITER //
create procedure visualizzaRiparazioni(targ char(7))
  BEGIN
    select numeroRip,officina,nome,orarioApertura,orarioChiusura
    from riparazioneAutovetturaV,RiparazioniEffettuate,Officina
    where riparazioneAutovetturaV.autovetturaV = targ
      and officina.nome = RiparazioniEffettuate.officina
        and riparazioneAutovetturaV.riparazione = RiparazioniEffettuate.numeroRip;
  END //
DELIMITER;

-- call visualizzaRiparazioni('EK647FM');

-- -----------------------------------------------------------------------

-- -------------------------- OPERAZIONE 19 ------------------------------
-- Visualizza le sedi di ritiro con un voto nel feedback associato alla lettera
-- di noleggio maggiore di 4
DELIMITER //
create procedure trovaSRitiroVoto4()
  BEGIN
    select sede.codiceMnemonico,città
    from prenotazione,LetteraNoleggio,feedback,indirizzoSede
    where prenotazione.numeroPrenotazione=LetteraNoleggio.prenotazione AND
    feedback.noleggio=LetteraNoleggio.numeroLettera and
    prenotazione.sedeRitiro=indirizzoSede.sede
    sede.codiceMnemonico=prenotazione.sedeRitiro and feedback.voto>4;
  END//
  DELIMITER ;
