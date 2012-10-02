#
# Parameter fuer einen Elementstrahl-Spruch (experimental)
#
$self = {
     'Name' => "Gedanken_lesen",
     'Dauer' => "Sofortiger Zauber",
     'Beschreibung' => "askjhdkasjhd",
     'Fertigkeit' => 'Telepathie',
     'BasisMW' => 15,
     'Variable' => {
	  'RW' => $Spruch::RW_quadratisch,
	  'Tiefe' => {
	       'Wert' => 'aktuelle Gedanken',
	       'Faktor' => 1,
	       'Groessenordnung' => [
		    ['Gefuehle',0],
		    ['aktuelle Gedanken', 1],
		    ['Kurzzeitgedaechtnis', 4],
		    ['Langzeitgedaechtnis', 9],
		    ['Unterbewusstsein', 16]],
	       'Beschreibung' => 'blab'}
     },
     'Oberspruch' => [],
     'Spezialisierung' => {
	  'muss' => ['Tiefe']}
};
