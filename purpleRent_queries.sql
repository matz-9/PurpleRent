
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





-------------------------- OPERAZIONE 7 -------------------------------
-- identifica il car group più richiesto nel 2019
DELIMITER //
create procedure carGroupPiuRichiesto()
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

    drop view prenotazioni;
  END//
DELIMITER ;
-- call carGroupPiuRichiesto();
-- ----------------------------------------------------------------------





-------------------------- OPERAZIONE 8 -------------------------------














-- CREATE FUNCTION CiaoMondo(ciao varchar(3)) RETURNS VARCHAR(3) deterministic
  -- BEGIN
    -- RETURN (ciao);
  -- END$$
