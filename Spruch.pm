#
# Die allgemeine Zauberspruchklasse
#

package Spruch;
use POSIX;
use strict;
use Eomconfig;
# use Tk;
# use Tk::BrowseEntry;
# use Tk::Radiobutton;
# use Tk::Table;
# use Tk::LabFrame;

# Konstruktor:
sub new{
    my $class = shift;
    my $name = shift; # spruch
    my $stoffel = shift; # character
    my $mode = shift; $mode = 'tk' unless defined $mode; # tk oder web?
    
    my $self = {};
    
    print "Spruch->new($name)\n" if $mode eq 'tk';
    
    my $conf = Eomconfig->new();
        
    # einlesen des Spruchfiles...
    my $path = $conf->{-SPRUCHDIR} . $name . '.sp';
    open(SPRU,$path) or die "Kann Spruchdatei $path nicht oeffnen: $! ";
    my @ev = <SPRU>;
    close SPRU;
    eval "@ev";
  
    # config
    $self->{-config} = $conf;
    
    $self->{-mode} = $mode;
    
    $self = bless($self,$class);
    $self->match_skill();
    $self->set_char($stoffel);
    
    return $self;
}

sub set_char{
    my $self = shift;
    my $char = shift;
    
    $self->{-char} = $char;
}

# ermittelt welcher skill des aktuellen chars fuer den spruch verwendet wird.
# momentan wird einfach der hoechste genommen
sub match_skill{
    my $self = shift;
    my $stoffel = $self->{-char};
    
    if(defined($self->{'Fertigkeiten'})){
    	# ermittele hoechste
    	my $val = 0;
    	my $sef = $self->{'Fertigkeiten'};
    	for my $spruch_fert (@$sef){
    	    if($stoffel->{'Fertigkeit'}->{$spruch_fert} > $val){
    	    	$val = $stoffel->{'Fertigkeit'}->{$spruch_fert};
    	    	$self->{'Fertigkeit'} = $spruch_fert;
    	    }
    	}
    }
    
}

#
# Diese Funktion ermittelt die Mindestwuerfe...
#
# Eingabe: gesenkt um wieviel Punkte
#          MW-modifikationen
#
# Ausgabe: (als Hashreferenz)
#          'Grund':     Grundmindestwurf
#          'Ungesenkt': ungesenkter MW
#          'Gesenkt':   gesenkter MW
#
sub berechne{
    # standardparameter
    my $self = shift;
    my $zauberer = $self->{-char};
    my $gesenkt_um = shift;
    my $mw_mod = shift;
    my $dauer = shift;
    
    print "berechne(gesenkt_um: $gesenkt_um, mw_mod: $mw_mod)\n";
    
    my $mw = {};
    
    my $spr = $self->get_name();
    
    my $prozente = $zauberer->get_prozente($spr);
    print "Prozente von $spr: $prozente\n";
    
    $mw->{'Grund'} = $self->formel();
    
    $mw->{'Ungesenkt'} = POSIX::floor($mw->{'Grund'} * ($prozente/100) 
    	* ($self->dauer_prozente($dauer)/100) + 0.5 + $mw_mod);
    $mw->{'Gesenkt'} = $mw->{'Ungesenkt'} - $gesenkt_um;
    
    return $mw;
}

#####################################################################
#
# TODO_WEBAPP: Ab hier ist Tk-spezifischer Code eingemischt, der da nicht 
# TODO_WEBAPP: hingehört.
#
####################################################################

# TODO: das hier sollte in eine abgeleitete klasse oder in eine view-klasse
# in der dann auch $spruch_frame und $spruch_out_frame member-variablen sind

#
# Ermittle aus dem Index (undokumentiert in $browseentry->{'_BE_curIndex'})
# den Wert einer Variable, abhaengig von der Groessenordnung
#

