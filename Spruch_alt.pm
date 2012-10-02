#
# Das soll mal eine allgemeine Zauberspruchklasse werden. Zur Zeit 
# kann sie nur einen Spruch, naemlich Schockstrahl...
#

package Spruch;
use POSIX;
use strict;

# Konstruktor:
# Die Wesentliche Arbeit machen hier die abgeleiteten Klassen
sub new{
     my $class = shift;
     my $self = {};
     
     return bless($self,$class);
}

#
# Diese Funktion ermittelt die Mindestwuerfe...
#
# Eingabe: Zauberer-Referenz
#          gesenkt um wieviel Punkte
#          Reichweite (ab hier Spruchspezifisch)
#          Schaden
#
# Ausgabe: (als Hashreferenz)
#          'Grund':     Grundmindestwurf
#          'Ungesenkt': ungesenkter MW
#          'Gesenkt':   gesenkter MW

sub berechne{
     # standardparameter
     my $self = shift;
     my $zauberer = shift;
     my $gesenkt_um = shift;

     my $mw = {};

     # berechnete "parameter"
#     my $PSI = $zauberer->{'Basisattribut'}->{'PSI'};
     my $prozente = $zauberer->{'Spruchprozente'}->{$self->get_name()};
#     my $PSE = $zauberer->{'Fertigkeit'}->{'PSE'};
#     my $fertigkeit = $zauberer->{'Fertigkeit'}
#     ->{$self->{'Fertigkeit'}};
#     my $bonus = $PSE + $fertigkeit;

     $mw->{'Grund'} = $self->formel();

     $mw->{'Ungesenkt'} = POSIX::floor
	  ($mw->{'Grund'} * ($prozente/100) 
	   * ($self->dauer_prozente($main::dauer)/100) + 0.5 + $main::mw_mod);
     $mw->{'Gesenkt'} = $mw->{'Ungesenkt'} - $gesenkt_um;

     return $mw;
}

#
# Diese Funktion gibt ein BrowseEntry-Widget zurueck, dass auf
# der Eingabe-Seite angezeigt wird. 
# Parameter: - Das Label
#            - Die Variable als Skalar-Referenz
#            - deren Defaultwert
#            - wie soll ich initialisieren?

sub get_input_var{
     my $label = shift;
     my $var_ref = shift;
     my $default = shift;
     my $listref = shift;
#      my $init = shift;

     $$var_ref = $default;
     my $back =  $main::spruch_frame->BrowseEntry
	  (-label => $label,
	   -variable => $var_ref,
	   -browsecmd => \&main::aktualisieren
	   );

     if($listref){
	  for my $entry (@$listref){
	       $back->insert('end', $entry);
	  }
     }
     $back->Subwidget('entry')->bind('<Key-Return>',
					      \&main::aktualisieren);
     return $back;
}

#
# hier wird nur ein checkbutton zurueckgeliefert.
# params: - der text
#         - die variablenreferenz
#

sub get_input_flag{
     my $text = shift;
     my $var_ref = shift;

     return $main::spruch_frame->Checkbutton
	  (-text => $text,
	   -command => \&main::aktualisieren,
	   -variable => $var_ref,
	   -onvalue => '1',
	   -offvalue => '0');
}

# Das selbe fuer die Ausgabe-Seite
sub get_output_text{
     my $text = shift;

     return $main::spruch_out_frame->Label(-text => $text);
}

#
# Die allgemeine Pack-Routine, kann evntl. ueberladen werden
#
sub pack{
     my $self = shift;

     my $widget;
     my $arrayref = $self->get_spruchabhaengig();
     foreach $widget (@$arrayref){
	  # besser waere hier eine packung mit unterschiedlichen params
	  $widget->pack(-anchor => 'e');
     }
}

#
# Diese Funktion liefert die Prozente, die durch variierte Zauberdauer
# entstehen (vergleich mit 'Dauer'des Spruchs)
# params: - Zauberdauer 
#

sub dauer_prozente{
     my $self = shift;
     my $neudauer = shift;
     my $dauer = $self->{'Dauer'};

     return 100 if ($neudauer eq $dauer);

     my $neudauer_int = dauer2int($neudauer);
     my $dauer_int = dauer2int($dauer);

     my $diff = $neudauer_int - $dauer_int;

     return (100-$diff*10) if ($diff > 0);
     return 120 if ($diff == -1);
     return 150 if ($diff == -2);

     return $main::UNENDLICH;
}

# eine kleine hilfsfunktion fuer die obige, die text-dauer in einen
# zahlenwert umwandelt
sub dauer2int{
     my $dauer = shift;

     return 1 if($dauer eq 'Sofortiger Zauber');
     return 2 if($dauer eq 'Rundenzauber');
     return 3 if($dauer eq 'Minutenzauber');
     return 4 if($dauer eq 'Stundenzauber');
     return 5 if($dauer eq 'Tagezauber');
     die "falsche Dauerangabe!\n";
}

#
# diese funtion wird ueblicherweise ueberladen wg. spezialisierung etc.
#

sub get_name{
     my $self = shift;
     return $self->{'Name'};
}

#
# Hier wird die Formel aufgerufen. 
# Befindet sich als Codereferenz im Objekt
#
 
sub formel{
     my $self = shift;
     print "Formel von $self\n";

   my $back = $self->{'Formel'}->($self);

   return $back;
}

1;






