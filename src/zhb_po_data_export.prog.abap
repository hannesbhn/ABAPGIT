*&---------------------------------------------------------------------*
*& Report  ZHB_PO_DATA_EXPORT
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zhb_po_data_export.



TYPES: BEGIN OF lst_invoices,

         invoice_guid TYPE c,
         po_number    TYPE c,
         po_item      TYPE n,
         net_amount   TYPE CURR,
         quantity     TYPE f,


       END OF lst_invoices.



TYPES: BEGIN OF lst_purchase_order,

         po_number TYPE c,
         po_item   TYPE n,
         net_value TYPE c,
         quantity  TYPE f,


       END OF lst_purchase_order.


DATA: it_invoices       TYPE TABLE OF lst_invoices,
      it_purchase_order TYPE TABLE OF lst_purchase_order.




*TYPES: BEGIN OF zhb_test,
*         doc_date TYPE dats,
*
*       END OF zhb_test.



DATA:
      itab TYPE TABLE OF /cockpit/thdr.
*      itab_thdr TYPE /cockpit/thdr.

DATA:
      lv_test TYPE f VALUE 1.

*
*SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
*
*PARAMETERS : date TYPE DATS.
*
*
*SELECTION-SCREEN END OF BLOCK b1.




TABLES: /cockpit/thdr,
        ekko,
        ekpo,
        /cockpit/titem.





SELECT DISTINCT /cockpit/thdr~invoice_guid, /cockpit/thdr~po_number FROM /cockpit/thdr
  INNER JOIN /cockpit/titem ON /cockpit/titem~invoice_guid = /cockpit/thdr~invoice_guid
    APPENDING CORRESPONDING FIELDS OF TABLE @it_invoices

    WHERE quantity = @lv_test.






CALL FUNCTION 'GUI_DOWNLOAD'
  EXPORTING
    filename = 'C:\Users\HannesBaehn\Desktop\output.csv'
  TABLES
    data_tab = it_invoices.