sub get_wert{
    my $self = shift;
    my $var = shift; 
    
    my $ref = $self->{'Variable'}->{$var};
    my $groe = $ref->{'Groessenordnung'};
    my $stoffel = $self->{-char};
    
    my $index;
    if($self->{-mode} eq 'tk'){
    	# TODO: something better than this very dirty hack
    	$index = $ref->{'Wahl'}->{'_BE_curIndex'};
    }else{
    	#TODO: how to get index in web?
    }
    
    #  print "curIndex: $index Groessenordnung: $groe\n";
    my $MAX_RADIO = $self->{-conf}->{-MAX_RADIO};
    if($groe eq 'linear' || $groe eq 'quadratisch' || $groe eq 'kubisch'){
        	my $max = $ref->{'Obergrenze'};
    	return $index if (!defined($max) || $max > $MAX_RADIO);
    	return $ref->{'Wert'};
    }elsif($groe eq 'log2'){
    	return 2 ** $index;
    }elsif(ref($groe) eq 'ARRAY'){
    	# sortiertes enum
    	for my $w (0..scalar(@$groe)){
    	    if($ref->{'Wert'} eq $groe->[$w][0])
    	    {
    	    	return $groe->[$w][1];
    	    }
    	}
    }elsif(ref($groe) eq 'HASH'){
    	# unsortiertes enum
    	return $groe->{$ref->{'Wert'}};
    }
}

#
# Diese Funktion gibt im Tk-Modus ein BrowseEntry-Widget zurueck, dass auf
# der Eingabe-Seite angezeigt wird. Im Web-Modus gibt es ein <select>-Tag 
# mit den zugehörigen <option>s zurück als string.
#
# Parameter: TODO DOKU

sub get_input_var{
    my $self = shift;
    my $label = shift;
    my $listref = shift;
    my $stoffel = $self->{-char};
    my $spruch_frame = shift;
    
    my $back = '';
    if(!ref($self->{'Variable'}->{$label}->{'Groessenordnung'})){
    	# $wert wird in dem Text zum eval benoetigt!!
    	# Die Variable muss in jedem Spruch so heissen wie hier!
    	my $wert = $self->{'Variable'}->{$label}->{'Wert'};
    	my $text = eval($self->{'Variable'}->{$label}->{'Text'});
    	if($self->{-mode} eq 'tk'){
    	    
    	    
    	    $back =  $spruch_frame->BrowseEntry
    	    (-label => $label,
    	    	-variable => \$text,
    	    	-browsecmd => \&::aktualisieren
    	    	);
    	    $back->{'curIndex'} = $wert;
    	    $back->{'curIndex'}-- 
    	    if($self->{'Variable'}->{$label}->{'Groessenordnung'} 
    	    	eq 'log2');
    	    
    	}else{ # mode eq 'web'
    	    $back .= "<p>\n$label: <select name=\"$label\">\n";
    	    
    	}
    	
    }else{
    	if($self->{-mode} eq 'tk'){
    	    
    	    $back = $spruch_frame->BrowseEntry
    	    (-label => $label,
    	    	-variable => \$self->{'Variable'}->{$label}->{'Wert'},
    	    	-browsecmd => \&::aktualisieren
    	    	);
    	}else{ # mode eq 'web'
    	    $back .= "<p>\n$label: <select name=\"$label\">\n"; #oder ausserhalb des if?
    	}
    	
    }
    if($listref){
    	for my $entry (@$listref){
    	    if($self->{-mode} eq 'tk'){
    	    	$back->insert('end', $entry);
    	    }else{ # mode eq 'web'
    	    	$back .= "<option>$entry</option>\n";
    	    }
    	}
    }
    if($self->{-mode} eq 'tk'){
    	$back->Subwidget('entry')->bind('<Key-Return>',
    	    \&::aktualisieren);
    }else{ # mode eq 'web'
    	$back .= "</select>\n";
    }
    
    return $back;
}

#
# hier wird nur ein checkbutton zurueckgeliefert.
# params: - der text
#         - die variablenreferenz
#

sub get_input_flag{
    my $self = shift;
    my $text = shift;
    my $var_ref = shift;
    my $spruch_frame = shift;
    
    if($self->{-mode} eq 'tk'){
    	return $spruch_frame->Checkbutton
    	(-text => $text,
    	    -command => \&::aktualisieren,
    	    -variable => $var_ref,
    	    -onvalue => '1',
    	    -offvalue => '0');
    }else{
    	return "$text: <input type='checkbox' name='$text'>";
    }
}

#
# 
#
#

