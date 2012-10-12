$self = 
  { 'Name' => "Elementevolumen",
    'Dauer' => "Sofortiger Zauber",
    'Beschreibung' => "blubb",
    'Fertigkeit' => 'Elemente',
    'BasisMW' => 15,
    'Variable' => 
    {  'RW' => $Spruch::RW_quadratisch,
       'Volumen' => 

       # TODO: stimmt das hier wirklich? warum ist bei 2km schluss?
       { 'Wert' => 20,
	 'Groessenordnung' => 'linear',
	 'Faktor' => 1,
	 'Obergrenze' => 40,
	 'Text' => '$wert/20 . " kubikmeter"',
	 'Beschreibung' => 'Groesse des Elementevolumens'
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
		     'Beschreibung' => 'blab'}     },
     'Oberspruch' => [],
     'Spezialisierung' => { 'muss' => ['Element'] }
  };
























