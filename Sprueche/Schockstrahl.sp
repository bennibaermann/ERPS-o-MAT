#
# Parameter fuer einen Elementstrahl-Spruch (experimental)
#
$self = {
     'Name' => "Schockstrahl",
     'Dauer' => "Sofortiger Zauber",
     'Beschreibung' => "SP-Schaden, Ruestung zaehlt nicht",
     'Fertigkeit' => 'Schock',
     'BasisMW' => 13,
     'Variable' => {
	  'RW' => $Spruch::RW_quadratisch,
	  'Schaden' => $Spruch::Schaden_quadratisch,
     },
     'Oberspruch' => [],
     'Spezialisierung' => {
			   'muss' => ['Schaden']
			  }
			  
};