sub get_input_radio_web{
    my $self = shift;
    my $var = shift;
    my $ref = $self->{'Variable'}->{$var};
    my $groe = $ref->{'Groessenordnung'};
    my $stoffel = $self->{-char};
    
    # TODO: hier muss die logik aus get_input_radio() hin
    # nur mit strings statt widgets als resultat
    
    my $max;
    my $ret = '';
    if(!ref($groe)){
    	$max = $ref->{'Obergrenze'} ;
    	for my $wert (0..$max){
    	    $ret .= "$wert: <input type='radio' name='$var' value='$wert'>\n";
    	}
    }elsif(ref($groe) eq 'ARRAY'){
    	$max = scalar(@$groe);
    	for my $wert (0..$max-1){
    	    my $val = $groe->[$wert][1];
    	    my $txt = $groe->[$wert][0];
    	    $ret .= "$txt: <input type='radio' name='$var' value='$val'>\n";
    	}
    }elsif(ref($groe) eq 'HASH'){
    	for my $wert (keys(%$groe)){
    	    $ret .= "$wert: <input type='radio' name='$var' value='$wert'>\n";
    	}
    }
    return "<p>\n$ret";
}

#
#
#
#
sub get_input_radio{
    my $self = shift;
    my $var = shift;
    my $spruch_frame = shift;

    return $self->get_input_radio_web($var) if($self->{-mode} eq 'web');

    my $ref = $self->{'Variable'}->{$var};
    my $groe = $ref->{'Groessenordnung'};
    my $stoffel = $self->{-char};
    
    
    my $radio_frame = $spruch_frame->LabFrame
    (-label => $var,
    	-labelside => 'acrosstop');
    
    my $max;
    my $text;
    if (!ref($groe)){
    	$max = $ref->{'Obergrenze'} ;
    	for my $wert (0..$max){
    	    $radio_frame->Radiobutton
    	    (-variable => \$ref->{'Wert'},
    	    	-value => $wert,
    	    	-text => eval($ref->{'Text'}),
    	    	-command => \&::aktualisieren);
    	}
    }elsif(ref($groe) eq 'ARRAY'){
    	$max = scalar(@$groe);
    	for my $wert (0..$max-1){
    	    $radio_frame->Radiobutton
    	    (-variable => \$ref->{'Wert'},
    	    	-value => $groe->[$wert][0],
    	    	-text => $groe->[$wert][0],
    	    	-command => \&::aktualisieren);
    	}
    }elsif(ref($groe) eq 'HASH'){
    	for my $wert (keys(%$groe)){
    	    $radio_frame->Radiobutton
    	    (-variable => \$ref->{'Wert'},
    	    	-value => $wert,
    	    	-text => $wert,
    	    	-command => \&::aktualisieren);
    	}
    }
    
    my @c = $radio_frame->children;
    
    return $radio_frame;
}

# Das selbe fuer die Ausgabe-Seite
sub get_output_text{
    my $text = shift;
    my $spruch_out_frame = shift;
    
    return $spruch_out_frame->Label(-text => $text);
}

#
# Die allgemeine Pack-Routine, kann evntl. ueberladen werden
# wird nur für Tk gebraucht
sub pack{
    my $self = shift;
    
    die "Wrong mode $self->{-mode} != 'tk' in method Spruch::pack()" 
    	if $self->{-mode} ne 'tk';
    
    my $widget;
    my $arrayref = $self->get_spruchabhaengig();
    foreach $widget (@$arrayref){
    	# besser waere hier eine packung mit unterschiedlichen params
    	if($widget->class eq 'Radiobutton'){
	    $widget->pack(-side => 'left');
	}else{
	    $widget->pack(-anchor => 'e');
	}
    }
}

########################################################################
#
# TODO_WEBAPP: Ende Tk-spezifischer Code.
#
######################################################################


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
    
    return $self->{-conf}->{-UNENDLICH};
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
# 
#

sub get_name{
    my $self = shift;
    return $self->{'Name'};
    # TODO: hier muss noch der Spezialisierungsfall hin...
    
}

#
# Hier wird die MW-Formel zusammengesetzt aus den einzelnen 
# Variablenabhaengigen Termen
#

sub formel{
    my $self = shift;
    
    my $back = $self->{'BasisMW'};
    for my $var (keys(%{$self->{'Variable'}})){
    	my $go = $self->groessenordnung($var);
    	$back += $self->{'Variable'}->{$var}->{'Faktor'} * $go;
    }
    
    # print "Formel liefert: $back\n";
    
    return $back;
}

