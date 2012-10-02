$self = 
  { 'Name' => "Elementeflaeche",
    'Dauer' => "Sofortiger Zauber",
    'Beschreibung' => "blubb",
    'Fertigkeit' => 'Elemente',
    'BasisMW' => 10,
    'Variable' => 
    {  'RW' => $Spruch::RW_quadratisch,
       'Flaeche' => 
       { 'Wert' => 1,
	 'Groessenordnung' => 'linear',
	 'Faktor' => 2,
#	 'Obergrenze' => 40,
	 'Text' => '$wert . " quadratmeter"',
	 'Beschreibung' => 'Groesse der Elementeflaeche'
       },
       'Element' => {
		     'Wert' => 'Feuer',
		     'Faktor' => 1,
		     'Groessenordnung' => {
					   'Feuer' => 0,
					   'Wasser' => 0,
					   'Luft' => 0,
					   'Erde' => 0,
					   'Eis' => 0},
		     'Beschreibung' => 'blab'}
     },
     'Oberspruch' => ['Elementevolumen'],
     'Spezialisierung' => { 'muss' => ['Element'] }
  };
























