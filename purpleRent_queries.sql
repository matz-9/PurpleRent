
select targa, sede, casaAuto ,km
from AutovetturaNoleggiabile as vettura, Sede, sedeAttuale
where vettura.targa = sedeAttuale.autovetturaN
    and sedeAttuale.sede = Sede.codiceMnemonico
    and vettura.disponibile = true;


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
    where LetteraNoleggio.numeroLettera=l;
  END//

-- call creaPrenotazione(7013 , '2020-04-05 09:11' , '2020-04-09 09:11' , '61040' ,
--  '41261' , 'RJ51230KL7' , 'L');//


-- CREATE FUNCTION CiaoMondo(ciao varchar(3)) RETURNS VARCHAR(3) deterministic
  -- BEGIN
    -- RETURN (ciao);
  -- END$$