# wendet die uebergebene Groessenordnung auf die uebergebene variable an
sub groessenordnung{
    my $self = shift;
    my $var = shift;
    my $groe = $self->{'Variable'}->{$var}->{'Groessenordnung'};
    my $wert = $self->get_wert($var);
    
    
    my $test;
    if($self->{-mode} eq 'tk'){
    	$test = $self->{'Variable'}->{$var}->{'Wahl'}->{'curIndex'};
    }else{
    	#TODO webapp
    }
    
    if($groe eq 'quadratisch'){
    	return $wert ** 2;
    }elsif($groe eq 'linear'){
    	return $wert;
    }elsif($groe eq 'log2'){
    	return log($wert)/log(2);
    }elsif($groe eq 'kubisch'){
    }elsif(ref($groe) eq 'ARRAY'){
    	# Arrays sind immer sortierte enums!
    	return $wert;
    }elsif(ref($groe) eq 'HASH'){ 
    	# dann ists ein unsortierter enum (hashreferenz)
    	return $wert;
    }else{
    	if(ref($groe)){
    	    my $r = ref($groe);
    	    die "Falsche Groessenordnung(Referenz): $r\n";
    	}else{
    	    die "Falsche Groessenordnung: $groe\n";
    	}
    }
}

# erwartet einen zauberer vom Typ Charakter und liefert die Prozente
# unter Beachtung von Oberspruechen
# TODO?: wieso ist $self nicht der zauberer?
sub get_prozente{
    my $self = shift;
    my $zauberer = shift;
    
    my $proz = $zauberer->get_prozente($self->{'Name'}); 
    for my $ober (@$self->{'Obersprueche'}){
    	my $neuproz = $zauberer->get_prozente($ober);
    	$proz = $neuproz if ($neuproz < $proz);
    };
    return $proz;
}

#
# Liefert die Spruchabhaengigen Widgets zurueck.
# Wird zum packen und kaputtmachen, etc... benoetigt
# nur für Tk gebraucht

sub get_spruchabhaengig{
    my $self = shift;
    my $list;# = [];
    
    die "Wrong mode $self->{-mode} != 'tk' in method Spruch::get_spruchabhaengig"
    if $self->{-mode} ne 'tk';
    
    for my $var (keys(%{$self->{'Variable'}})){
    	push (@$list, $self->{'Variable'}->{$var}->{'Wahl'});
    	my @children = $self->{'Variable'}->{$var}->{'Wahl'}->children;
    	suche_radio($self->{'Variable'}->{$var}->{'Wahl'},$list);
    }
    
    return $list;
}

# gibt das HTML zurück für den spruchabhängigen Teil des Formulars
sub get_form{
    my $self = shift;
    my $html = '';
    
    die "Wrong mode $self->{-mode} != 'web' in method Spruch::get_spruchabhaengig"
    if $self->{-mode} ne 'web';
    
    for my $var (keys(%{$self->{'Variable'}})){
    	$html .=  $self->{'Variable'}->{$var}->{'Wahl'};
    }
    
    return $html;
}

sub suche_radio{
    my $w = shift;
    my $list = shift;
    
    for my $ki ($w->children){
    	if($ki->class eq 'Radiobutton'){
    	    push(@$list,$ki);
    	}else{
    	    suche_radio($ki,$list);
    	}
    }
}

#
# Hier wird die gesamte Spruchabhaengige Oberflaeche generiert
#
# TODO_WEBAPP: eine ähnliche Funktion braucht es auch für eine Webapp,
# TODO_WEBAPP: die dann HTML-Formulare auswirft
#

