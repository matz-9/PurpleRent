select nome,cognome,numDocumento,età,datiBancari,sedeRitiro,SedeRilascio
  from prenotazione,clienteNoleggio
    where prenotazione.numeroPrenotazione=7003
      and prenotazione.cliente=clienteNoleggio.numDocumento;

select targa, sede, casaAuto ,km
  from AutovetturaNoleggiabile as an, Sede, sedeAttuale
    where an.targa = sedeAttuale.autovetturaN
      and sedeAttuale.sede = Sede.codiceMnemonico
        and an.disponibile = true;
