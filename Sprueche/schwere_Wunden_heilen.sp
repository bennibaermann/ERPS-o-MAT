#
# schwere Wunden heilen
#
$self =
  { 'Name' => "schwere_Wunden_heilen",
    'Dauer' => "Minutenzauber",
    'Beschreibung' => "ab 20 TP",
    'Fertigkeit' => 'Regeneration',
    'Fertigkeiten' => ['Regeneration','Koerperbewusstsein'],
      'BasisMW' => 15,
      'Variable' => 
      { 'TP' => { 'Wert' => 21,
		  'Groessenordnung' => 'linear',
#		  'Obergrenze' => 20,
		  'Faktor' => 1,
		  'Text' => '$wert',
		  'Beschreibung' => 'Anzahl zu heilende TP'
		},
	'Abstand' =>
	{ 'Beschreibung' => 'Abstand vom Zaubernden',
	  'Wert' => 0,
	  'Groessenordnung' => 'linear',
	  # dezimeterlinear!
	  'Text' => 
	  '$wert * $main::stoffel->{"Basisattribut"}->{"PSI"}/10 . " meter"',
	  'Faktor' => 1
	}		    
      },
    'Oberspruch' => [],
	  'Spezialisierung' => {
				'muss' => ['TP']
			       }
};
