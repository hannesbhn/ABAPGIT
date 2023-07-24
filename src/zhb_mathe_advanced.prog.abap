*&---------------------------------------------------------------------*
*& Report  ZHB_MATHE_ADVANCED
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT ZHB_MATHE_ADVANCED.


DATA: gv_string TYPE string VALUE 'Hallo',
      gv_zahl TYPE i VALUE 5,
      gv_erg TYPE p DECIMALS 2.

write gv_string.

gv_string = gv_zahl.    "Funktioniert!

WRITE gv_string.

gv_string = '5'.


gv_erg = gv_zahl * gv_string.

Write / gv_erg.

DATA gv_zahl1 TYPE p DECIMALS 2 VALUE 2.
DATA gv_zahl2 TYPE p DECIMALS 2 VALUE 6.
DATA gv_zahl3 TYPE p DECIMALS 2.

gv_erg = gv_zahl1 / gv_zahl2.
WRITE / gv_erg.


gv_erg = gv_zahl1 div gv_zahl2.   "ganzzahlige Division
WRITE gv_erg.

gv_erg = gv_zahl1 MOD gv_zahl2.
write gv_erg.

gv_erg = gv_zahl1 ** gv_zahl2.    "potenzieren zahl2 hoch zahl1
WRITE gv_erg.
