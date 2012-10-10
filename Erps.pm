# In diesem Modul sind einfach ein paar Funktionen versammelt, 
# die allgemein ERPS-maessig von Nutzen sind

package Erps;
use POSIX;

# diese funktion erwartet den MW und liefert die standardkosten zurueck
sub standard_psi_kosten{
     my $mw = shift;
     return POSIX::floor($mw/5);
}

# Diese Funktion erwartet ein Ergebnis in der Form, wie es 
# Charakter::berechne_ergebnis liefert und die 
# Standard-PSI-Kosten und liefert dann die wirklichen PSI-Kosten 
# zurueck

sub berechne_PSI_Kosten{
     my $ergebnis = shift;
     my $kosten = shift;

     $total = multiplikator($ergebnis) * $kosten;

     return $total;
}

#
# Diese Funktion wandelt kodierte Ergebnisse in Text um
#
sub decode{
     my $ergebnis = shift; 
     my $unendlich = shift;
     
     return "unendlicher Patzer" if($ergebnis == -$unendlich);
     return "Fehler" if($ergebnis == 0);
     return "normal geschafft" if($ergebnis == 1);
     return "normal nicht geschafft" if($ergebnis == -1);
     return "kritischer Erfolg" if($ergebnis == 2);
     return "doppelt kritischer Erfolg" if($ergebnis == 3);
     return "dreifach kritischer Erfolg" if($ergebnis == 4);
     return "vierfach kritischer Erfolg" if($ergebnis == 5);
     return "fuenffach kritischer Erfolg" if($ergebnis == 6);
     return "sechsfach kritischer Erfolg" if($ergebnis == 7);
     return "siebenfach kritischer Erfolg" if($ergebnis == 8);
     return "achtfach kritischer Erfolg" if($ergebnis == 9);
     return "kritischer Misserfolg" if($ergebnis == -2);
     return "doppelt kritischer Misserfolg" if($ergebnis == -3);
     return "dreifach kritischer Misserfolg" if($ergebnis == -4);
     return "vierfach kritischer Misserfolg" if($ergebnis == -5);
     return "fuenffach kritischer Misserfolg" if($ergebnis == -6);
     if($ergebnis < 0){
	  my $tmp = abs($ergebnis)-1;
	  return "$tmp-facher kritischer Misserfolg";
     }else{ # $ergebnis > 0 !!
	  my $tmp = $ergebnis-1;
	  return "$tmp-facher kritischer Erfolg";
     }
     return "???";
}
     

# Diese Funktion erwartet ein Ergebnis und liefert einen 
# PSI-Kosten-Multiplikator
#

sub multiplikator{
     my $e = shift;

     # geht das auch eleganter? wahrscheinlich. Aber wozu?
     if(abs($e) == 1){
	  return 1;
     }
     # stimmt das regeltechnisch ueberhaupt? ja, jetzt schon...
     if($e > 1){
	  return 1/(2**($e-1));
     }
     if($e < -1){
	  return 2**abs($e+1);
     }
     return 0;
}

###################################################################
# Fuer diesen nun folgenden leicht mathematisch angehauchten Teil #
# danke ich Dominikus Scherkl fuer seine Unterstuetzung!          #
###################################################################

#
# Diese Funktion gibt die Anzahl der Kombinationen bei einem 
# geschlossenen 2w10 zurueck.
# - param: erwartete summe
#
sub kombi{
     my $summe = shift;
     return 0 if($summe < 2 || $summe > 18);
     my $s = abs ($summe - 10);
     return 9 - $s;
}

##############
# Alle WS in Prozent!
#############

# WS dass der Fertigkeitswurf gelingt
sub WS_Fert{
     my $MW = shift;
     return 99 if ($MW <= 2);
     return WS_geq($MW);
}

# Diese Funktion berechnet die Wahrscheinlichkeit eines erfolgreichen
# Lernpunktwurfes
sub WS_LP{
     my $MW = shift;
     my $w = WS_Fert($MW)/100;
     return 1 * $w if ($MW <= 2);
     return 100*($w * WS_less($MW)/100);
}

# Diese Funktion ermittelt die WS, dass man neue Prozente kriegt.
# Dazu muss der ungesenkte mw als zweiter parameter herhalten
sub WS_Magtheo{
     my $MW = shift;
     my $MW_ungesenkt = shift;
     my $w = WS_LP($MW)/100;
     return 99 * $w if($MW_ungesenkt <= 2);
     return 100*($w * WS_geq($MW_ungesenkt)/100);
}

