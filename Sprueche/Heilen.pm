#
# Von der algemeinen Spruchklasse abgeleitete Klasse 
# zum Heilen von Trefferpunkten

package Heilen;
use strict;
use Spruch;

@Heilen::ISA = qw(Spruch);

sub new{
     my $type = shift;
     my $self = Spruch->new();

     $self->{'Name'} = "Heilen";
     $self->{'Dauer'} = "Minutenzauber";
     $self->{'Beschreibung'} = "sdablba";

     $self->{'Fertigkeit'} = 'Regeneration'; # Koerperbewusstsein auch

     bless $self,$type;
}

#
# Hier wird die eigentliche Formel fuer den Spruch bereitgestellt
#

sub formel{
     my $self = shift;
     my $mod;

     $mod = 0 if($self->{'Wundgroesse'} eq 'leicht');
     $mod = 2 if($self->{'Wundgroesse'} eq 'mittel');
     $mod = 5 if($self->{'Wundgroesse'} eq 'schwer');

     return 10 + $self->{'TP'} + $mod;
}

# diese Funktion berechnet die Mindestwuerfe und verwendet
# dazu die berechne-Funktion der Basisklasse

sub berechne{
     my $self = shift;
     my $zauberer = shift;
     my $gesenkt_um = shift;
     my $groesse = shift;
     my $tp = shift;

     $self->{'Wundgroesse'} = $groesse;
     $self->{'TP'} = $tp;

     my $mws = $self->Spruch::berechne($zauberer,$gesenkt_um);
     return $mws;
}

# diese funktion gibt referenzen auf die spruchabhaengigen teile 
# der oberflaeche zurueck
sub get_spruchabhaengig{
     my $self = shift;

     my $back = [$self->{'TP_wahl'},$self->{'leicht'},
		 $self->{'mittel'},$self->{'schwer'},
		 $self->{'groesse_wahl'}];
     return $back;	  
}

# hier wird die spruchabhaengige oberflaeche erzeugt
sub create_oberflaeche{
     my $self = shift;

     $self->{'Wundgroesse'} = 'leicht';
     $self->{'groesse_wahl'} = $main::spruch_frame->LabFrame
	  (-label => 'Wundgroesse',
	   -labelside => 'acrosstop');
     $self->{'leicht'} = $self->{'groesse_wahl'}->Radiobutton
	  (-text => 'leicht (1-10)',
	   -variable => \$self->{'Wundgroesse'},
	   -value => 'leicht',
	   -command => \&main::aktualisieren);
     $self->{'mittel'} = $self->{'groesse_wahl'}->Radiobutton
	  (-text => 'mittel (11-20)',
	   -variable => \$self->{'Wundgroesse'},
	   -value => 'mittel',
	   -command => \&main::aktualisieren);
     $self->{'schwer'} = $self->{'groesse_wahl'}->Radiobutton
	  (-text => 'schwer (21-..)',
	   -variable => \$self->{'Wundgroesse'},
	   -value => 'schwer',
	   -command => \&main::aktualisieren);

     my @eintraege = (1..$main::MAX_WUND);
     $self->{'TP_wahl'} =      Spruch::get_input_var
	  ('TP zu heilen: ',\$self->{'TP'}, 10, \@eintraege);
}

sub pack{
     my $self = shift;

      $self->{'TP_wahl'}->pack(-anchor => 'e');
     $self->{'groesse_wahl'}->pack(-anchor => 'e');

      $self->{'leicht'}->pack(-side => 'left'); 
      $self->{'mittel'}->pack(-side => 'left'); 
      $self->{'schwer'}->pack(-side => 'left'); 
}


sub aktualisieren{
     my $self = shift;

#
# TODO: - RW Dezimeterlinear oder +2linear
#       - Wundgroesse passt sich an auf Mindestwert: list->delete()

     my $mws = $self->berechne($main::stoffel,
					$main::gesenkt_um,
					$self->{'Wundgroesse'},
			       $self->{'TP'});			     
     return $mws;
};

#
# ueberladen. dadurch kann man spezialisierungen beruecksichtigen
# in diesem fall wird die spezialisierung ueber die wundgroesse gemacht

sub get_name{
     my $self = shift;
     
     my $basename = $self->{'Name'};
     my $groesse = $self->{'Wundgroesse'};
     my $tp = $self->{'TP'};
     
     my ($name,$iname);
     my @iter;
     # schwere wunden sind immer gut
     $iname = "$basename schwerer Wunden";
     print "Suche nach: $iname\n";
     if(defined $main::stoffel->{'Spruchprozente'}->{$iname}){
	  print "gefunden: $iname\n";
	  $name = $iname;
	  @iter = reverse (0..$main::MAX_WUND);
     }	       
     if(!($groesse eq 'schwer') && !defined($name)){
	  $iname = "$basename mittlerer Wunden";
	  print "Suche nach: $iname\n";
	  if(defined $main::stoffel->{'Spruchprozente'}->{$iname}){
	       print "gefunden: $iname\n";
	       $name = $iname;
	       @iter = reverse (0..20);
	  }	       
     }
     if($groesse eq 'leicht' && !defined($name)){
	  $iname = "$basename leichter Wunden";
	  print "Suche nach: $iname\n";
	  if(defined $main::stoffel->{'Spruchprozente'}->{$iname}){
	       print "gefunden: $iname\n";
	       $name = $iname;
	       @iter = reverse (0..10);
	  }	       
     }

     # hier muss jetzt ueberprueft werden, ob eine passende
     # wundgroesse gefunden wurde, wenn nicht, return, wenn ja
     # suchen wir weiter nach spezialisierungen
     return $basename if(!defined ($name));

     # stimmt immer noch nicht 100%ig, da nicht eindeutig geklaert ist
     # zu welcher wundgroesse eine tp-spezialisierung gehoert!!!
     # regelluecke?

     for my $i (@iter){
	  last if($tp > $i);
	  $iname = "$basename von $i TP";
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
