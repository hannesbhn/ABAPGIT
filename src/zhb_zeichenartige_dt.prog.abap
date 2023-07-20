*&---------------------------------------------------------------------*
*& Report  ZHB_ZEICHENARTIGE_DT
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zhb_zeichenartige_dt.


**********************************************************************
* Datendeklaration
**********************************************************************

DATA: gv_char(10) TYPE c,
      gv_numc(10) TYPE n,
      gv_string   TYPE string.

**********************************************************************
* Variablenbelegung
**********************************************************************
gv_numc = 1234.
gv_char = 0123456789.

**********************************************************************
* Ausgabe der Variablen
**********************************************************************

WRITE: gv_char, gv_numc.

**********************************************************************
* Zusammenfügung von Zeichenketten
**********************************************************************
CONCATENATE gv_char gv_numc INTO gv_string SEPARATED BY ' x '.

WRITE gv_string.

**********************************************************************
* Suchen in Zeichenketten
**********************************************************************

FIND '123' IN gv_string.

IF sy-subrc = 0.

  WRITE 'found'.

ENDIF.

**********************************************************************
* Ersetzen von Zeichen in Zeichenketten
**********************************************************************
REPLACE ALL OCCURRENCES OF '123' in gv_string with 'hallo'.

IF  sy-subrc = 0.

  WRITE / gv_string.

ENDIF.

**********************************************************************
* Zerlegen von Zeichenketten
**********************************************************************
DATA: gv_ganzer_name TYPE string VALUE 'Hannes Baehn',
      gv_vorname TYPE string,
      gv_nachname TYPE string.

SPLIT gv_ganzer_name AT ' ' INTO gv_vorname gv_nachname.

IF  sy-subrc = 0.

  ULINE.
  WRITE: 'Vorname: ', gv_vorname, /, 'Nachname: ', gv_nachname.


ENDIF.

**********************************************************************
* Verdichten von Zeichenketten
**********************************************************************
DATA: gv_verdichtung TYPE string VALUE 'das    ist ein  Verdichtungstest!  '.

ULINE.
WRITE gv_verdichtung.


CONDENSE gv_verdichtung.  "NO-GAPS = entfernt alle Leerzeichen.
WRITE / gv_verdichtung.


**********************************************************************
* Umwandeln von Zeichenketten
**********************************************************************
TRANSLATE gv_verdichtung TO UPPER CASE.   "oder TO LOWER CASE.

ULINE.
WRITE / gv_verdichtung.


**********************************************************************
* Verwendung von Textsymbolen
**********************************************************************
ULINE.
WRITE: / text-001.
