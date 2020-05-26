insert into Sede(codiceMnemonico,orarioApertura,orarioChiusura,telefono,email) values
  ('61040', '08:30', '19:00', 3791062597, 'pippolos@purplerent.it'),
  ('61031', '08:30', '18:30', 3798000197, 'roma@purplerent.it'),
  ('41261', '08:30', '19:00', 0863479810, 'math@purplerent.it');

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
  ('Roma',               '2',   'Via Ugo Bertossi',         '00159'),
  ('Milano',             '5',   'Via Alessandro Manzoni',   '35126'),
  ('Roma',               '15',  'Via Regina Margherita',    '00198'),
  ('Canistro Inferiore', '7',   'Via Largo Liri',           '67050'),
  ('Roma',               '6',   'Via Mar Rosso',            '00121'),
  ('Napoli',             '73',  'Via Napoli',               '00184'),
  ('Firenze',            '6',   'Via Maremma Bucaiola',     '20199'),
  ('Pisa',               '22',  'Via della Torre',          '45009'),
  ('Roma',               '1',   'Via Tiburtina',            '00133'),
  ('Genova',             '14',  'Via degli Abeti',          '04310'),
  ('Bari',               '9',   'Via Cristian Cocco',       '11159'),
  ('Milano',             '17',  'Piazza del Duomo',         '05409'),
  ('Roma',               '113', 'Via Salaria',              '10231'),
  ('Rieti',              '36',  'Via Virgola Mobile',       '01274'),
  ('Bologna',            '19',  'Via Guerrazzi',            '45009'),
  ('Catanzaro',          '32',  'Via Guiuseppe Poeri',      '00133'),
  ('Firenze',            '14',  'Viale Alessandro Guidoni', '05310'),
  ('Roma',               '9',   'Via Cristian Cocco',       '21359'),
  ('Milano',             '1',   'Via Fieno',                '07419'),
  ('Benevento',          '24',  'Via Avellino',             '04020');

insert into DatiBancari(contoCorrente,circuito,nomeBanca) values
  ('1233958372', 'visa',             'IntesaSanPaolo'),
  ('3618304719', 'mastercard',       'IntesaSanPaolo'),
  ('4639281049', 'diner',            'Mediolanum'),
  ('5930275641', 'visa',             'Unicredit'),
  ('9243856384', 'visa',             'Unicredit'),
  ('5629472036', 'visa',             'Unicredit'),
  ('1947294759', 'american express', 'Ubi banca'),
  ('8649254281', 'mastercard',       'IntesaSanPaolo'),
  ('4730184936', 'visa',             'Mediolanum'),
  ('3649264281', 'mastercard',       'Ubi banca'),
  ('7692394913', 'american express', 'Mediolanum'),
  ('6241866284', 'visa',             'Unicredit'),
  ('5691374113', 'american express', 'Mediolanum'),
  ('2649152096', 'visa',             'Unicredit'),
  ('6917392229', 'mastercard',       'Unicredit');

insert into ClienteNoleggio(numDocumento,nome,cognome,età,datiBancari) values
  ('AP1017Y890', 'Vittorio', 'Terzetti',     50, '1233958372'),
  ('BO34590P70', 'Enzo',     'Pesce',        22, '3618304719'),
  ('T946510KP4', 'Marco',    'Marchi',       35, '4639281049'),
  ('78OPISL348', 'Guido',    'Piano',        63, '5930275641'),
  ('GRT780H12L', 'Harry',    'Foreman',      43, '9243856384'),
  ('YR7I012KLU', 'Walter',   'Bishop',       45, '5629472036'),
  ('RJ51230KL7', 'Eric',     'Cartman',      21, '1947294759');

insert into sedePreferita(cliente,sede) values
  ('AP1017Y890', '61031'),
  ('BO34590P70', '61031'),
  ('T946510KP4', '41261'),
  ('78OPISL348',  null),
  ('GRT780H12L',  null),
  ('YR7I012KLU', '61040'),
  ('RJ51230KL7',  null);

