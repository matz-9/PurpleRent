select nome,cognome,numDocumento,età,datiBancari,sedeRitiro,SedeRilascio
from prenotazione,clienteNoleggio
where prenotazione.numeroPrenotazione=7003
    and prenotazione.cliente=clienteNoleggio.numDocumento;

select targa, sede, casaAuto ,km
from AutovetturaNoleggiabile as vettura, Sede, sedeAttuale
where vettura.targa = sedeAttuale.autovetturaN
    and sedeAttuale.sede = Sede.codiceMnemonico
    and vettura.disponibile = true;
