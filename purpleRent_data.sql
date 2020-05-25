insert into Sede(codiceMnemonico,orarioApertura,orarioChiusura,telefono,email) values
  ('61040', '08:30', '19:00', 3791062597, 'pippolos@purplerent.it'),
  ('61031', '08:30', '18:30', 3798000197, 'roma@purplerent.it'),
  ('41261', '08:30', '19:00', 0863479810, 'math@purplrent.it');

insert into Dipendente(id,nome,cognome,anniAnzianità,sede) values
  (1755368, 'Filippo', 'Sardi',       20, '61040'),
  (1718223, 'Mattia',  'Mariano',     17, '61040'),
  (1891110, 'Yegor',   'Kumiscavich', 35, '41261');

insert into CarGroup(lettera,prezzoGiornaliero) values
  ('A', 9 ),
  ('C', 12),
  ('D', 14),
  ('E', 15),
  ('G', 18),
  ('J', 20),
  ('I', 22),
  ('H', 45),
  ('L', 55),
  ('K', 25),
  ('M', 40),
  ('N', 28),
  ('O', 35),
  ('P', 32);

insert into Indirizzo(città,civico,via,cap) values
  ('Roma',               '2',   'Via Ugo Bertossi',       '00159'),
  ('Milano',             '5',   'Via Alessandro Manzoni', '35126'),
  ('Roma',               '15',  'Via Regina Margherita',  '00198'),
  ('Canistro Inferiore', '2',   'Via Largo Liri',         '67050'),
  ('Roma',               '6',   'Via Mar Rosso',          '00121'),
  ('Napoli',             '73',  'Via Napoli',             '00184'),
  ('Firenze',            '6',   'Via Maremma Bucaiola',   '20199'),
  ('Pisa',               '2',   'Via della Torre',        '45009'),
  ('Roma',               '1',   'Via Tiburtina',          '00133'),
  ('Genova',             '14',  'Via degli Abeti',        '04310'),
  ('Bari',               '9',   'Via Cristian Cocco',     '11159'),
  ('Milano',             '17',  'Via piazza del Duomo',   '05409'),
  ('Roma',               '113', 'Via Salaria',            '10231'),
  ('Rieti',              '36',  'Via Virgola Mobile',     '01274');

insert into DatiBancari(contoCorrente,circuito,nomeBanca) values
  ('1233958372','visa',            'IntesaSanPaolo'),
  ('3618304719','mastercard',      'IntesaSanPaolo'),
  ('4639281049','diner',           'Mediolanum'),
  ('4730184936','visa',            'Mediolanum'),
  ('5930275641','visa',            'unicredit'),
  ('3649264281','mastercard',      'Ubi banca'),
  ('9243856384','visa',            'unicredit'),
  ('7692394913','american express','mediolanum'),
  ('5629472036','visa',            'unicredit'),
  ('1947294759','american express','ubi banca');

insert into ClienteNoleggio(numDocumento,nome,cognome,età,datiBancari) values
  ('AP1017Y890', 'Vittorio', 'Terzetti',     50, '1233958372'),
  ('BO34590P70', 'Enzo',     'Pesce',        22, '3618304719'),
  ('T946510KP4', 'Marco',    'Marchi',       35, '4639281049'),
  ('456QOP760Y', 'Filippo',  'Franceschini', 23, '4730184936'),
  ('78OPISL348', 'Guido',    'Piano',        63, '5930275641'),
  ('56UR64FVOP', 'Davide',   'Maria',        32, '3649264281'),
  ('GRT780H12L', 'Harry',    'Foreman',      43, '9243856384'),
  ('TRY79O012K', 'Guerrino', 'Di agostino',  56, '7692394913'),
  ('YR7I012KLU', 'Walter',   'Bishop',       45, '5629472036'),
  ('RJ51230KL7', 'Eric',     'Cartman',      21, '1947294759');

insert into sedePreferita(cliente,sede) values
  ('AP1017Y890', '61031'),
  ('BO34590P70', '61031'),
  ('T946510KP4', '41261'),
  ('456QOP760Y', '61040'),
  ('78OPISL348',  null),
  ('56UR64FVOP', '41261'),
  ('GRT780H12L',  null),
  ('TRY79O012K',  null),
  ('YR7I012KLU', '61040'),
  ('RJ51230KL7',  null);

