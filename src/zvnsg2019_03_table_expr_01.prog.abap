*&--------------------------------------------------------------------------------
*& VNSG 2019 - Dag voor ontwikkelaars
*& Ben Meijs Ctac NL - 04-04-2019
*&-------------------------------
*& Get the most out of ABAP on S4HANA
*& - Table Expressions
*& - WAS740 vv
*&------------------------------------
REPORT zvnsg2019_03_table_expr_01.
DATA: th_materialdata TYPE zttvnsg2019_mara. "HASHED matnr SORTED ersda bismt

SELECT * FROM mara INTO TABLE th_materialdata.
SELECT * FROM vbap INTO TABLE @DATA(ta_salesorderitems) ORDER BY vbeln , posnr.



"Table Expression 1 - Old Code

LOOP AT ta_salesorderitems ASSIGNING FIELD-SYMBOL(<orderitem>).

  READ TABLE th_materialdata
       ASSIGNING FIELD-SYMBOL(<material>)
       WITH TABLE KEY matnr = <orderitem>-matnr.

ENDLOOP.

"Table Expression 1 - New Code

LOOP AT ta_salesorderitems ASSIGNING FIELD-SYMBOL(<orderitem_e>).

  ASSIGN th_materialdata[ matnr = <orderitem_e>-matnr ]
         TO FIELD-SYMBOL(<material_e>).

ENDLOOP.

"Table Expression 1 - New Code but with exception

LOOP AT ta_salesorderitems ASSIGNING FIELD-SYMBOL(<orderitem_x>).
  TRY.
      ASSIGN th_materialdata[ matnr = <orderitem_x>-matnr ]
             TO FIELD-SYMBOL(<material_x>).

    CATCH cx_sy_itab_line_not_found.

  ENDTRY.
ENDLOOP.

"Table Expression 1 - New Code but with DEFAULT

LOOP AT ta_salesorderitems ASSIGNING FIELD-SYMBOL(<orderitem_y>).

*  DATA(material_data) = VALUE #( th_materialdata[ matnr = <orderitem_y>-matnr ] DEFAULT '   Een Default Waarde' ).
  DATA(material_data) = VALUE #( th_materialdata[ matnr = <orderitem_y>-matnr ] OPTIONAL ).

ENDLOOP.

"Table Expression 1 - New Code but with explicit key name

LOOP AT ta_salesorderitems ASSIGNING FIELD-SYMBOL(<orderitem_q>).

  DATA(material_data_q) = VALUE #( th_materialdata[ KEY primary_key COMPONENTS matnr = <orderitem_q>-matnr ] OPTIONAL ).

ENDLOOP.

"Table Expression 1 - New Code but with explicit key name (sec key)

LOOP AT ta_salesorderitems ASSIGNING FIELD-SYMBOL(<orderitem_z>).

  DATA(material_data_z) = VALUE #( th_materialdata[ KEY oldkey COMPONENTS bismt = <orderitem_z>-matnr ] OPTIONAL ).

ENDLOOP.
