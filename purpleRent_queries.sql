
select targa, sede, casaAuto ,km
from AutovetturaNoleggiabile as vettura, Sede, sedeAttuale
where vettura.targa = sedeAttuale.autovetturaN
    and sedeAttuale.sede = Sede.codiceMnemonico
    and vettura.disponibile = true;


-- operazione 1
DELIMITER //
create procedure visualizzaPrenotazione(p varchar(5))
  BEGIN
    select nome, cognome, numDocumento, sedeRitiro, sedeRilascio
    from prenotazione, clienteNoleggio
    where prenotazione.cliente = clienteNoleggio.numDocumento
          and p = prenotazione.numeroPrenotazione;
  END//
-- operazione 2
DELIMITER //
create procedure creaPrenotazione(np character(6), oi dateTime, of dateTime
)
  BEGIN

-- cliente,sedeRitiro,sedeRilascio,carGroup <--- input creaPren

-- CREATE FUNCTION CiaoMondo(ciao varchar(3)) RETURNS VARCHAR(3) deterministic
  -- BEGIN
    -- RETURN (ciao);
  -- END$$
