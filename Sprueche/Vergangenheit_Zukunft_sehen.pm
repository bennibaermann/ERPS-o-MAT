#
# Von der algemeinen Spruchklasse abgeleitete Klasse 
# zum wandern in der Zeit

package Vergangenheit_Zukunft_sehen;
use strict;
use Spruch;

@Vergangenheit_Zukunft_sehen::ISA = qw(Spruch);

sub new{
     my $type = shift;
     my $self = Spruch->new();

     $self->{'Name'} = "Vergangenheit_Zukunft_sehen";
     $self->{'Dauer'} = "Sofortiger Zauber";
     $self->{'Beschreibung'} = "blablba";

     $self->{'Fertigkeit'} = 'Wahrnehmung'; # dimension geht auch!

     bless $self,$type;
}

#
# Hier wird die eigentliche Formel fuer den Spruch bereitgestellt
#

sub formel{
     my $self = shift;
     my $mw = 24 + $self->{'zeit_zahl'}**2;
     return $mw+5 if($self->{'Ton'});
     return $mw;
}

# diese Funktion berechnet die Mindestwuerfe und verwendet
# dazu die berechne-Funktion der Basisklasse

sub berechne{
     my $self = shift;
     my $zauberer = shift;
     my $gesenkt_um = shift;
     my $zeitraum = shift;
     my $ton = shift;

     $self->{'Ton'} = $ton;

# zeitraumbehandlung kann man vielleicht geschickter machen,
# insbesondere, wenn das mehrere sprueche verwenden...
     $self->{'zeit_zahl'} = 0;
     $self->{'zeit_zahl'} = 1 if ($zeitraum eq '1 Stunde');
     $self->{'zeit_zahl'} = 2 if ($zeitraum eq '6 Stunden');
     $self->{'zeit_zahl'} = 3 if ($zeitraum eq '1 Tag');
     $self->{'zeit_zahl'} = 4 if ($zeitraum eq '1 Woche');
     $self->{'zeit_zahl'} = 5 if ($zeitraum eq '1 Monat');
     $self->{'zeit_zahl'} = 6 if ($zeitraum eq '3 Monate');
     $self->{'zeit_zahl'} = 7 if ($zeitraum eq '1 Jahr');
     $self->{'zeit_zahl'} = 8 if ($zeitraum eq '3 Jahre');
     $self->{'zeit_zahl'} = 9 if ($zeitraum eq '10 Jahre');

     my $mws = $self->Spruch::berechne($zauberer,$gesenkt_um);
     return $mws;
}

# diese funktion gibt referenzen auf die spruchabhaengigen teile 
# der oberflaeche zurueck
sub get_spruchabhaengig{
     my $self = shift;

     my $back = [$self->{'Ton_wahl'}, 
		 $self->{'Zeitraum_wahl'}];
     return $back;	  
}

# hier wird die spruchabhaengige oberflaeche erzeugt
sub create_oberflaeche{
     my $self = shift;

     my @eintraege = qw/'1 Stunde' '6 Stunden' '1 Tag' '1 Woche' '1 Monat'
	  '3 Monate' '1 Jahr' '3 Jahre' '10 Jahre'/;
     $self->{'Zeitraum_wahl'} = 
     Spruch::get_input_var('Zeitraum: ',\$self->{'zeitraum'},
			   '1 Stunde',\@eintraege);

     $self->{'Zeitraum_wahl'}->insert('end','1 Stunde');
     $self->{'Zeitraum_wahl'}->insert('end','6 Stunden');
     $self->{'Zeitraum_wahl'}->insert('end','1 Tag');
     $self->{'Zeitraum_wahl'}->insert('end','1 Woche');
     $self->{'Zeitraum_wahl'}->insert('end','1 Monat');
     $self->{'Zeitraum_wahl'}->insert('end','3 Monate');
     $self->{'Zeitraum_wahl'}->insert('end','1 Jahr');
     $self->{'Zeitraum_wahl'}->insert('end','3 Jahre');
     $self->{'Zeitraum_wahl'}->insert('end','10 Jahre');

# TODO: hier muss dann noch ein Radiobutton hin...
#     $self->{'Ton_wahl'}

     $self->{'Ton_wahl'} = 
     Spruch::get_input_flag('Ton dazu: ',\$self->{'Ton'});
}

sub aktualisieren{
     my $self = shift;

     my $mws = $self->berechne($main::stoffel,
					$main::gesenkt_um,
					$self->{'zeitraum'},
			       $self->{'Ton'});			     
     return $mws;
};

1;
