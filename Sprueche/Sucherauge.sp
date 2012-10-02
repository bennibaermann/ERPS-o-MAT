#
# Sucherauge
#
#

$self = 
  { 'Name' => "Sucherauge",
    'Dauer' => "Minutenzauber",
    'Beschreibung' => "blubb",
    'Fertigkeit' => 'Wahrnehmung',
    'BasisMW' => 25,
    'Variable' => 
    {  'RW' => $Spruch::RW_log2,
       'LOS' =>
       {'Wert' => 1,
	'Faktor' => -5,
	'Groessenordnung' => 'linear',
	'Obergrenze' => 1,
	'Text' => '$wert?"Ja":"Nein"',
	'Beschreibung' => 'Das Auge befindet sich in der Theoretischen Sichtlinie'
       },
       'Geschwindigkeit' => 
       {
	'Wert' => 1,
	'Faktor' => 1,
	'Groessenordnung' => 'linear',
	'Obergrenze' => 5,
	'Text' => '$wert * 20 . " km/h"',
	'Beschreibung' => 'blubber'
       },
       'ZweiterSinn' =>
       {
	'Wert' => 0,
	'Faktor' => 5,
	'Groessenordnung' => 'linear',
	'Obergrenze' => 1,
	'Text' => '$wert?"Ja":"Nein"',
	'Beschreibung' => 'Ersetzt auch noch einen weiteren Sinn des Zauberers'
       },
       'Beleuchtung/Nachtsicht' =>
       {
       	'Wert' => 0,
       	'Faktor' => 3,
       	'Groessenordnung' => 'linear',
       	'Obergrenze' => 1,
       	'Text' => '$wert?"Ja":"Nein"',
       	'Beschreibung' => 'damit kann man auch im Dunkeln sehen',
       	},
     },
     'Oberspruch' => ['Hellsicht'],
     'Spezialisierung' => { 'muss' => ['RW'] }

  };
























