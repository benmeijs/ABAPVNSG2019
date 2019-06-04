*&--------------------------------------------------------------------------------
*& VNSG 2019 - Dag voor ontwikkelaars
*& Ben Meijs Ctac NL - 04-04-2019
*&-------------------------------
*& Get the most out of ABAP on S4HANA
*& - SQL expressions
*& - WAS740 vv
*&------------------------------------
REPORT zvnsg2019_04_sql_expr_01.
DATA: wa_vbap TYPE vbap.
PARAMETERS: factor TYPE i DEFAULT 10 OBLIGATORY.
SELECT-OPTIONS: so_matnr FOR wa_vbap-matnr.


SELECT
  vbap~vbeln,
  vbap~posnr,
  vbap~matnr,
  vbap~aedat,
  vbap~erdat,

  CASE WHEN vbap~aedat > vbap~erdat
    THEN vbap~aedat
    ELSE vbap~erdat
  END AS last_change_date,

  vbap~netwr,
  vbap~kwmeng,
  vbap~vrkme,
  @factor AS factor,
  CAST( division( vbap~netwr, @factor, 5 ) AS DEC( 15,5 ) )  AS value_divided_by_factor,

  coalesce( mara~bismt, '---' ) AS previous_material_number

  FROM vbap LEFT OUTER JOIN mara ON mara~bismt = vbap~matnr
  WHERE vbap~matnr IN @so_matnr
  INTO TABLE @DATA(orderitems).

zcl_vnsg_2019_alv_output=>show( CHANGING itab = orderitems ).
