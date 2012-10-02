#
# leichte Wunden heilen
#
$self =
  { 'Name' => "leichte_Wunden_heilen",
    'Dauer' => "Minutenzauber",
    'Beschreibung' => "bis 10 TP",
    'Fertigkeit' => 'Regeneration',
    'Fertigkeiten' => ['Regeneration','Koerperbewusstsein'],
      'BasisMW' => 10,
      'Variable' => 
      { 'TP' => { 'Wert' => 5,
		  'Groessenordnung' => 'linear',
		  'Obergrenze' => 10,
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
    'Oberspruch' => ['mittlere_Wunden_heilen'],
	  'Spezialisierung' => {
				'muss' => ['TP']
			       }
};
