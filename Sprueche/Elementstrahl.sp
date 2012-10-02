#
# Parameter fuer einen Elementstrahl-Spruch (experimental)
#
$self = {
     'Name' => "Elementstrahl",
     'Dauer' => "Sofortiger Zauber",
     'Beschreibung' => "TP-Schaden, Ruestung zaehlt",
     'Fertigkeit' => 'Elemente',
     'BasisMW' => 15,
     'Variable' => {
	  'RW' => $Spruch::RW_quadratisch,
	  'Schaden' => $Spruch::Schaden_quadratisch,
	  'Element' => {
	       'Wert' => 'Feuer',
	       'Faktor' => 1,
	       'Groessenordnung' => {
		    'Feuer' => 0,
		    'Wasser' => -2,
		    'Luft' => -2,
		    'Erde' => 0,
		    'Eis' => 0},
	       'Beschreibung' => 'blab'}
     },
     'Oberspruch' => ['Elementeball'],
     'Spezialisierung' => {
			   'muss' => ['Element', 'Schaden']
			  }
			  
};
