*&--------------------------------------------------------------------------------
*& VNSG 2019 - Dag voor ontwikkelaars
*& Ben Meijs Ctac NL - 04-04-2019
*&-------------------------------
*& Get the most out of ABAP on S4HANA
*& - Common Table Expressions (CTE)
*& - WAS750 vv
*&------------------------------------
REPORT zvnsg2019_06_sql_with_02a.

DATA: selectiontext TYPE string VALUE 'VBAK-VBELN'.
SELECT-OPTIONS: so_vbeln FOR (selectiontext).
break-point.
WITH
+last_schedule_lines AS ( SELECT vbeln, posnr, MAX( edatu ) AS edatu
                          FROM vbep
                          WHERE vbeln IN @so_vbeln
                          GROUP BY vbeln, posnr
                          ORDER BY vbeln, posnr )
 SELECT vbap~vbeln,
        vbap~posnr,
        vbap~waerk,
        vbap~netwr,
        vbep~etenr,
        vbep~edatu,
        vbep~wmeng
        FROM vbap
        INNER JOIN +last_schedule_lines AS last_vbep
           ON last_vbep~vbeln = vbap~vbeln
          AND last_vbep~posnr = vbap~posnr
        INNER JOIN vbep
           ON vbep~vbeln = last_vbep~vbeln
          AND vbep~posnr = last_vbep~posnr
          AND vbep~edatu = last_vbep~edatu
        ORDER BY vbap~vbeln, vbap~posnr
        INTO TABLE @DATA(ta_result)
        .

zcl_vnsg_2019_alv_output=>show( CHANGING itab = ta_result ).
