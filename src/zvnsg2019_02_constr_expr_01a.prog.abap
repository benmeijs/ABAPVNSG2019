*&--------------------------------------------------------------------------------
*& VNSG 2019 - Dag voor ontwikkelaars
*& Ben Meijs Ctac NL - 04-04-2019
*&-------------------------------
*& Get the most out of ABAP on S4HANA
*& - Constructor Expressions 1 - CONV, NEW, CAST
*& - WAS740 vv
*&------------------------------------
REPORT zvnsg2019_02_constr_expr_01a.

DO 100 TIMES.
  IF NEW zcl_vnsg_2019_demo( )->is_random_new_date_valid( CONV d( sy-datum + CAST if_random_number( NEW cl_random_number( ) )->get_random_int( 100 ) )  ).
    WRITE: / 'TRUE'.
  ELSE.
    WRITE: / 'FALSE'.
  ENDIF.
ENDDO.
