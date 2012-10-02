#
# Diese Klasse soll mal einen mehr oder weniger vollstaendigen
# (Space-)ERPS-Charakter enthalten
# Momentan ist sie aber nur eine Hilfsklasse fuer den 
# Zauberspruchberechner 

package Charakter;
use strict;
use POSIX;

# use "Spruch";

# Der Konstruktor
sub new{
     my $class = shift;
     my $name = shift; # Der Name des Charakterfiles ohne .ch und Dir
     my $self = {};

     print "Charakter-new($name)\n";

     # einlesen des Charakterfiles... sehr simpel
     open(CHAR,"Charaktere/". $name . ".ch") or die "Fehler: $!\n";
     my @ev = <CHAR>;
     close CHAR;
     eval "@ev";

     return bless($self,$class);
}

# diese funktion berechnet die PSI-tragkraft, die fuer einige sprueche
# benoetigt wird
sub get_PSI_TRK{
     my $self = shift;

     return TRK_Tabelle($self->{'Basisattribut'}->{'PSI'});
}

# diese funktion berechnet die tragkraft
sub get_TRK{
     my $self = shift;

     return TRK_Tabelle($self->{'Basisattribut'}->{'STR'});
}

# diese funktion enthaelt die eigentliche tragkraft-tabelle
sub TRK_Tabelle{
     my $basis = shift;

     return 3 if($basis == 2);
     return 3.5 if($basis <= 4);
     return 4 if($basis <= 7);
     return 5 if($basis <= 14);
     return 6 if($basis <= 17);
     return 6.5 if($basis <= 19);
     return 7+($basis-20)/2;
}

# diese Funktion liefert den Wuerfelbonus
# fertigkeit + $::wuerfel_mod (+PSE)
sub bonus{
     my $self = shift;
     my $fertigkeit = shift;

     my $summe = 0;
     if(defined ( $self->{'Fertigkeit'}->{$fertigkeit})){
       $summe += $self->{'Fertigkeit'}->{$fertigkeit};
     }

     if(&Erps::ist_psi($fertigkeit)){
       if(defined ( $self->{'Fertigkeit'}->{'PSE'})){
	 $summe += $self->{'Fertigkeit'}->{'PSE'};
       }
     }
     # jetzt noch die Wuerfelmodifikationen
     $summe += $::wuerfel_mod;
     return $summe;
}

# das selbe mit magtheo statt PSE
# 
sub magtheo_bonus{
     my $self = shift;
     my $fertigkeit = shift;

     my $summe = 0;
     if(defined ( $self->{'Fertigkeit'}->{$fertigkeit})){
       $summe += $self->{'Fertigkeit'}->{$fertigkeit};
     }

     if(&Erps::ist_psi($fertigkeit)){
       if(defined ( $self->{'Fertigkeit'}->{'Magietheorie'})){
	 $summe += $self->{'Fertigkeit'}->{'Magietheorie'};
       }
     }
     # jetzt noch die Wuerfelmodifikationen
     $summe += $::wuerfel_mod;
     return $summe;
}

#  # diese Funktion wird zur Ermittlung der Magtheo Stufe benoetigt
#  sub bonus_magtheo{
#       my $self = shift;
#       my $f = shift;

#       return $self->{'Fertigkeit'}->{'Magietheorie'} +
#  	  $self->{'Fertigkeit'}->{$f};
#  }

# Diese Funktion erwartet als Argumente den MW, den Wuerfelwurf 
# und die Fertigkeit (Vorsicht beim Zaubern muss man nur den 
# Bereich angeben, aber PSE wird automatisch dazuaddiert!) 
# und gibt das Ergebnis zurueck in folgendem Format:
#
# ...                      ...
# doppelter Patzer         -3
# Patzer                   -2
# Misserfolg               -1
# (Fehler                   0)
# Erfolg                    1
# Krit                      2
# Doppelter Krit            3
# ...                      ...
# -$UNENDLICH bedeutet: unendlicher Patzer (negatives Ergebnis)
#

