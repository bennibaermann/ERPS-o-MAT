#
# kleine Abweichungen zum Regelwerk (log Groesse)
#
$self = {
     'Name' => "Illusion",
     'Dauer' => "Sofortiger Zauber",
     'Beschreibung' => "gaukelei",
     'Fertigkeit' => 'Illusion',
     'BasisMW' => 10,
     'Variable' => 
	 {
	  'RW' => $Spruch::RW_quadratisch,
	  'Sinne' => 
	  { 'Wert' => 'einer',
	    'Faktor' => 1,
	    'Groessenordnung' =>
	    [ ['einer', 0],
	      ['zwei', 5],
	      ['drei', 10]
	    ],
	    'Beschreibung' => 'riechen, hoeren, sehen...'
	  },
	  # dummy-variable, nur fuer Spezialisierung
	  'Sinn' => {'Wert' => 'Bild',
		     'Faktor' => 1,
		     'Groessenordnung' => 
		     { 'Bild' => 0,
		       'Geruch' => 0,
		       'Ton' => 0}
		    },
	  'Ort' =>
	  { 'Wert' => 'unbeweglich',
	    'Faktor' => 1,
	    'Groessenordnung' =>
	    [ ['unbeweglich', 0],
	      ['beweglich', 5],
	      ['variabel', 10]
	    ],
	    'Beschreibung' => 'variabel: Inhalt veraenderlich'}
	 },
     'Oberspruch' => [],
     'Spezialisierung' => {
			   'muss' => ['Sinn']
			  }
			  
};



