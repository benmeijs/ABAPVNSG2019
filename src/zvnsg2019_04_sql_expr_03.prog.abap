*&--------------------------------------------------------------------------------
*& VNSG 2019 - Dag voor ontwikkelaars
*& Ben Meijs Ctac NL - 04-04-2019
*&-------------------------------
*& Get the most out of ABAP on S4HANA
*& - SQL expressions - SELECT and Internal Tables
*& - WAS752 vv
*&------------------------------------
REPORT zvnsg2019_04_sql_expr_03.
"Set up the demo case
SELECT * FROM vbap INTO TABLE @DATA(orderitems) where vbeln = 'bvc'..

break-point.
"example of using internal table in SQL statement
SELECT orderitems~vbeln,
       orderitems~posnr,
       orderitems~matnr,
       orderheader~auart,
       material~mtart
  FROM @orderitems AS orderitems
  INNER JOIN vbak  AS orderheader ON orderheader~vbeln = orderitems~vbeln
  INNER JOIN mara  AS material    ON material~matnr    = orderitems~matnr
  INTO TABLE @DATA(ta_result).


zcl_vnsg_2019_alv_output=>show( CHANGING itab = ta_result ).
