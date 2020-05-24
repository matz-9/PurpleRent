insert into Sede(codiceMnemonico,orarioApertura,orarioChiusura,telefono,email) values
  ('61040','08:30','19:00','3791062597','pippolos@sede1.it'),
  ('61031','08:30','18:30','3798000197','roma@sede2.it'),
  ('41261','08:30','19:00','0863479810','math@sede3.com');

insert into Dipendente(id,nome,cognome,anniAnzianità,sede) values
  ('1755368', 'Filippo', 'Sardi',       '20','61040'),
  ('1718223', 'Mattia',  'Mariano',     '17','61040'),
  ('1891110', 'Yegor',   'Kumiscavich', '35','41261');

insert into ClienteNoleggio(numDocumento,nome,cognome,età,datiBancari) values
  ('AP1017Y890', 'Vittorio', 'Terzetti',     '50', '123000'),
  ('BO34590P70', 'Enzo',     'Pesce',        '22', '50000'),
  ('T946510KP4', 'Marco',    'Marchi',       '35', '90500'),
  ('456QOP760Y', 'Filippo',  'Franceschini', '23', '900000'),
  ('78OPISL348', 'Guido',    'Piano',        '63', '76500'),
  ('56UR64FVOP', 'Davide',   'Maria',        '32', '9000'),
  ('GRT780H12L', 'Harry',    'Foreman',      '43', '180000'),
  ('TRY79O012K', 'Guerrino', 'Di agostino',  '56', '3500'),
  ('YR7I012KLU', 'Walter',   'Bishop',       '45', '80700')
  ('RJ51230KL7', 'Eric',     'Cartman',      '21', '3000');

insert into sedePreferita(cliente,sede) values
  ('AP1017Y890','61031'),
  ('BO34590P70','61031'),
  ('T946510KP4','41261'),
  ('456QOP760Y','61040'),
  ('78OPISL348','null'),
  ('56UR64FVOP','41261'),
  ('GRT780H12L','null'),
  ('TRY79O012K','null'),
  ('YR7I012KLU','61040'),
  ('RJ51230KL7','null');

insert into Prenotazione(numeroPrenotazione,orarioInizio,orarioFine,prezzo,sedeDiRitiro,sedeDiRilascio,cliente,carGroup) values
  ('')
