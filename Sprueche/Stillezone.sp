#
# Stillezone
#
$self = 
  {
   'Name' => "Stillezone",
   'Dauer' => "Sofortiger Zauber",
   'Beschreibung' => "Schall dringt nicht von innerhalb nach ausserhalb und umgekehrt. Beliebig verformbar und variierbar",
   'Fertigkeit' => 'Elemente',
   'BasisMW' => 22,
   'Variable' => 
   {
    'RW' => $Spruch::RW_quadratisch
   },
   'Oberspruch' => [],
   'Spezialisierung' => {
			 'muss' => ['RW']
			}
  };
