#
# Elementebaelle
#
$self = 
  {
   'Name' => "Elementeball",
   'Dauer' => "Sofortiger Zauber",
   'Beschreibung' => "TP-Schaden(ausser Luft,Wasser), Ruestung zaehlt",
   'Fertigkeit' => 'Elemente',
   'BasisMW' => 17,
   'Variable' => 
   {
    'RW' => $Spruch::RW_quadratisch,
    'Schaden' => $Spruch::Schaden_quadratisch,
    'Radius' => 
    {
     'Wert' => 1,
     'Groessenordnung' => 'quadratisch',
     'Faktor' => 1,
     'Text' => 
     ' $wert . " meter"',
     'Beschreibung' => 'Betroffener Radius'
    },
    #####################
    'Element' => 
    {
     'Wert' => 'Feuer',
     'Faktor' => 1,
     'Groessenordnung' => {
			   'Feuer' => 0,
			   'Wasser' => -2,
			   'Luft' => 0,
			   'Erde' => 0,
			   'Eis' => 0},
     'Beschreibung' => 'Wasser: SP-Schaden, Luft: Wirbelsturm'}
    ##############
   },
   
   'Oberspruch' => [],
   'Spezialisierung' => {
			 'muss' => ['Element', 'Schaden']
			}
  };
