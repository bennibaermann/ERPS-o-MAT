#
# Die erste Charakterdatei zum Testen
# Diese Datei wird einfach in Charakter.pm rein-ge-evaled...

# $self->{'Basisattribut'} = {};
# $self->{'Fertigkeit'} = {};
# $self->{'Spruchprozente'} = {};

$self =
 {
  'Name' => "Te Sto-Steron",
  'Basisattribut' =>
  {'PSI' => 7,  
   'STR' => 9 },
     
# PSI-Fertigkeiten
  'Fertigkeit' =>
  {'PSE' => 2,
   'Schock' => 1,
   'Magietheorie' => 50,
   'Elemente' => 7,
   'Wahrnehmung' => 7,
   'Regeneration' => 8,
   'Illusion' => 4,
   'Bewegung' => 6,
   'Kontrolle' => 4,
   'Binden' => 7,
   'Koerperbewusstsein' => 4,
   'Verstaendnis' => 6,
   'Telepathie' => 6,
   'Gegenmagie' => 7,
   'Beschwoeren' => 7,
   'Empathie' => 3,
   'Materietransformation' => 3,
   'Natur' => 2,
   'Dimension' => 9,
   'Hypnose' => 3
  },
     
# Sprueche
  'Spruchprozente' =>
  {
   'Schockstrahl' =>
   { 
    'Spez60' => {'Schaden' => 4 },
    'Spez50' => {'Schaden' => 3 }
   },
   'Elementstrahl' =>
   {
    'Spez50' => [{'Element' => "Feuer",
		  'Schaden' => 3 },
		 {'Element' => "Eis",
		  'Schaden' => 3 }]
   },
   'Gedanken_lesen' =>
   { 'Spez60' => {'Tiefe' => 'Langzeitgedaechtnis'}
   },
   'Teleportation' =>
   { 'Spez60' => {'SW' => 1024 },
     'Spez50' => {'Personen' => 0 }
   },
   'Heilen_schwerer_Wunden' => 50,
   'Vergangenheit_Zukunft_sehen' => 90
  }
 };
	 
	 
	 

































