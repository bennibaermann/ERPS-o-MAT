#
# Die erste Charakterdatei zum Testen
# Diese Datei wird einfach in Charakter.pm rein-required...

     # wird zum testen einfach auf stoffel festgelegt
     $self->{'Name'} = "Stoffel, Freiherr von Inmeril";
     $self->{'Basisattribut'}->{'PSI'} = 19;  
     $self->{'Basisattribut'}->{'STR'} = 10;  

     $self->{'Fertigkeit'}->{'PSE'} = 15;
     $self->{'Fertigkeit'}->{'Magietheorie'} = 15;
     $self->{'Fertigkeit'}->{'Schock'} = 9;
     $self->{'Fertigkeit'}->{'Elemente'} = 8;
     $self->{'Fertigkeit'}->{'Wahrnehmung'} = 8;
     $self->{'Fertigkeit'}->{'Regeneration'} = 8;
     $self->{'Fertigkeit'}->{'Illusion'} = 4;
     $self->{'Fertigkeit'}->{'Bewegung'} = 6;
     $self->{'Fertigkeit'}->{'Kontrolle'} = 4;
     $self->{'Fertigkeit'}->{'Binden'} = 8;
     $self->{'Fertigkeit'}->{'Koerperbewusstsein'} = 4;
     $self->{'Fertigkeit'}->{'Verstaendnis'} = 6;
     $self->{'Fertigkeit'}->{'Telepathie'} = 6;
     $self->{'Fertigkeit'}->{'Gegenmagie'} = 7;
     $self->{'Fertigkeit'}->{'Beschwoeren'} = 7;
     $self->{'Fertigkeit'}->{'Empathie'} = 3;
     $self->{'Fertigkeit'}->{'Materietransformation'} = 3;
     $self->{'Fertigkeit'}->{'Natur'} = 2;
     $self->{'Fertigkeit'}->{'Dimension'} = 9;
     $self->{'Fertigkeit'}->{'Hypnose'} = 3;

     # Schock
     $self->{'Spruchprozente'}->{'Schockstrahl'} = 
   { 
    'Spez60' => {'Schaden' => 5 },
    'Spez50' => {'Schaden' => 4 }
   };

     # Dimension
     $self->{'Spruchprozente'}->{'Dimensionstor'} = 70;
     $self->{'Spruchprozente'}->{'Teleportation'} = 70;
     $self->{'Spruchprozente'}->{'Dimensionszauber_erkennen'} = 90;

     # Elemente
     $self->{'Spruchprozente'}->{'Elementstrahl'} = 80;
     $self->{'Spruchprozente'}->{'Elementvolumen'} = 80;
     $self->{'Spruchprozente'}->{'Elementball'} = 70;
     $self->{'Spruchprozente'}->{'Stillezone'} = 90;

     # Regeneration
     $self->{'Spruchprozente'}->{'mittlere_Wunden_heilen'} = 70;
     $self->{'Spruchprozente'}->{'Verbrennungen_heilen'} = 90;
     $self->{'Spruchprozente'}->{'Koma_unterbrechen'} = 90;
     $self->{'Spruchprozente'}->{'Gift_neutralisieren'} = 90;

     # Kontrolle
     $self->{'Spruchprozente'}->{'Handlungen_beherrschen'} = 80;

     # Wahrnehmung
     $self->{'Spruchprozente'}->{'Hellhoeren'} = 90;
     $self->{'Spruchprozente'}->{'Leben_erkennen'} = 90;
     $self->{'Spruchprozente'}->{'Magie_erkennen'} = 90;
     $self->{'Spruchprozente'}->{'Hellsicht'} = 80;
     # spezialisierung von Hellsicht
     # es muss also noch ein beweglichkeitsparameter zu hellsicht
     $self->{'Spruchprozente'}->{'Sucherauge'} = 80; 
     $self->{'Spruchprozente'}->{'Material_untersuchen'} = 90; 
     $self->{'Spruchprozente'}->{'Person_finden'} = 70; 
     $self->{'Spruchprozente'}->{'Formen_erkennen'} = 90; 
     $self->{'Spruchprozente'}->{'Dinge_finden'} = 90;
 
     # Beschwoeren
     $self->{'Spruchprozente'}->{'Kundschafter'} = 70; 
     $self->{'Spruchprozente'}->{'Traeger'} = 90; 

     # Binden
     $self->{'Spruchprozente'}->{'Dimension_binden'} = 90; 
     $self->{'Spruchprozente'}->{'Bewegung_binden'} = 80; 
     $self->{'Spruchprozente'}->{'Artefakt_verstehen'} = 90; 

     # Bewegung
     $self->{'Spruchprozente'}->{'Laehmen'} = 70;
     $self->{'Spruchprozente'}->{'Levitation'} = 70;
     $self->{'Spruchprozente'}->{'Fliegen'} = 70;
     
     # Gegenmagie
     $self->{'Spruchprozente'}->{'Sphaere_durchdringen'} = 90; 
     $self->{'Spruchprozente'}->{'Bewegung_bannen'} = 80; 
     $self->{'Spruchprozente'}->{'Empathie_bannen'} = 90; 
     $self->{'Spruchprozente'}->{'Elemente_bannen'} = 90; 

     # Verstaendnis
     $self->{'Spruchprozente'}->{'Sprache_verstehen'} = 80; 
     $self->{'Spruchprozente'}->{'Arjol_Kommunikation'} = 90; 
     $self->{'Spruchprozente'}->{'Entschluesselung'} = 90; 
     $self->{'Spruchprozente'}->{'Bereich_erkennen'} = 90;
     
     # Telepathie
     # TODO: nur bis RW 1, kann man das einfach dazu packen?
     $self->{'Spruchprozente'}->{'Gedanken_lesen'} =
       {'Spez50' => {'Tiefe' => 'Langzeitgedaechtnis'} };

     # Illusion
     $self->{'Spruchprozente'}->{'Bildillusion'} = 70; 
     $self->{'Spruchprozente'}->{'Unsichtbarkeit'} = 70; 








