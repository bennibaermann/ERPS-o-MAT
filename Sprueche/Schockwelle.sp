#
# Schockwelle
#
$self =
  { 'Name' => "Schockwelle",
    'Dauer' => "Sofortiger Zauber",
    'Beschreibung' => "SP-Schaden auf mehrere Opfer, Ruestung zaehlt",
    'Fertigkeit' => 'Schock',
      'BasisMW' => 23,
      'Variable' => 
      { 'RW' => $Spruch::RW_quadratisch,
	'Schaden' => $Spruch::Schaden_quadratisch,
	'Winkel' => 
	{ 'Wert' => 'Viertelkreis',
	  'Faktor' => 1,
	  'Beschreibung' => 'bla',
	  'Groessenordnung' => 
	  { 'Ganzkreis' => 2,
	    'Halbkreis' => 0,
	    'Viertelkreis' => 2,
	    'Achtelkreis' => 4}
	},
	'Abstand' =>
	{ 'Beschreibung' => 'Abstand vom Zaubernden, ab dem wirksam',
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
				'muss' => ['Schaden','Winkel']
			       }
};