# und jetzt noch der Magtheo-Lernpunkt
sub WS_Magtheo_LP{
     my $MW = shift;
     my $MW_ungesenkt = shift;
     my $w = WS_Magtheo($MW,$MW_ungesenkt)/100;
     return 1 * $w if ($MW_ungesenkt <= 2);
     return 100*
	  ($w * WS_less($MW_ungesenkt)/100);
}

# Diese Funktion gibt die angenaeherte WS zurueck, dass ein offener
# 2w10 Wurf gleich dem Parameter ist.
sub WS_eq_Generator{
     my $para = shift;

     my $sum = 0;

     $k = int(($para-10)/10);
     $sum += term($para,$k) if $k >= 0;
     $sum += term($para,$k+1);

     return $sum;
}

sub term{
  my $para = shift;
  my $k = shift;

  return kombi($para - $k*10) * (10**(-$k)) * ($k+1);
}

# Das selbe fuer kleiner
#sub WS_less_Generator{
#     my $para = shift;
 #    print "WS_less($para) = ";

 #    my $sum = 0;
  #   for my $i (2..$para-1){
#	  $sum += WS_eq_Generator($i);
 #    }
#     print " $sum\n";
  #   return $sum;
#}

# groesser oder gleich
sub WS_geq{
     my $para = shift;
#     print "WS_geq($para)\n";

     return 100*(1 - WS_less($para)/100);
}

# die wahrscheinlichkeit, dass der wurf von param1 bis param2 liegt.
sub WS_zwischen{
     my $von = shift;
     my $bis = shift;
     return WS_less($bis+1) - WS_less($von);
}

sub WS_eq{
  my $para = shift;
  return WS_less($para+1) - WS_less($para);
}

sub WS_less{
  my $para = shift;
  return $Erps::ws_tab[$para-1]; 
}

# hier werden die wahrscheinlichkeitswerte vorberechnet
# wg. schneller
sub WS_Generator{
    my $conf = shift;
    # use Data::Dumper; print Dumper $conf;
    
    print "Wahrscheinlichkeiten vorberechnen\n";
    $Erps::ws_tab[1] = 0;
    for my $w (2..$conf->{-MAXWURF}){
    	$Erps::ws_tab[$w] = $Erps::ws_tab[$w-1] + WS_eq_Generator($w);
    	print ".";
    	# print "WS $w: $Erps::ws_tab[$w]\n";
    }
    print "fertig.\n"

}

#################################
# Ende des mathematischen Teils #
#################################

# Diese Funktion gibt zurueck, ob eine Fertigkeit ein PSI-Bereich ist
# (auf die PSE draufaddiert werden muss)
sub ist_psi{
     my $f = shift;

     return 1 if($f eq 'Schock');
     return 1 if($f eq 'Elemente');
     return 1 if($f eq 'Wahrnehmung');
     return 1 if($f eq 'Regeneration');
     return 1 if($f eq 'Illusion');
     return 1 if($f eq 'Bewegung');
     return 1 if($f eq 'Kontrolle');
     return 1 if($f eq 'Binden');
     return 1 if($f eq 'Koerperbewusstsein');
     return 1 if($f eq 'Verstaendnis');
     return 1 if($f eq 'Telepathie');     
     return 1 if($f eq 'Gegenmagie');
     return 1 if($f eq 'Beschwoeren');
     return 1 if($f eq 'Empathie');
     return 1 if($f eq 'Materietransformation');
     return 1 if($f eq 'Natur');
     return 1 if($f eq 'Dimension');
     return 1 if($f eq 'Hypnose');
     return 0;
}

#
# Diese Funktion liefert den Bereich einer Fertigkeit
# kann vorerst nur psi... ;-)

sub get_bereich{
  my $fert = shift;

  if(ist_psi($fert)){
    return 'PSI';
  }
  return undef;
}

#
# Wahrscheinlichkeitstabelle vorberechnen
# aber nur, wenn das nicht schon geschehen ist
# sollte beim ersten "use ERPS;" passieren.
sub init_erps{
    my $class = shift; # not in use
    my $conf = shift;
    &Erps::WS_Generator($conf) unless defined $ERPS::ws_tab;
}
1;





