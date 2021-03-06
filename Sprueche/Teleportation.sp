$self = 
  { 'Name' => "Teleportation",
    'Dauer' => "Sofortiger Zauber",
    'Beschreibung' => "Plötzliche Ortsveränderungen aller Art",
    'Fertigkeit' => 'Bewegung',
    'BasisMW' => 25,
    'Variable' => 
    {  'SW' => $Spruch::RW_log2,
       'Ort' =>
       { 'Wert' => 'LOS',
	 'Faktor' => 1,
	 'Groessenordnung' =>
	 [ ['LOS', 0],
	   ['bekannt', 5],
	   ['unbekannt', 15]
	 ],
	 'Beschreibung' => 'Status des Zielortes'
       },
       'Last' => 
       { 'Wert' => 0,
	'Faktor' => 1,
	'Groessenordnung' => 'linear',
	'Text' => '$wert * 10',
	'Beschreibung' => 'Mitgenommene Ausruestung'
       },
       'weitere Lebewesen' =>
       {
	'Wert' => 0,
	'Faktor' => 5,
	'Groessenordnung' => 'linear',
	'Text' => '$wert',
	'Beschreibung' => 'Anzahl weiterer Lebewesen ausser dem Zauberer'
       }
     },
     'Oberspruch' => [],
     'Spezialisierung' => { 'kann' => ['SW' , 'Personen'] }

  };
























