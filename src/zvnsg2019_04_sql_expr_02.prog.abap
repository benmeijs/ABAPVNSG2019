*&--------------------------------------------------------------------------------
*& VNSG 2019 - Dag voor ontwikkelaars
*& Ben Meijs Ctac NL - 04-04-2019
*&-------------------------------
*& Get the most out of ABAP on S4HANA
*& - SQL expressions
*& - WAS740 vv
*&------------------------------------
REPORT zvnsg2019_04_sql_expr_02.

PARAMETERS: pa_datto TYPE a004-datbi .

"SQL Expression - Oude Code

IF pa_datto IS INITIAL.
  DATA(date_until) =  CONV d( '99991231' ).
ELSE.
  date_until = pa_datto.
ENDIF.

SELECT * FROM a002  WHERE datbi <= @date_until INTO TABLE @DATA(ta_result_o).

zcl_vnsg_2019_alv_output=>show( CHANGING itab = ta_result_o ).

"SQL expression - nieuwe code

SELECT * FROM a002
  WHERE datbi <= @( COND #( WHEN pa_datto IS INITIAL THEN '99991231' ELSE pa_datto ) )
  INTO TABLE @DATA(ta_result_n).

zcl_vnsg_2019_alv_output=>show( CHANGING itab = ta_result_n ).