sub create_oberflaeche{
    my $self = shift;
    my $stoffel = $self->{-char};
    my $spruch_frame = shift;
    
    die "wir brauchen einen \$spruch_frame im Tk-Modus!" 
    	if ($self->{-mode} eq 'tk' && !defined $spruch_frame);
    
    print "create_oberflaeche($spruch_frame);\n";
     
    my $conf = $self->{-config};
   
    for my $var (keys(%{$self->{'Variable'}})){
    	my $vars = $self->{'Variable'};
    	my $groe = $vars->{$var}->{'Groessenordnung'};
    	#	  print "create_oberflaeche: vars: $vars, groe: $groe, self: $self, var: $var, name: $self->{'Name'}\n";
    	if($groe eq 'linear' || 
    	    $groe eq 'quadratisch' || 
    	    $groe eq 'kubisch'){
    	my @auswahl;
    	my $max;
    	if(!defined($vars->{$var}->{'Obergrenze'})){
    	    $max = 30;
    	}else{
    	    $max = $vars->{$var}->{'Obergrenze'};
    	}
    	if($max == 1){
    	    # checkbutton
    	    $vars->{$var}->{'Wahl'} = $self->get_input_flag
    	    ($var,\$vars->{$var}->{'Wert'},$spruch_frame);
   
	       }elsif($max <= $conf->{-MAX_RADIO}){
	       	   #radiobutton
	       	   $vars->{$var}->{'Wahl'} = 
		   $self->get_input_radio($var,$spruch_frame);
	       }else{
	       	   for my $wert (0..$max){
	       	       push(@auswahl,eval($vars->{$var}->{'Text'}));
	       	   }
	       	   # my $wert = $vars->{$var}->{'Wert'};
	       	   $vars->{$var}->{'Wahl'} = $self->get_input_var
		   ($var,\@auswahl,$spruch_frame);
	       }
	    }elsif($groe eq 'log2'){
	    	my @auswahl;
	    	my $max;
	    	if(!defined($vars->{$var}->{'Obergrenze'})){
	    	    $max = 20;
	    	}else{
	    	    $max = $vars->{$var}->{'Obergrenze'};
	    	}
	    	for my $c (0..$max){
	    	    my $wert = 2**$c;
		    push(@auswahl,eval($vars->{$var}->{'Text'}));
		}
		$vars->{$var}->{'Wahl'} = $self->get_input_var
		($var,\@auswahl,$spruch_frame);
	    }elsif(ref($groe) eq 'ARRAY'){
	    	# sortiertes enum
	    	my $anzahl = scalar(@$groe);
	    	if($anzahl == 2){
	    	    $vars->{$var}->{'Wahl'} = $self->get_input_flag
	    	    ($var,\$var->{'Wert'},$spruch_frame);
	    }elsif($anzahl <= $conf->{-MAX_RADIO}){
	    	# Radiobuttons hin
	    	$vars->{$var}->{'Wahl'} = 
		$self->get_input_radio($var,$spruch_frame);
	    }else{
	    	my @auswahl = ();
	    	for my $wert (@$groe){
	    	    push(@auswahl,$wert->[0]);
	    	}
	    	$vars->{$var}->{'Wahl'} = $self->get_input_var
	    	($var,\@auswahl,$spruch_frame);
	    }
	    }elsif(ref($groe) eq 'HASH'){  
	    	# unsortiertes enum
	    	my $anzahl = scalar(keys(%$groe));
	    	if($anzahl == 2){
	    	    $vars->{$var}->{'Wahl'} = $self->get_input_flag
	    	    ($var,\$var->{'Wert'},$spruch_frame);
	       }elsif($anzahl <= $conf->{-MAX_RADIO}){
	       	   # Radiobuttons hin
	       	   $vars->{$var}->{'Wahl'} = 
		   $self->get_input_radio($var,$spruch_frame);
	       }else{
	       	   my @auswahl = ();
	       	   for my $wert (keys(%$groe)){
	       	       push(@auswahl,$wert);
	       	   }
	       	   $vars->{$var}->{'Wahl'} = $self->get_input_var
	       	   ($var,\@auswahl,$spruch_frame);
	       }
	    }else{
	    	die "Falsche Groessenordnung: $groe\n";		    
	    }
    }
}


# TODO: überflüssiger wrapper, weg damit
sub aktualisieren{
    my $self = shift;
    my $stoffel = $self->{-char};
    my $gesenkt_um = shift;
    my $mw_mod = shift;
    my $dauer = shift;
    
    my $mws = $self->berechne($gesenkt_um,$mw_mod,$dauer);
    
    return $mws;
};