sub berechne_ergebnis{
     my $self = shift;
     my $mw = shift;
     my $gewuerfelt = shift;
     my $fertigkeit = shift;

     my $summe = $gewuerfelt + $self->{'Bonus'};

#
# hier jetzt die eigentliche berechnung ...
# erstmal etwas daemlich nur bis zu doppelkrits
# TODO: verallgemeinerung in schleifen statt copy&paste

     my $ergebnis = 0;
     
     if($::RULE_VERSION == 1){
     	     $ergebnis = -5 if($summe >= $mw/32 && $summe < $mw/16);
     	     $ergebnis = -4 if($summe >= $mw/16 && $summe < $mw/8);
     	     $ergebnis = -3 if($summe >= $mw/8 && $summe < $mw/4);
     	     $ergebnis = -2 if($summe >= $mw/4 && $summe < $mw/2);
     	     $ergebnis = -1 if($summe >= $mw/2 && $summe < $mw);
     	     $ergebnis = 1  if($summe >= $mw && $summe < $mw*2);
     	     $ergebnis = 2  if($summe >= $mw*2 && $summe < $mw*3);
     	     $ergebnis = 3  if($summe >= $mw*3 && $summe < $mw*4);
     	     $ergebnis = 4  if($summe >= $mw*4 && $summe < $mw*5);
     	     $ergebnis = 5  if($summe >= $mw*5 && $summe < $mw*6);
     	     $ergebnis = 6  if($summe >= $mw*6 && $summe < $mw*7);
     	     $ergebnis = 7  if($summe >= $mw*7 && $summe < $mw*8);
     	     $ergebnis = 8  if($summe >= $mw*8 && $summe < $mw*9);
     	     $ergebnis = 9  if($summe >= $mw*9 && $summe < $mw*10);
     }else{
     	  $ergebnis = POSIX::floor(($summe - $mw) / 10) + 1;
     }

# Sonderbehandlung fuer die 1-1:

     if($gewuerfelt == 2 && $ergebnis != 0){
	  # eine stufe runter
	  $ergebnis--;
	  # immer misserfolg und wg. 0 = Fehler!
	  if($ergebnis >= 0){
	       $ergebnis = -1;
	  }     
     }

# sonderbehandlung fuer negative(und null) ergebnisse
     $ergebnis = -$::UNENDLICH if($summe <= 0);

     print "summe: $summe mw: $mw ergebnis: $ergebnis gewuerfelt: $gewuerfelt\n";
     
     return $ergebnis;
}

#
# Diese Funktion gibt die Prozente zurueck unter Beachtung der 
# Spezialisierung...
#

sub get_prozente{
     my $self = shift;
     my $spruch = shift;
     
     my $spruref = $::sprueche->{$spruch};

     print "Ober: $spruref->{'Oberspruch'}\n";

     # eh unschoen global...
     my $vars = $spruref->{'Variablen'};

     my $charakterprozente = $self->{'Spruchprozente'}->{$spruch};

     $charakterprozente = 100  if(!defined($charakterprozente));

     # Obersprueche
     my $ober = $spruref->{'Oberspruch'};
     for my $os (@$ober){
       my $oberprotz = $self->get_prozente($os);
       if($oberprotz < $charakterprozente){
	 $charakterprozente = $oberprotz ;
       }
     }

#     return 100 if($charakterprozente == 100);

     if(!ref($charakterprozente)){
       return $charakterprozente;
     }else{
       my $c_hat50 = $charakterprozente->{'Spez50'};
       my $c_hat60 = $charakterprozente->{'Spez60'};
       if($c_hat50){
	 if(ref($c_hat50) eq 'ARRAY'){
	   for my $count (@$c_hat50){
	     return 50 if($spruref->spezialisierung_passt($count));
	   }
	 }else{
	   return 50 if($spruref->spezialisierung_passt($c_hat50));
	 }
       }
       if($c_hat60){
	 if(ref($c_hat60) eq 'ARRAY'){
	   for my $count (@$c_hat60){
	     return 60 if($spruref->spezialisierung_passt($count));
	   }
	 }else{
	   return 60 if($spruref->spezialisierung_passt($c_hat60));
	 }
       }
       return 70;
     }
}


#
# liefert die erhoehung des mw zurueck, wg. nicht vorhandenen
# Fertigkeiten

sub get_erhoehung{
  my $self = shift;
  my $fert = shift;

  return 0 if(defined($self->{'Fertigkeit'}->{$fert}));

  my $bereich = Erps::get_bereich($fert);
  return 5 if(!defined($bereich));
  my $prio = $self->{'Prioritaet'}->{$bereich};
  
  return 5 if($prio == 0);
  return 3 if($prio == 1);
  return 2 if($prio == 2);
  return 0 if($prio == 3); # fuer space-erps und erps++
}

  



1;









