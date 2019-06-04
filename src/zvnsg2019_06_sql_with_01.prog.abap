*&--------------------------------------------------------------------------------
*& VNSG 2019 - Dag voor ontwikkelaars
*& Ben Meijs Ctac NL - 04-04-2019
*&-------------------------------
*& Get the most out of ABAP on S4HANA
*& - Common Table Expressions (CTE)
*& - WAS750 vv
*&------------------------------------
REPORT zvnsg2019_06_sql_with_01.

INTERFACE lif_example.
  CLASS-METHODS: execute.
ENDINTERFACE.
CLASS lcl_example_old DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_example.
ENDCLASS.
CLASS lcl_example_new DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_example.
ENDCLASS.

PARAMETERS: rb_old RADIOBUTTON GROUP rad1,
            rb_new RADIOBUTTON GROUP rad1.

START-OF-SELECTION.

  CASE abap_true.
    WHEN rb_old.
      DATA(example) = CAST lif_example(  NEW lcl_example_old(  ) ).
    WHEN rb_new.
      example   = CAST lif_example(  NEW lcl_example_new(  ) ).
  ENDCASE.
  example->execute( ).



CLASS lcl_example_old IMPLEMENTATION.
  METHOD lif_example~execute.
    TYPES: BEGIN OF ty_st_result,
             vbeln        TYPE vbap-vbeln,
             posnr        TYPE vbap-posnr,
             currency_key TYPE vbap-waerk,
             netwr        TYPE vbap-netwr,
             total_amount TYPE vbap-netwr,
             netwr_part   TYPE p LENGTH 6 DECIMALS 5,
           END OF ty_st_result,
           ty_ta_result TYPE STANDARD TABLE OF ty_st_result WITH DEFAULT KEY.

    DATA: ta_result TYPE ty_ta_result.

    SELECT SUM( netwr ) AS total_amount,
           waerk        AS currency_key
           FROM vbap INTO TABLE @DATA(ta_totals)
           GROUP BY waerk ORDER BY waerk.

    SELECT vbeln,
           posnr,
           matnr,
           netwr,
           waerk AS currency_key
           FROM vbap INTO TABLE @DATA(ta_vbap) ORDER BY vbeln, posnr.

    LOOP AT ta_vbap ASSIGNING FIELD-SYMBOL(<vbap>).

      APPEND VALUE #(
      vbeln        = <vbap>-vbeln
      posnr        = <vbap>-posnr
      currency_key = <vbap>-currency_key
      netwr        = <vbap>-netwr

      total_amount = CONV #( ta_totals[ currency_key = <vbap>-currency_key ]-total_amount )
      netwr_part   = CONV #( <vbap>-netwr / VALUE #( ta_totals[ currency_key = <vbap>-currency_key ]-total_amount ) )
      ) TO ta_result.

    ENDLOOP.

    zcl_vnsg_2019_alv_output=>show( CHANGING itab = ta_result ).


  ENDMETHOD.


ENDCLASS.
CLASS lcl_example_new IMPLEMENTATION.
  METHOD lif_example~execute.

     WITH
     +totals AS ( SELECT SUM( netwr ) AS total_amount, waerk AS currency_key  FROM vbap  GROUP BY waerk ORDER BY waerk )
      SELECT vbap~vbeln,
             vbap~posnr,
             vbap~waerk,
             vbap~netwr,
             +totals~total_amount,
             division( vbap~netwr, +totals~total_amount, 5 ) AS netwr_part
             FROM vbap INNER JOIN +totals ON +totals~currency_key = vbap~waerk
             ORDER BY vbap~vbeln, vbap~posnr
             INTO TABLE @DATA(ta_result)
             .

    zcl_vnsg_2019_alv_output=>show( CHANGING itab = ta_result ).


  ENDMETHOD.

ENDCLASS.
