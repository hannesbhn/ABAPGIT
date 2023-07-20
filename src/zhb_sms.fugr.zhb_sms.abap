FUNCTION ZHB_SMS.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(I_STR_HEADER) LIKE  /COCKPIT/THDR
*"  STRUCTURE  /COCKPIT/THDR
*"     REFERENCE(I_STR_CHECK) LIKE  /COCKPIT/SCHECKDATA
*"  STRUCTURE  /COCKPIT/SCHECKDATA
*"     REFERENCE(I_CHECK_WHERE) LIKE  /COCKPIT/SDUMMY-CHKWO OPTIONAL
*"     REFERENCE(IC_PROCESS) LIKE  /COCKPIT/SIF-PROCESS OPTIONAL
*"  TABLES
*"      C_TAB_ITEM STRUCTURE  /COCKPIT/TITEM
*"      C_TAB_ACCOUNT STRUCTURE  /COCKPIT/TACCT
*"      C_TAB_TAX STRUCTURE  /COCKPIT/TTAX
*"      IT_ACCT_ASSIGN STRUCTURE  /COCKPIT/TACCAS OPTIONAL
*"      E_TAB_MESSAGES STRUCTURE  BAPIRET2
*"  EXCEPTIONS
*"      ERROR_OCCURED
*"--------------------------------------------------------------------
*@US@aa         => Signiture of Creator, e.g. HH for Harry Hirsch
*@CU@aaa...     => Customer Name
*@K1@ ... *@K9@ => Keywords for Implemented Functionality

* Dummy entry for user exit cross reference check
  IF con_exit_addcheck IS INITIAL. ENDIF.

*>>> START OF IMPLEMENTATION >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*

*<<< END OF IMPLEMENTATION <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*

ENDFUNCTION.
