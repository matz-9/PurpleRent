insert into Sede(codiceMnemonico,orarioApertura,orarioChiusura,telefono,email) values
  ('61040', '08:30', '19:00', 3791062597, 'pippolos@sede1.it'),
  ('61031', '08:30', '18:30', 3798000197, 'roma@sede2.it'),
  ('41261', '08:30', '19:00', 0863479810, 'math@sede3.com')
);

insert into Dipendente(id,nome,cognome,anniAnzianità,sede) values
  (1755368, 'Filippo', 'Sardi',       20, '61040'),
  (1718223, 'Mattia',  'Mariano',     17, '61040'),
  (1891110, 'Yegor',   'Kumiscavich', 35, '41261')
);

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
  ('RJ51230KL7', 'Eric',     'Cartman',      21, '1947294759')
);

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
  ('RJ51230KL7',  null)
);

insert into Prenotazione(orarioInizio,orarioFine,prezzo,sedeDiRitiro,sedeDiRilascio,cliente,carGroup) values
  ('2018-01-14 09:00', '2018-01-18 09:00', , '61031', '61031', 'AP1017Y890', 'E'),
  ('2018-08-22 10:17', '2018-08-23 10:17', '', '41261', '41261', 'AP1017Y890', 'A'),
  ('2018-04-02 15:30', '2018-04-03 15:30', '', '61040', '41261', 'TRY79O012K', 'D'),
  ('2019-02-18 11:00', '2019-02-19 11:00', '', '61040', '41261', '56UR64FVOP', 'C'),
  ('2019-04-22 15:00', '2019-04-22 19:00', '', '61031', '61031', '456QOP760Y', 'A'),
  ('2019-03-03 10:05', '2019-03-06 16:30', '', '41261', '41261', '456QOP760Y', 'G'),
  ('2019-05-05 11:15', '2019-05-06 10:30', '', '41261', '61031', '456QOP760Y', 'L'),
  ('2019-05-05 11:15', '2019-05-06 10:30', '', '41261', '61031', '456QOP760Y', 'L'),
  ('2019-06-25 13:30', '2019-06-26 17:30', '', '61031', '61031', 'GRT780H12L', 'J'),
  ('2019-04-09 14:22', '2019-04-12 17:00', '', '61040', '61031', 'TRY79O012K', 'A'),
  ('2020-01-22 08:30', '2020-01-23 19:00', '', '61040', '41261', 'TRY79O012K', 'C'),
  ('2020-04-05 09:11', '2020-04-05 19:00', '', '41261', '41261', '78OPISL348', 'L')
);

insert into CarGroup(lettera,prezzoGiornaliero) values
  ('A', 9 ),('C', 12 ),('D', 14 ),('E', 15 ),('G', 18 ),
  ('J', 20 ),('I', 22 ),('H', 45 ),('L', 55 ),('K', 25 ),
  ('M', 40 ),('N', 28 ),('O', 35 ),('P', 32 );


insert into LetteraNoleggio(kmPercorsi,tipo,prenotazione,datiBancari) values
  (null,'aperta',7001,'3456175110'),
  (null,'aperta',7002,'2121175432'),
  (null,'aperta',7003,'1996174444'),
  (null,'aperta',7004,'1331661919'),
  (720,'chiusa',7005,'1203125891'),
  (1410,'chiusa',7006,'1506175891'),
  (2101,'chiusa',7007,'1506779391'),
  (250,'chiusa',7008,'1506175891'),
  (451,'chiusa',7009,'0336175845'),
  (1940,'chiusa',7010,'1004135811'),
  (1300,'chiusa',7011,'9903145891'),
  (510,'chiusa',7012,'8106135899')
);

insert into Feedback(noleggio,voto,recensione)
  (),
