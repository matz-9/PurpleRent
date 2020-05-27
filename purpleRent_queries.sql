select sedeRitiro,SedeRilascio,nome,cognome,numDocumento,età,datiBancari
  from prenotazione,clienteNoleggio
    where prenotazione.numeroPrenotazione=7003
      and prenotazione.cliente=clienteNoleggio.numDocumento;
