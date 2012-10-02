#
# leichte Wunden heilen
#
$self =
  { 'Name' => "mittlere_Wunden_heilen",
    'Dauer' => "Minutenzauber",
    'Beschreibung' => "bis 20 TP",
    'Fertigkeit' => 'Regeneration',
    'Fertigkeiten' => ['Regeneration','Koerperbewusstsein'],
      'BasisMW' => 12,
      'Variable' => 
      { 'TP' => { 'Wert' => 15,
		  'Groessenordnung' => 'linear',
		  'Obergrenze' => 20,
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
    'Oberspruch' => ['schwere_Wunden_heilen'],
	  'Spezialisierung' => {
				'muss' => ['TP']
			       }
};
