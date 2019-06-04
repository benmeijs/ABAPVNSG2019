*&--------------------------------------------------------------------------------
*& VNSG 2019 - Dag voor ontwikkelaars
*& Ben Meijs Ctac NL - 04-04-2019
*&-------------------------------
*& Get the most out of ABAP on S4HANA
*& - Constructor Expressions 2 - COND en SWITCH
*& - WAS740 vv
*&------------------------------------
REPORT zvnsg2019_02_constr_expr_02.
PARAMETERS: pa_refdt TYPE d.


"Without COND option

IF pa_refdt IS INITIAL.
  DATA(reference_date) = CONV d( '99991231' ).
ELSE.
  reference_date = pa_refdt.
ENDIF.

NEW zcl_vnsg_2019_demo( )->optional_processing(
                               i_reference_date = reference_date ).


"With COND option

NEW zcl_vnsg_2019_demo( )->optional_processing(
                               i_reference_date = COND #( WHEN pa_refdt IS INITIAL THEN '99991231' ELSE pa_refdt ) ).
