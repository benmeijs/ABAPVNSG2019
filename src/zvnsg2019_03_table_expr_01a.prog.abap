*&--------------------------------------------------------------------------------
*& VNSG 2019 - Dag voor ontwikkelaars
*& Ben Meijs Ctac NL - 04-04-2019
*&-------------------------------
*& Get the most out of ABAP on S4HANA
*& - Table Expressions
*& - WAS740 vv
*&------------------------------------
REPORT zvnsg2019_03_table_expr_01a.
DATA: th_materialdata TYPE zttvnsg2019_mara. "HASHED matnr SORTED ersda bismt

SELECT * FROM mara INTO TABLE th_materialdata.
SELECT * FROM vbap INTO TABLE @DATA(ta_salesorderitems) ORDER BY vbeln , posnr.


"Table Expression 1 - New Code but with explicit key name (sec key)

LOOP AT ta_salesorderitems ASSIGNING FIELD-SYMBOL(<orderitem>).

  DATA(material_data)   = VALUE #( th_materialdata[ KEY oldkey COMPONENTS bismt = <orderitem>-matnr ] DEFAULT '   NIETS GEVONDEN' ).
  DATA(material_data_2) = VALUE #( th_materialdata[ KEY oldkey COMPONENTS bismt = <orderitem>-matnr ] OPTIONAL ).

  WRITE : / <orderitem>-vbeln,
            <orderitem>-posnr,
            <orderitem>-matnr,
            material_data-matnr,
            material_data_2-matnr.

ENDLOOP.
