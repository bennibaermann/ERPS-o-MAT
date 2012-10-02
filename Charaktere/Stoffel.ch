#
# Die erste Charakterdatei zum Testen
# Diese Datei wird einfach in Charakter.pm rein-required...

     # wird zum testen einfach auf stoffel festgelegt
     $self->{'Name'} = "Stoffel, Freiherr von Inmeril";
     $self->{'Basisattribut'}->{'PSI'} = 19;  
     $self->{'Basisattribut'}->{'STR'} = 10;  

     $self->{'Fertigkeit'}->{'PSE'} = 14;
     $self->{'Fertigkeit'}->{'Magietheorie'} = 15;
     $self->{'Fertigkeit'}->{'Schock'} = 8;
     $self->{'Fertigkeit'}->{'Elemente'} = 7;
     $self->{'Fertigkeit'}->{'Wahrnehmung'} = 7;
     $self->{'Fertigkeit'}->{'Regeneration'} = 8;
     $self->{'Fertigkeit'}->{'Illusion'} = 4;
     $self->{'Fertigkeit'}->{'Bewegung'} = 6;
     $self->{'Fertigkeit'}->{'Kontrolle'} = 4;
     $self->{'Fertigkeit'}->{'Binden'} = 7;
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
     $self->{'Spruchprozente'}->{'Teleportation'} = 80;

     # Elemente
     $self->{'Spruchprozente'}->{'Elementstrahl'} = 80;
     $self->{'Spruchprozente'}->{'Elementvolumen'} = 80;
     $self->{'Spruchprozente'}->{'Elementball'} = 80;
     $self->{'Spruchprozente'}->{'Stillezone'} = 90;

     # Regeneration
     $self->{'Spruchprozente'}->{'mittlere_Wunden_heilen'} = 70;
     $self->{'Spruchprozente'}->{'Verbrennungen_heilen'} = 90;
     $self->{'Spruchprozente'}->{'Koma_unterbrechen'} = 90;
     $self->{'Spruchprozente'}->{'Gift_neutralisieren'} = 90;

     # Kontrolle
     $self->{'Spruchprozente'}->{'Handlungen_beherrschen'} = 90;

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

     # Beschwoeren
     $self->{'Spruchprozente'}->{'Kundschafter'} = 70; 
     $self->{'Spruchprozente'}->{'Traeger'} = 90; 

     # Binden
     $self->{'Spruchprozente'}->{'Dimension_binden'} = 90; 
     $self->{'Spruchprozente'}->{'Bewegung_binden'} = 90; 
     $self->{'Spruchprozente'}->{'Artefakt_verstehen'} = 90; 

     # Bewegung
     $self->{'Spruchprozente'}->{'Laehmen'} = 80; 
     
     # Gegenmagie
     $self->{'Spruchprozente'}->{'Sphaere_durchdringen'} = 90; 
     $self->{'Spruchprozente'}->{'Bewegung_bannen'} = 80; 
     $self->{'Spruchprozente'}->{'Empathie_bannen'} = 90; 
     $self->{'Spruchprozente'}->{'Elemente_bannen'} = 90; 

     # Verstaendnis
     $self->{'Spruchprozente'}->{'Sprache_verstehen'} = 80; 
     $self->{'Spruchprozente'}->{'Arjol_Kommunikation'} = 90; 
     $self->{'Spruchprozente'}->{'Entschluesselung'} = 90; 

     # Telepathie
     $self->{'Spruchprozente'}->{'Gedanken_lesen'} =
       {'Spez50' => {'Tiefe' => 'Langzeitgedaechtnis'} };

     # Illusion
     $self->{'Spruchprozente'}->{'Bildillusion'} = 80; 
     $self->{'Spruchprozente'}->{'Unsichtbarkeit'} = 80; 








