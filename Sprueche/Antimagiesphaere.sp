$self = 
  {
   'Name' => "Antimagiesphaere",
   'Dauer' => "Sofortiger Zauber",
   'Beschreibung' => "gibt zusaetzlichen Widerstandwurf",
   'Fertigkeit' => 'Gegenmagie',
   'BasisMW' => 12,
   'Variable' => 
   {
    'RW' => $Spruch::RW_quadratisch,
    'Widerstandswuerfel' => $Spruch::Schaden_quadratisch,
    # beschreibungstext hier falsch

    'Radius' => 
    {
     'Wert' => 1,
     'Groessenordnung' => 'quadratisch',
     'Faktor' => 1,
     'Text' => 
     ' $wert . " meter"',
     'Beschreibung' => 'geschuetzter Radius'
    },
   },
   
   'Oberspruch' => [],
   'Spezialisierung' => {
			 'muss' => ['Widerstandswuerfel']
			}
  };
