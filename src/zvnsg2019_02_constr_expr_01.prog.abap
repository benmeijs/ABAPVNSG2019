*&--------------------------------------------------------------------------------
*& VNSG 2019 - Dag voor ontwikkelaars
*& Ben Meijs Ctac NL - 04-04-2019
*&-------------------------------
*& Get the most out of ABAP on S4HANA
*& - Constructor Expressions 1 - CONV, NEW, CAST
*& - WAS740 vv
*&------------------------------------
REPORT zvnsg2019_02_constr_expr_01.


"CONV : mappen naar ander data type

DATA(my_daynumber_inline) = CONV d( sy-datum + 5 ).

WRITE: / my_daynumber_inline.

"Constructor Expression: zonder casting

DATA(randomizer2)   = NEW cl_random_number( ).
DATA(random_number) = randomizer2->if_random_number~get_random_int( 100 ).

"Constructor Expression :  met CASTING

DATA(random_number_inline) = CAST if_random_number( NEW cl_random_number( ) )->get_random_int( 100 ).

"Constructor Expression : nu tellen we een random nummer bij de systeemdatum om nieuwe datum te maken

DATA(a_new_date) = CONV d( sy-datum + CAST if_random_number( NEW cl_random_number( ) )->get_random_int( 100 ) ).


WRITE: / random_number,
       / random_number_inline.

WRITE: / a_new_date .

"Constructor Expression bij methode aanroep.
DO 100 TIMES.
  IF NEW zcl_vnsg_2019_demo( )->is_random_new_date_valid( CONV d( sy-datum + CAST if_random_number( NEW cl_random_number( ) )->get_random_int( 100 ) )  ).
    WRITE: / 'TRUE'.
  ELSE.
    WRITE: / 'FALSE'.
  ENDIF.
ENDDO.
