#
# Hier werden einige Config-Parameter angegeben.
# Please Edit!
#

#
# Welche Version der ERPS-Regeln soll verwendet werden?
# Mögliche Werte: 1,2

$::RULE_VERSION = 2;

#
# Farb-Spezifikationen, werden zur Zeit nicht wirklich benutzt...
#
$main::BGCOLOR = 'gray85';

#
# Dieser Parameter gibt an, wieviele Zeilen die Wuerfeltabelle hat
#
$main::MAX_TABLE = 10;

#
# Dieser Parameter gibt an, was das maximal zu berechnende 
# Wuerfelergebnis fuer die Wuerfeltabelle ist.
#
$main::MAXWURF = 100;

#
# Aus diesem Verzeichnis werden alle *.pm-Dateien als Spruchklassen
# geladen. Pfad relativ zum aktuellen Verzeichnis.
#
$main::SPRUCHDIR = 'Sprueche';

#
# Aus diesem Verzeichnis werden alle *.ch-Dateien als Charakterdaten
# geladen. Pfad relativ zum aktuellen Verzeichnis.
#
$main::CHARDIR = 'Charaktere';

#
# wird an einigen stellen als "sehr grosser wert" verwendet
#

$main::UNENDLICH = 10000;

#
# Dieser Wert gibt die Genauigkeit der
# Wahrscheinlichkeits-Berechnungen an (Anzahl der Summenterme, die
# beruecksichtigt werden). Je hoeher, umso genauer, aber auch umso
# mehr Rechenzeit 

# wird nicht mehr benutzt
# $main::GENAUIGKEIT = 4;

# Dieser Wert gibt die Anzahl der Stellen hinter dem Komma an, die bei
# den Wahrscheinlichkeitswerten verwendet werden sollen

$main::KOMMA = 1;

#
# Die maximal betrachtete Wundgroesse
# (wird zur Zeit nur bei der Spezialisierungssuche verwendet)

$main::MAX_WUND = 50;

#
# Die maximale Anzahl an Werten, die noch durch Radiobuttons
# dargestellt werden
#

$main::MAX_RADIO = 4;

# Dieser Spruch wird am Anfang eingelesen
$main::DEFAULT_SPRUCH = 'Elementstrahl';

# Dieser Charakter wird am Anfang eingelesen
$main::DEFAULT_CHARAKTER = 'Stoffel';