insert into Prenotazione(numeroPrenotazione,orarioInizio,orarioFine,prezzo,sedeRitiro,sedeRilascio,cliente,carGroup) values
  (7001, '2020-05-22 09:00', '2020-06-28 09:00', 90.00,  '61031', '61031', 'AP1017Y890', 'E'),
  (7002, '2020-08-27 10:17', '2020-08-28 10:17', 09.00,  '41261', '41261', 'AP1017Y890', 'A'),
  (7003, '2018-04-02 15:30', '2018-04-03 15:30', 14.00,  '61040', '41261', 'T946510KP4', 'D'),
  (7004, '2019-02-18 11:00', '2019-02-20 11:00', 24.00,  '61040', '41261', '78OPISL348', 'C'),
  (7005, '2019-04-22 15:00', '2019-04-24 15:00', 18.00,  '61031', '61031', '78OPISL348', 'A'),
  (7006, '2019-03-03 10:05', '2019-03-06 10:05', 54.00,  '41261', '41261', 'BO34590P70', 'G'),
  (7007, '2019-05-05 11:15', '2019-05-06 11:15', 55.00,  '41261', '61031', '78OPISL348', 'L'),
  (7008, '2019-04-05 12:15', '2019-04-07 12:15', 90.00,  '41261', '61031', 'GRT780H12L', 'H'),
  (7009, '2019-06-25 17:30', '2019-06-26 17:30', 20.00,  '61031', '61031', 'GRT780H12L', 'J'),
  (7010, '2019-04-09 17:00', '2019-04-18 17:00', 81.00,  '61040', '61031', 'YR7I012KLU', 'A'),
  (7011, '2020-01-22 08:30', '2020-01-30 08:30', 96.00,  '61040', '41261', 'RJ51230KL7', 'C'),
  (7012, '2020-04-05 09:11', '2020-04-08 09:11', 165.00, '41261', '41261', 'RJ51230KL7', 'L');

insert into LetteraNoleggio(numeroLettera,kmPercorsi,tipo,prenotazione,datiBancari) values
  (00001, null, 'aperta', 7001, '1233958372'),
  (00002, null, 'aperta', 7002, '1233958372'),
  (00003, 311,  'chiusa', 7003, '4639281049'),
  (00004, 1190, 'chiusa', 7004, '5930275641'),
  (00005, 720,  'chiusa', 7005, '5930275641'),
  (00006, 1410, 'chiusa', 7006, '3618304719'),
  (00007, 2101, 'chiusa', 7007, '5930275641'),
  (00008, 250,  'chiusa', 7008, '9243856384'),
  (00009, 451,  'chiusa', 7009, '9243856384'),
  (00010, 1940, 'chiusa', 7010, '5629472036'),
  (00011, 1300, 'chiusa', 7011, '1947294759'),
  (00012, 510,  'chiusa', 7012, '1947294759');

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
  ('61040', 'Firenze', '14',  'Viale Alessandro Guidoni'),
  ('61031', 'Roma',    '9',   'Via Cristian Cocco'),
  ('41261', 'Milano',  '1',   'Via Fieno');

insert into residenzaCliente(cliente,città,civico,via) values
  ('AP1017Y890', 'Roma',               '2',   'Via Ugo Bertossi'),
  ('BO34590P70', 'Milano',             '5',   'Via Alessandro Manzoni'),
  ('T946510KP4', 'Roma',               '15',  'Via Regina Margherita'),
  ('78OPISL348', 'Canistro Inferiore', '7',   'Via Largo Liri'),
  ('RJ51230KL7', 'Firenze',            '6',   'Via Maremma Bucaiola'),
  ('GRT780H12L', 'Roma',               '6',   'Via Mar Rosso'),
  ('YR7I012KLU', 'Napoli',             '73',  'Via Napoli');

insert into CasaAutomobilistica(nome,nazione) values
  ('Audi','Germania'),
  ('BMW','Germania'),
  ('Fiat', 'Italia'),
  ('Mercedes', 'Germania'),
  ('Peugeot', 'Francia'),
  ('Renault', 'Francia'),
  ('AlfaRomeo', 'Italia');

insert into AutovetturaNoleggiabile(targa,km,colore,disponibile,carGroup,casaAuto) values
  ('FR249GG', 30000,  'rosso',     false, 'E',  'Audi'),
  ('FP445PM', 10000,  'grigio',    true,  'A',  'Renault'),
  ('FZ142PG', 7000,   'arancione', true,  'L',  'Mercedes'),
  ('FA101MM', 120000, 'nero',      true,  'A',  'BMW'),
  ('FC552KM', 100000, 'blu',       false, 'C',  'Renault'),
  ('FK597FM', 89000,  'bianco',    true,  'G',  'Peugeot'),
  ('FQ647JK', 50000,  'rosso',     true,  'L',  'Audi'),
  ('FW830IO', 60000,  'nero',      false, 'D',  'AlfaRomeo'),
  ('FB392TT', 120000, 'grigio',    false, 'A',  'Fiat'),
  ('FF483AB', 90000,  'blu',       true,  'H',  'BMW');
