*&--------------------------------------------------------------------------------
*& VNSG 2019 - Dag voor ontwikkelaars
*& Ben Meijs Ctac NL - 04-04-2019
*&-------------------------------
*& Get the most out of ABAP on S4HANA
*& - Inline Declarations
*& - WAS740 vv
*&------------------------------------
REPORT zvnsg2019_01_inline_decl_01a.

SELECT vbeln, posnr, matnr
  FROM vbap
  INTO TABLE @DATA(ta_result)
  UP TO 10 ROWS.

zcl_vnsg_2019_alv_output=>show( CHANGING  itab = ta_result ).
