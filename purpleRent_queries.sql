-- operazione 1 visualizza, data una prenotazione, dati cliente e sedi associate

DELIMITER //
create procedure visualizzaPrenotazione(p varchar(5))
  BEGIN
    select nome, cognome, numDocumento, sedeRitiro, sedeRilascio
    from prenotazione, clienteNoleggio
    where prenotazione.cliente = clienteNoleggio.numDocumento
          and p = prenotazione.numeroPrenotazione;
  END//
DELIMITER ;

-- operazione 2 effettua una prenotazione

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
    Declare prezzo decimal(5,2);
    set prezzo = (select calcolaPrezzo(gruppo, orarioIn, orarioFi));
    insert into prenotazione values (
      numeroP, orarioIn, orarioFi, prezzo,
        sedeRit, sedeRil, cliente, gruppo);
  END //
DELIMITER ;

-- operazione 3 visualizza lettera di noleggio,prenotazione associata e autovettura assegnata

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


-- operazione 4
-- crea un lettera di noleggio associata ad una prenotazione,
-- assegnando  una autovettura ( aggiornando la disponibilità attuale )
-- e i dati bancari per il pagamento.
DELIMITER //
  create trigger attualmenteDisponibile
    after insert on noleggioAutovetturaNoleggiabile
    for each row
    BEGIN
      update AutovetturaNoleggiabile
      set disponibile = false
      where AutovetturaNoleggiabile.targa = new.autovetturaN;
    END //
DELIMITER ;

DELIMITER //
create procedure creaLetteraNoleggio(numeroLettera varchar(6), kmPercorsi int, tipo enum("aperta", "chiusa"),
                                      prenotazione varchar(6),datiBancari character(10))
  BEGIN
    insert into LetteraNoleggio values(numeroLettera, kmPercorsi, tipo, prenotazione, datiBancari);

    insert into noleggioAutovetturaNoleggiabile values
      (numeroLettera, (select targa
                        from AutovetturaNoleggiabile as aN, Prenotazione as p
                        where aN.disponibile = true
                              and p.numeroPrenotazione =  prenotazione
                              and aN.carGroup = p.carGroup
                        limit 1));

  END //
DELIMITER ;
-- call creaPrenotazione('P07013' , '2020-04-05 09:11' , '2020-04-09 09:11' , '61040' ,'41261' , 'RJ51230KL7' , 'L');
-- call creaLetteraNoleggio('L00013', null, 'aperta', 'P07013', '1233958372');

-- operazione 5
-- trova fornitori che vendono un’autovettura di un dato marchio con un dato gruppo
DELIMITER //
  create procedure trovaFornitori(gruppo char,casa varchar(15))
  BEGIN
    select nomeAziendaFornitore
    from fornitore, fornitoreCasa, fornitoreCarGroup
    where fornitoreCarGroup.fornitore = fornitore.nomeAziendaFornitore and
          fornitoreCasa.fornitore = fornitore.nomeAziendaFornitore and
          fornitoreCarGroup.carGroup = gruppo and fornitoreCasa.casa = casa;
  END //
DELIMITER ;

-- operazione 6
-- estrai il nome della sede con il maggior numero di ritiri autovetture
delimiter //
create procedure trovaSedeMaxRitiri()
  begin
    create view ritiri(sede,città,num)
      as
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
















-- CREATE FUNCTION CiaoMondo(ciao varchar(3)) RETURNS VARCHAR(3) deterministic
  -- BEGIN
    -- RETURN (ciao);
  -- END$$