ok
insert into AutovetturaVendita(targa,km,colore,prezzoVendita,carGroup,casaAuto) values
  ('ER245GG', 150000, 'rosso',     32000, 'E',  'AlfaRomeo'),
  ('EP443PM', 150000, 'grigio',    41000, 'J',  'Audi'),
  ('EZ132PG', 150000, 'arancione', 40000, 'L', 'Mercedes'),
  ('EA541MM', 150000, 'nero',      2100,  'P',  'BMW'),
  ('EC642KM', 150000, 'blu',       8000,  'A',  'Renault'),
  ('EK647FM', 150000, 'bianco',    7000,  'C',  'Peugeot'),
  ('EQ227JK', 150000, 'rosso',     12000, 'H',  'Audi'),
  ('EW520IO', 150000, 'nero',      22000, 'A',  'AlfaRomeo'),
  ('EB122TT', 150000, 'grigio',    10000, 'C',  'BMW'),
  ('EF813AB', 150000, 'blu',       5000,  'L',  'Renault');

insert into AcquirenteVetturaUsata (nomeAzienda,partitaIva,telefono,datiBancari) values
  ('comprousato.srl', '18493827463', 0791062597, '8649254281'),
  ('autoricambi',     '38274027483', 0694729479, '4730184936'),
  ('centoallora.com', '11637355483', 0483284938, '7692394913'),
  ('tuttomotori',     '25366482637', 0778302840, '3649264281');

insert into Fornitore (nomeAziendaFornitore,partitaIva,telefono,datiBancari) values
  ('Perinetti auto',      '12034810019', 3791062567, '6241866284'),
  ('Il mondo delle auto', '17737815014', 3381312367, '5691374113'),
  ('Great cars',          '07917666023', 3880551087, '2649152096'),
  ('Sulla strada',        '69573722295', 3491956789,'6917392229');

insert into sedeAttuale (autovetturaN, sede) values
  ('FR249GG', '61040'),
  ('FP445PM', '61040'),
  ('FZ142PG', '61040'),
  ('FA101MM', '61031'),
  ('FC552KM', '61031'),
  ('FK597FM', '61031'),
  ('FQ647JK', '41261'),
  ('FW830IO', '41261'),
  ('FB392TT', '41261'),

insert into noleggioAutovetturaNoleggiabile(contratto,autovetturaN) values
  (00001, 'FR249GG'),
  (00002, 'FB392TT'),
  (00003, 'FW830IO'),
  (00004, 'FC552KM'),
  (00005, 'FA101MM'),
  (00006, 'FK597FM'),
  (00007, 'FQ647JK');

insert into noleggioAutovetturaVendita(contratto,autovetturaV) values
  (00008, 'EQ227JK'),
  (00009, 'EP443PM'),
  (00010, 'EC642KM'),
  (00011, 'EK647FM'),
  (00012, 'EF813AB');

insert into Officina(nome, orarioApertura, orarioChiusura, numTel, email) values
  ('Milli srl',       '09:00', '18:00', 065699991, 'millisrl@gmail.com'),
  ('Ncm carrozzeria', '09:30', '19:00', 025198713, 'ncmcarr@outlook.com');

insert into RiparazioniEffettuate(numeroRip,data,motivazione,costo,officina) values
  ('R0001', '2019-04-09', 'cambio olio motore e cambio filtro ant.',  80.00,  'Milli srl'),
  ('R0002', '2019-06-18', 'cambio paraurti per incidente',            100.00, 'Milli srl'),
  ('R0003', '2020-01-14', 'cambio ruote',                             120.00, 'Ncm carrozzeria'),
  ('R0004', '2020-04-18', 'rodaggio e controllo freni',               50.00,  'Milli srl'),
  ('R0005', '2020-07-22', 'controllo freni e cambio gomme',           100.00, 'Ncm carrozzeria'),
  ('R0006', '2020-02-28', 'cambio fari e luci di posizione',          40.00,  'Milli srl'),
  ('R0007', '2020-12-25', 'riparazione cerchione',                    20.00,  'Ncm carrozzeria'),
  ('R0008', '2020-03-24', 'cambio olio',                              15.00,  'Milli srl'),
  ('R0009', '2020-04-01', 'riparazione marmitta',                     30.00,  'Milli srl'),
  ('R0010', '2020-05-06', 'riverniciatura paraurti e cambio pomello', 70.00,  'Ncm carrozzeria');











insert into riparazioneAutovetturaN(riparazione,autovetturaN) values
  ('R0001', 'FR249GG'),
  ('R0002', 'FP445PM'),
  ('R0003', 'FZ142PG'),
  ('R0004', 'FA101MM'),
  ('R0005', 'FZ142PG');


insert into riparazioneAutovetturaV(riparazione,autovetturaV) values
  ('R0006', 'ER245GG'),
  ('R0007', 'EK647FM'),
  ('R0008', 'EW520IO'),
  ('R0009', 'EK647FM'),
  ('R0010', 'EW520IO');