sub spezialisierung_passt{
    my $self = shift;
    my $c_spez = shift;

    my $stoffel = $self->{-char};
    
    my $spruch_muss = $self->{'Spezialisierung'}->{'muss'};
    my $spruch_kann = $self->{'Spezialisierung'}->{'kann'};
    
    if(defined($spruch_muss)){
    	for my $var (@$spruch_muss){
    	    my $groe = $self->{'Variable'}->{$var}->{'Groessenordnung'};
    	    return 0 if (!defined($c_spez->{$var}));
    	    if(!ref($groe)){
    	    	my $gwv = $self->get_wert($var);
    	    	return 0 if( $gwv > $c_spez->{$var});
    	    }elsif(ref($groe) eq 'ARRAY'){
    	    	# sortierter enum
    	    	my $gwv = $self->get_wert($var);
    	    	my $soll;
    	    	for my $i (@$groe){
    	    	    if($i->[0] eq $c_spez->{$var}){
    	    	    	$soll = $i->[1];
    	    	    	last;
    	    	    }
    	    	}      
    	    	return 0 if( $gwv > $soll);
    	    }elsif(ref($groe) eq 'HASH'){
    	    	# unsortierter enum
    	    	my $gwv = $self->{'Variable'}->{$var}->{'Wert'};
    	    	return 0 if( $gwv ne $c_spez->{$var});
    	    }
    	}
    }else{
    	return 0 if(!defined($spruch_kann));
    }
    return 1 if(!defined($spruch_kann));
    # kann fehlt noch
    for my $var (@$spruch_kann){
    	my $groe = $self->{'Variable'}->{$var}->{'Groessenordnung'};
    	next if (!defined($c_spez->{$var}));
    	if(!ref($groe)){
    	    my $gwv = $self->get_wert($var);
    	    return 1 if( $gwv <= $c_spez->{$var});
    	}elsif(ref($groe) eq 'ARRAY'){
    	    # sortierter enum
    	    my $gwv = $self->get_wert($var);
    	    my $soll;
    	    for my $i (@$groe){
    	    	if($i->[0] eq $c_spez->{$var}){
    	    	    $soll = $i->[1];
    	    	    last;
    	    	}
    	    }      
    	    return 1 if( $gwv <= $soll);
    	}elsif(ref($groe) eq 'HASH'){
    	    # unsortierter enum
    	    my $gwv = $self->{'Variable'}->{$var}->{'Wert'};
    	    return 1 if( $gwv eq $c_spez->{$var});
    	}
    	
    }
    #  print "return 1\n";
    return 0;
}

#
# Das sind vorgefertigte "Spruchbausteine". Damit kann man einige 
# Standardsprueche deutlich einfacher formulieren.
#

$Spruch::RW_quadratisch = 
{
    'Wert' => 1,
    'Faktor' => 1,
    'Groessenordnung' => 'quadratisch',
    'Text' => '$wert * $stoffel->{"Basisattribut"}->{"PSI"} . " meter"',
    'Beschreibung' => 'RW in PSI-Metern'
};

$Spruch::RW_log2 = 
{
    'Wert' => 1,
    'Faktor' => 1,
    'Groessenordnung' => 'log2',
    'Text' => 'my $ref = sub{
    my $psi = $wert*$stoffel->{"Basisattribut"}->{"PSI"};
    ($psi<1000)?($psi . " meter"):
    (sprintf("%." . $conf->{-KOMMA} . "f kilometer",$psi/1000))};
    &$ref',
    # [x] Du willst diese Zeilen nicht verstehen.
    'Beschreibung' => 'logarithmische RW in PSI-Metern'
};

$Spruch::Schaden_quadratisch = 
{
    'Wert' => 1,
    'Faktor' => 1,
    'Groessenordnung' => 'quadratisch',
    'Text' => '"$wert w"',
    'Beschreibung' => 'Schaden in w10'
};

# Alle Sprüche laden, wenn nicht schon geschehen
# alle Module im Verzeichnis $spruchdir sind verfuegbar...
# und werden in eine liste  eingetragen
sub init_sprueche{
    my $class = shift; # wird nicht benutzt
    my $hash = shift;
    my $list = shift;
    my $stoffel = shift;
    my $mode = shift;
    
    my $conf = Eomconfig->new();
    
    opendir(SPRUECHE,$conf->{-SPRUCHDIR}) || 
    die "Kann Verzeichnis $conf->{-SPRUCHDIR} nicht oeffnen\n";
    while($_ = readdir(SPRUECHE)){
    	next if( ! (/^.*\.sp$/)); # nur *.sp-files
    	s/^(.*)\.sp$/$1/;
    	my $spruchname = $_;
    	my $spruch = Spruch->new($spruchname,$stoffel,$mode);
    	$hash->{$spruchname} = $spruch;
    	push(@$list,$spruchname);
    }
    closedir SPRUECHE;
}

1;

