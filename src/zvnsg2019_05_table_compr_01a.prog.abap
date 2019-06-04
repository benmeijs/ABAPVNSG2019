*&--------------------------------------------------------------------------------
*& VNSG 2019 - Dag voor ontwikkelaars
*& Ben Meijs Ctac NL - 04-04-2019
*&-------------------------------
*& Get the most out of ABAP on S4HANA
*& - Table Comprehensions - FOR en GROUP BY
*& - WAS750 vv
*&------------------------------------
REPORT zvnsg2019_05_table_compr_01a.

SELECT * FROM vbap INTO TABLE @DATA(orderitems).

DATA(democlass) = NEW zcl_vnsg_2019_demo( ).
break-point.
democlass->receives_a_range( i_matnr_range = VALUE #(
                               FOR GROUPS l_materialnumber OF ls_vbap IN orderitems GROUP BY ls_vbap-matnr
                                  (
                                   low    = l_materialnumber
                                   option = 'EQ'
                                   sign   = 'I' ) )  ).
