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
    select numeroLettera,kmPercorsi,tipo,prenotazione,targa
    from LetteraNoleggio,AutovetturaNoleggiabile
    where LetteraNoleggio.numeroLettera=l
      and noleggioAutovetturaNoleggiabile.contratto  = LetteraNoleggio.numeroLettera
      and noleggioAutovetturaNoleggiabile.autovetturaN = AutovetturaNoleggiabile.targa
    UNION
    select numeroLettera,kmPercorsi,tipo,prenotazione,targa
    from LetteraNoleggio,AutovetturaVendita
    where LetteraNoleggio.numeroLettera=l
      and noleggioAutovetturaVendita.contratto = LetteraNoleggio.numeroLettera
      and
  END//
DELIMITER ;

+---------------+------------+--------+--------------+---------+
| numeroLettera | kmPercorsi | tipo   | prenotazione | targa   |
+---------------+------------+--------+--------------+---------+
| L00011        |       1300 | chiusa | P07011       | FA101MM |
| L00011        |       1300 | chiusa | P07011       | FB392TT |
| L00011        |       1300 | chiusa | P07011       | FP445PM |
| L00011        |       1300 | chiusa | P07011       | FC552KM |
| L00011        |       1300 | chiusa | P07011       | FW830IO |
| L00011        |       1300 | chiusa | P07011       | FR249GG |
| L00011        |       1300 | chiusa | P07011       | FK597FM |
| L00011        |       1300 | chiusa | P07011       | FF483AB |
| L00011        |       1300 | chiusa | P07011       | FQ647JK |
| L00011        |       1300 | chiusa | P07011       | FZ142PG |
| L00011        |       1300 | chiusa | P07011       | EC642KM |
| L00011        |       1300 | chiusa | P07011       | EW520IO |
| L00011        |       1300 | chiusa | P07011       | EB122TT |
| L00011        |       1300 | chiusa | P07011       | EK647FM |
| L00011        |       1300 | chiusa | P07011       | ER245GG |
| L00011        |       1300 | chiusa | P07011       | EQ227JK |
| L00011        |       1300 | chiusa | P07011       | EP443PM |
| L00011        |       1300 | chiusa | P07011       | EF813AB |
| L00011        |       1300 | chiusa | P07011       | EZ132PG |
| L00011        |       1300 | chiusa | P07011       | EA541MM |
+---------------+------------+--------+--------------+---------+
20 rows in set (0.01 sec)
-- call creaPrenotazione(7013 , '2020-04-05 09:11' , '2020-04-09 09:11' , '61040' ,
--  '41261' , 'RJ51230KL7' , 'L');//


-- operazione 4
-- crea un lettera di noleggio associata ad una prenotazione,
-- assegnando  una autovettura ( aggiornando la disponibilità attuale )
-- e i dati bancari per il pagamento.
DELIMITER $$
















-- CREATE FUNCTION CiaoMondo(ciao varchar(3)) RETURNS VARCHAR(3) deterministic
  -- BEGIN
    -- RETURN (ciao);
  -- END$$
