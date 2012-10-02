#
# Von der algemeinen Spruchklasse abgeleitete Klasse fuer Elementstrahlen
#

package Elementstrahl;
use strict;
use Spruch;

@Elementstrahl::ISA = qw(Spruch);

sub new{
     my $type = shift;
     my $self = Spruch->new();

     $self->{'Name'} = "Elementstrahl";
     $self->{'Dauer'} = "Sofortiger Zauber";
     $self->{'Beschreibung'} = "TP-Schaden, Ruestung zaehlt,".
	  " Trefferzone beachten.";

     $self->{'Fertigkeit'} = 'Elemente';

     # testweise parametrisierung der formel als anonyme
     # code-referenz. als vorstufe zur Spruchparametrisierung
     $self->{'Formel'} = sub {
	  my $self = shift;
	  print "anonyme Formel von $self\n";
	  return 15 + $self->{'RW'}**2 + $self->{'Schaden'}**2;
     };

     bless $self,$type;
}

# #
# # Hier wird die eigentliche Formel fuer den Spruch bereitgestellt
# #

# sub formel{
#      my $self = shift;
#      print "Formel von $self\n";
# #     return 15 + $self->{'RW'}**2 + $self->{'Schaden'}**2;

# # zur parametrisierung. so sollte dann spaeter die formel in der
# #    basisklasse aussehen
#    my $back = $self->{'Formel'}->($self);

#    return $back;
# }


# diese Funktion berechnet die Mindestwuerfe und verwendet
# dazu die berechne-Funktion der Basisklasse

sub berechne{
     my $self = shift;
     my $zauberer = shift;
     my $gesenkt_um = shift;
     my $RW = shift;
     my $schaden = shift;

     $self->{'RW'} = $RW;
     $self->{'Schaden'} = $schaden;
     
     my $mws = $self->Spruch::berechne($zauberer,$gesenkt_um);
     return $mws;
}

# diese funktion gibt referenzen auf die spruchabhaengigen teile 
# der oberflaeche zurueck (widgetreferenzen)
sub get_spruchabhaengig{
     my $self = shift;

     # TODO: bei parametrisierung: einfach pro variable einen

     [$self->{'RWwahl'}, $self->{'schaden_wahl'}, $self->{'RWm'}]; 
}

# hier wird die spruchabhaengige oberflaeche erzeugt
sub create_oberflaeche{
     my $self = shift;

     my @eintraege = (0..10);
     $self->{'RWwahl'} = Spruch::get_input_var('RW: ',\$self->{'RW'},
					       1,\@eintraege);
     print "RWwahl: $self->{'RWwahl'}\n";
     $self->{'schaden_wahl'} = Spruch::get_input_var('Schaden: ',
						\$self->{'Schaden'}, 
						     4,\@eintraege);
     $self->{'RWm'} = Spruch::get_output_text('RW: 0 Meter');
}

sub aktualisieren{
     my $self = shift;

     my $RWmeter_text = "RW: " .
	  $self->{'RW'} * $main::stoffel->{'Basisattribut'}->{'PSI'} . 
	       " Meter";

     $self->{'RWm'}->configure(-text => $RWmeter_text);

     my $mws = $self->berechne($main::stoffel,
					$main::gesenkt_um,
					$self->{'RW'},
			       $self->{'Schaden'});			     
     return $mws;
};



1;
