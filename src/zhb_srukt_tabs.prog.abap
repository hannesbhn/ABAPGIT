*&---------------------------------------------------------------------*
*& Report  ZHB_SRUKT_TABS
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zhb_srukt_tabs.

TYPES: BEGIN OF lty_s_student,
         name       TYPE string,
         vorname    TYPE string,
         matrikelnr TYPE i,
         abschluss  TYPE string,
       END OF lty_s_student,
       lty_t_studenten TYPE TABLE OF lty_s_student WITH KEY matrikelnr.



DATA: gs_student TYPE lty_s_student,
      gt_studenten TYPE lty_t_studenten.

gs_student-name = 'Mueller'.
gs_student-vorname = 'Alex'.
gs_student-matrikelnr = 1.
gs_student-abschluss = 'M.Sc.'.
INSERT gs_student INTO TABLE gt_studenten.
CLEAR gs_student.

gs_student-name = 'Meyer'.
gs_student-vorname = 'Manni'.
gs_student-matrikelnr = 2.
gs_student-abschluss = 'B.Sc.'.
INSERT gs_student INTO TABLE gt_studenten.
CLEAR gs_student.

gs_student-name = 'Pfaff'.
gs_student-vorname = 'Tom'.
gs_student-matrikelnr = 3.
gs_student-abschluss = 'M.Arts.'.
INSERT gs_student INTO TABLE gt_studenten.
CLEAR gs_student.


DELETE gt_studenten WHERE matrikelnr = 2.

LOOP AT gt_studenten INTO gs_student.
WRITE: 'Name: ', gs_student-name, /,
       'Vorname: ', gs_student-vorname, /,
       'Matrikelnr: ', gs_student-matrikelnr, /,
       'Abschluss: ', gs_student-abschluss, /.
ENDLOOP.
