#
# Hier werden einige Config-Parameter angegeben.
# Please Edit!
#

#
# Welche Version der ERPS-Regeln soll verwendet werden?
# Mögliche Werte: 1,2

$::RULE_VERSION = 2;

#
# PSI-Kosten für Krits abrunden oder aufrunden? (ultraneue Regel)
# Mögliche Werte 0,1

$::PSIKOSTEN_ABRUNDEN = 1;

#
# Farb-Spezifikationen, werden zur Zeit nicht wirklich benutzt...
#
$::BGCOLOR = 'gray85';

#
# Dieser Parameter gibt an, wieviele Zeilen die Wuerfeltabelle hat
#
$::MAX_TABLE = 10;

#
# Dieser Parameter gibt an, was das maximal zu berechnende 
# Wuerfelergebnis fuer die Wuerfeltabelle ist.
#
$::MAXWURF = 100;

#
# Aus diesem Verzeichnis werden alle *.pm-Dateien als Spruchklassen
# geladen. Pfad relativ zum aktuellen Verzeichnis.
#
$::SPRUCHDIR = 'Sprueche';

#
# Aus diesem Verzeichnis werden alle *.ch-Dateien als Charakterdaten
# geladen. Pfad relativ zum aktuellen Verzeichnis.
#
$::CHARDIR = 'Charaktere';

#
# wird an einigen stellen als "sehr grosser wert" verwendet
#

$::UNENDLICH = 10000;

#
# Dieser Wert gibt die Genauigkeit der
# Wahrscheinlichkeits-Berechnungen an (Anzahl der Summenterme, die
# beruecksichtigt werden). Je hoeher, umso genauer, aber auch umso
# mehr Rechenzeit 

# wird nicht mehr benutzt
# $::GENAUIGKEIT = 4;

# Dieser Wert gibt die Anzahl der Stellen hinter dem Komma an, die bei
# den Wahrscheinlichkeitswerten verwendet werden sollen

$::KOMMA = 1;

#
# Die maximal betrachtete Wundgroesse
# (wird zur Zeit nur bei der Spezialisierungssuche verwendet)

$::MAX_WUND = 50;

#
# Die maximale Anzahl an Werten, die noch durch Radiobuttons
# dargestellt werden
#

$::MAX_RADIO = 4;

# Dieser Spruch wird am Anfang eingelesen
$::DEFAULT_SPRUCH = 'Elementstrahl';

# Dieser Charakter wird am Anfang eingelesen
$::DEFAULT_CHARAKTER = 'Stoffel';