insert into Prenotazione(numeroPrenotazione,orarioInizio,orarioFine,prezzo,sedeDiRitiro,sedeDiRilascio,cliente,carGroup) values
  (7001, '2018-01-14 09:00', '2018-01-18 09:00', 90.00,  '61031', '61031', 'AP1017Y890', 'E'),
  (7002, '2018-08-22 10:17', '2018-08-23 10:17', 9.00,   '41261', '41261', 'AP1017Y890', 'A'),
  (7003, '2018-04-02 15:30', '2018-04-03 15:30', 14.00,  '61040', '41261', 'TRY79O012K', 'D'),
  (7004, '2019-02-18 11:00', '2019-02-20 11:00', 24.00,  '61040', '41261', '56UR64FVOP', 'C'),
  (7005, '2019-04-22 15:00', '2019-04-24 15:00', 18.00,  '61031', '61031', '456QOP760Y', 'A'),
  (7006, '2019-03-03 10:05', '2019-03-06 10:05', 54.00,  '41261', '41261', '456QOP760Y', 'G'),
  (7007, '2019-05-05 11:15', '2019-05-06 11:15', 55.00,  '41261', '61031', '456QOP760Y', 'L'),
  (7008, '2019-04-05 12:15', '2019-04-07 12:15', 110.00, '41261', '61031', '456QOP760Y', 'L'),
  (7009, '2019-06-25 17:30', '2019-06-26 17:30', 20.00,  '61031', '61031', 'GRT780H12L', 'J'),
  (7010, '2019-04-09 17:00', '2019-04-18 17:00', 81.00,  '61040', '61031', 'TRY79O012K', 'A'),
  (7011, '2020-01-22 08:30', '2020-01-30 08:30', 96.00,  '61040', '41261', 'TRY79O012K', 'C'),
  (7012, '2020-04-05 09:11', '2020-04-08 09:11', 165.00, '41261', '41261', '78OPISL348', 'L');

insert into LetteraNoleggio(numeroLettera,kmPercorsi,tipo,prenotazione,datiBancari) values
  (00001, null, 'aperta', 7001, '3456175110'),
  (00002, null, 'aperta', 7002, '2121175432'),
  (00003, null, 'aperta', 7003, '1996174444'),
  (00004, null, 'aperta', 7004, '1331661919'),
  (00005, 720,  'chiusa', 7005, '1203125891'),
  (00006, 1410, 'chiusa', 7006, '1506175891'),
  (00007, 2101, 'chiusa', 7007, '1506779391'),
  (00008, 250,  'chiusa', 7008, '1506175891'),
  (00009, 451,  'chiusa', 7009, '0336175845'),
  (00010, 1940, 'chiusa', 7010, '1004135811'),
  (00011, 1300, 'chiusa', 7011, '9903145891'),
  (00012, 510,  'chiusa', 7012, '8106135899');

insert into Feedback(noleggio,voto,recensione) values
  (00005, 5, 'ottima vettura, una utililitaria fantastica'),
  (00006, 3, 'buona vettura, una monovolume devvero comoda'),
  (00007, 5, 'ottima vettura lussuosa, la PurpleRent è un azienda perfetta!'),
  (00008, 4, 'viaggio liscio, auto lussuosa e comoda, superaccessoriata, tornerò sicuro per un altro noleggio!'),
  (00009, 3, 'Great car! The best rental experience'),
  (00010, 5, 'ottima vettura, una utililitaria davvero comoda e spaziosa'),
  (00011, 2, 'Non sono rimasto molto soddisfatto, la mia utilitaria era sporca'),
  (00012, 5, 'ottima vettura, PurpleRent ha da sempre le lussuose più belle e veloci');

insert into indirizzoSede(sede,città,civico,via) values
  ('61040', 'Roma', ''),
  ('61031', '08:30', '18:30', 3798000197, 'roma@sede2.it'),
  ('41261', '08:30', '19:00', 0863479810, 'math@sede3.com');

insert into residenzaCliente(cliente,città,civico,via) values

insert into CasaAutomobilistica(nome,nazione) values

insert into AutovetturaNoleggiabile(targa,immatricolazione,km,colore,disponibile,carGroup,casaAuto) values

insert into AutovetturaVendita(targa,immatricolazione,km,colore,prezzoVendita,carGroup,casaAuto) values

insert into AcquirenteVetturaUsata (nomeAzienda,partitaIva,telefono,datiBancari) values

insert into Fornitore (nomeAziendaFornitore,partitaIva,telefono,datiBancari) values

insert into sedeAttuale (autovetturaN, sede) values

insert into noleggioAutovetturaNoleggiabile(contratto,autovetturaN) values

insert into noleggioAutovetturaVendita(contratto,autovetturaN) values

insert into Officina(nome, orarioApertura, orarioChiusura, numTel, email) values

insert into RiparazioniEffettuate(numeroRip,data,motivazione,costo,officina) values

insert into riparazioneAutovetturaN(riparazione,autovetturaN) values

insert into riparazioneAutovetturaV(riparazione,autovetturaV) values

insert into indirizzoOfficina(officina,città,civico,via) values

insert into FatturaVendita(numeroFattura,importo,data,autovettura,acquirente) values

insert into FatturaAcquisto(numeroFattura,importo,data,numVetture,fornitore) values

insert into acquistoAutovetturaNoleggiabili(fatturaN,autovetturaN) values

insert into acquistoAutovetturaVendita(fatturaV,autovetturaV) values

insert into fornitoreCarGroup(fornitore,carGroup) values

insert into fornitoreCasa(fornitore,casa) values

insert into indirizzoFornitore(fornitore,città,civico,via) values

insert into indirizzoAcquirente(acquirente,città,civico,via) values
