*&---------------------------------------------------------------------*
*& Report  ZHB_EXCEL_UPLOAD
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT ZHB_EXCEL_UPLOAD.


* Deklarationen
DATA: it_excel_data TYPE STANDARD TABLE OF ,
      wa_excel_data TYPE zexcel_data,
      it_fieldcat TYPE lvc_t_fcat.

PARAMETERS: p_file TYPE rlgrap-filename.

* Definition der Struktur der Tabelle
TYPES: BEGIN OF zexcel_data,
         field1 TYPE string,
         field2 TYPE string,
         field3 TYPE string,
         field4 TYPE string,
       END OF zexcel_data.

* Definition der ALV-Tabelle
DATA: go_alv TYPE REF TO cl_gui_alv_grid.

* Definition des Dateinamens
DATA: lv_filename TYPE string.

* Initialisierung der GUI
CALL FUNCTION 'GUI_INIT'.

* Anzeigen des Dialogfensters zum Auswählen der Datei
CALL METHOD cl_gui_frontend_services=>file_open_dialog
  EXPORTING
    default_extension = 'XLSX'
  CHANGING
    file_table       = it_excel_data
    rc               = lv_filename.

* Lesen der Excel-Datei
IF sy-subrc = 0.
  CALL FUNCTION 'TEXT_CONVERT_XLS_TO_SAP'
    EXPORTING
      i_tab_raw_data         = it_excel_data
    TABLES
      i_tab_converted_data   = it_excel_data.
ENDIF.

* Speichern der Daten in der SAP-Tabelle
IF it_excel_data IS NOT INITIAL.
  LOOP AT it_excel_data INTO wa_excel_data.
    INSERT INTO ztable
      VALUES wa_excel_data.
  ENDLOOP.
ENDIF.

* Anzeigen der ALV-Tabelle
SELECT * FROM ztable INTO TABLE it_excel_data.

CALL METHOD cl_gui_alv_grid=>mc_fm_name
  EXPORTING
    i_structure_name = 'ZEXCEL_DATA'
  CHANGING
    ct_outtab        = it_excel_data
  TABLES
    t_fieldcat       = it_fieldcat.

go_alv = NEW cl_gui_alv_grid( i_parent = cl_gui_container=>screen0 ).
go_alv->set_table_for_first_display(
  EXPORTING
    is_layout       = VALUE #( width = 1200 height = 800 )
  CHANGING
    it_outtab       = it_excel_data
  TABLES
    t_fieldcat      = it_fieldcat ).