insert into indirizzoOfficina(officina,città,civico,via) values
  ('Milli srl',       'Milano', '17',  'Piazza del Duomo')
  ('Ncm carrozzeria', 'Roma',   '113', 'Via Salaria')

insert into FatturaVendita(numeroFattura,importo,data,autovettura,acquirente) values
  ('FA00001', 5000.00, '2020-01-01', 'ER245GG', 'comprousato.srl'),
  ('FA00002', 4000.00, '2020-01-03', 'EP443PM', 'comprousato.srl' )
  ('FA00003', 5500.00, '2020-02-10', 'EQ227JK', 'tuttomotori')
  ('FA00004', 3900.00, '2020-03-19', 'EF813AB', 'centoallora.com',)
  ('FA00005', 5200.00, '2020-01-21', 'EK647FM', 'comprousato.srl' )
  ('FA00006', 3400.00, '2020-01-14', 'EZ132PG', 'centoallora.com',)

insert into FatturaAcquisto(numeroFattura,importo,data,numVetture,fornitore) values
  ('FA00028', 20000.00, '2019-03-24', 3, 'Il mondo delle auto'),
  ('FA00029', 100000.00,'2019-04-01', 6, 'Perinetti auto'),
  ('FA00031', 24000.00, '2018-12-14', 2, 'Il mondo delle auto'),
  ('FA00032', 6000.00,  '2019-01-12', 1, 'Perinetti auto'),
  ('FA00033', 10000.00, '2018-11-07', 5, 'Great cars'),
  ('FA00034', 70000.00, '2018-09-19', 3, 'Sulla strada');

insert into acquistoAutovetturaNoleggiabili(fatturaN,autovetturaN) values
  ('FA00028', 'FR249GG'),
  ('FA00028', 'FZ142PG'),
  ('FA00028', 'FP445PM'),
  ('FA00032', 'FW830IO'),
  ('FA00029', 'FA101MM'),
  ('FA00029', 'FC552KM'),
  ('FA00029', 'FK597FM'),
  ('FA00029', 'FQ647JK'),
  ('FA00029', 'FB392TT'),
  ('FA00029', 'FF483AB');

insert into acquistoAutovetturaVendita(fatturaV,autovetturaV) values
  ('FA00031', 'ER245GG'),
  ('FA00031', 'EP443PM'),
  ('FA00033', 'EZ132PG'),
  ('FA00033', 'EA541MM'),
  ('FA00033', 'EC642KM'),
  ('FA00033', 'EK647FM'),
  ('FA00033', 'EQ227JK'),
  ('FA00034', 'EW520IO'),
  ('FA00034', 'EB122TT'),
  ('FA00034', 'EF813AB');

insert into fornitoreCarGroup(fornitore,carGroup) values
  ('Perinetti auto',      'E'),
  ('Perinetti auto',      'L'),
  ('Perinetti auto',      'A'),
  ('Sulla strada',        'D'),
  ('Sulla strada',        'H'),
  ('Great cars',          'J'),
  ('Great cars',          'H'),
  ('Il mondo delle auto', 'P'),
  ('Il mondo delle auto', 'H');

insert into fornitoreCasa(fornitore,casa) values
  ('Perinetti auto',      'Audi'),
  ('Perinetti auto',      'BMW'),
  ('Perinetti auto',      'Fiat'),
  ('Perinetti auto',      'Peugeot'),
  ('Sulla strada',        'Mercedes'),
  ('Sulla strada',        'BMW'),
  ('Sulla strada',        'Fiat'),
  ('Great cars',          'Renault'),
  ('Great cars',          'AlfaRomeo'),
  ('Great cars',          'Peugeot'),
  ('Il mondo delle auto', 'Peugeot'),
  ('Il mondo delle auto', 'Audi'),
  ('Il mondo delle auto', 'Renault'),
  ('Il mondo delle auto', 'Fiat');

insert into indirizzoFornitore(fornitore,città,civico,via) values
  ('Perinetti auto',      'Rieti',     '36',  'Via Virgola Mobile'),
  ('Il mondo delle auto', 'Bologna',   '19',  'Via Guerrazzi'),
  ('Great cars',          'Catanzaro', '32',  'Via Guiuseppe Poeri'),
  ('Sulla strada',        'Benevento', '24',  'Via Avellino');

insert into indirizzoAcquirente(acquirente,città,civico,via) values
  ('comprousato.srl', 'Pisa',   '22',  'Via della Torre'),
  ('autoricambi',     'Roma',   '1',   'Via Tiburtina'),
  ('centoallora.com', 'Genova', '14',  'Via degli Abeti'),
  ('tuttomotori',     'Bari',   '9',   'Via Cristian Cocco');
