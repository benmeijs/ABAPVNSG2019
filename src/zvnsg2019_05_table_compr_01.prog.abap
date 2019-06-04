*&--------------------------------------------------------------------------------
*& VNSG 2019 - Dag voor ontwikkelaars
*& Ben Meijs Ctac NL - 04-04-2019
*&-------------------------------
*& Get the most out of ABAP on S4HANA
*& - Table Comprehensions - FOR en GROUP BY
*& - WAS750 vv
*&------------------------------------
REPORT zvnsg2019_05_table_compr_01.

TYPES: ty_range_matnr TYPE RANGE OF mara-matnr.

SELECT * FROM vbap INTO TABLE @DATA(orderitems).

" LOOP

DATA: materialnumber_range TYPE ty_range_matnr.
LOOP AT orderitems ASSIGNING FIELD-SYMBOL(<orderitem>).
  APPEND  VALUE #( low    = <orderitem>-matnr
                   sign   = 'I'
                   option = 'EQ' )
          TO materialnumber_range.
ENDLOOP.

" FOR

DATA(materialnummers_for) = VALUE ty_range_matnr(
                               FOR ls_vbap IN orderitems (
                                   low    = ls_vbap-matnr
                                   option = 'EQ'
                                   sign   = 'I' ) ).

" FOR + GROUPS

DATA(materialnummers_for2) = VALUE ty_range_matnr(
                               FOR GROUPS l_materialnumber OF ls_vbap IN orderitems GROUP BY ls_vbap-matnr
                                  (
                                   low    = l_materialnumber
                                   option = 'EQ'
                                   sign   = 'I' ) ).


NEW zcl_vnsg_2019_demo( )->receives_a_range(
                             i_matnr_range = VALUE #(
                               FOR GROUPS l_materialnumber OF ls_vbap IN orderitems GROUP BY ls_vbap-matnr
                                  (
                                   low    = l_materialnumber
                                   option = 'EQ'
                                   sign   = 'I' ) )  ).
