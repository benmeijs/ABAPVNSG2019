*&--------------------------------------------------------------------------------
*& VNSG 2019 - Dag voor ontwikkelaars
*& Ben Meijs Ctac NL - 04-04-2019
*&-------------------------------
*& Get the most out of ABAP on S4HANA
*& - SQL expressions
*& - WAS750 vv
*&------------------------------------
REPORT zvnsg2019_04_sql_expr_02a.

PARAMETERS: pa_datto TYPE a004-datbi .
break-point.
SELECT * FROM a002
  WHERE datbi <= @( COND #( WHEN pa_datto IS INITIAL THEN '99991231' ELSE pa_datto )  )
  INTO TABLE @DATA(ta_result_n).

zcl_vnsg_2019_alv_output=>show( CHANGING itab = ta_result_n ).
