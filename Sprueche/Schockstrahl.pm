#
# Von der algemeinen Spruchklasse abgeleitete Klasse fuer Schockstrahlen
#

package Schockstrahl;
use strict;
use Spruch;

@Schockstrahl::ISA = qw(Spruch);

sub new{
     my $type = shift;
     my $self = Spruch->new();

     $self->{'Name'} = "Schockstrahl";
     $self->{'Dauer'} = "Sofortiger Zauber";
     $self->{'Beschreibung'} = "SP-Schaden, Ruestung zaehlt nicht.";

     $self->{'Fertigkeit'} = 'Schock';

     bless $self,$type;
}

#
# Hier wird die eigentliche Formel fuer den Spruch bereitgestellt
#

sub formel{
     my $self = shift;
     return 13 + $self->{'RW'}**2 + $self->{'Schaden'}**2;
}

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
# der oberflaeche zurueck
sub get_spruchabhaengig{
     my $self = shift;

     my $back = [$self->{'RWwahl'}, 
		 $self->{'schaden_wahl'}, 
		 $self->{'RWm'}];
     return $back;	  
}

# hier wird die spruchabhaengige oberflaeche erzeugt
sub create_oberflaeche{
     my $self = shift;

     my @eintraege = (1..10);
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

#
# ueberladen. dadurch kann man spezialisierungen beruecksichtigen
# in diesem fall wird die spezialisierung ueber schaden gemacht.

sub get_name{
     my $self = shift;
     
     my $basename = $self->{'Name'};
     my $schaden = $self->{'Schaden'};

     my @iter = reverse (0..10);
     my ($name,$iname);
     for my $i (@iter){
	  last if($schaden > $i);
	  $iname = $i . "w " . $basename;
	  print "Suche nach: $iname\n";
	  if(defined $main::stoffel->{'Spruchprozente'}->{$iname}){
	       print "gefunden: $iname\n";
	       $name = $iname;
	  }	       
     }
     $name = $basename if(!defined $name);
     print "endgueltiger Name: $name\n";
     return $name;
}

1;
