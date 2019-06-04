*&--------------------------------------------------------------------------------
*& VNSG 2019 - Dag voor ontwikkelaars
*& Ben Meijs Ctac NL - 04-04-2019
*&-------------------------------
*& Get the most out of ABAP on S4HANA
*& - Table Comprehensions - REDUCE
*& - WAS750 vv
*&------------------------------------
REPORT zvnsg2019_05_table_compr_02.

SELECT * FROM vbap INTO TABLE @DATA(orderitems).

DATA(material_number_txt) = REDUCE #( INIT matnumbers TYPE string
                                        FOR ls_vbap IN orderitems
                                        NEXT matnumbers =
                                         COND #( WHEN matnumbers IS INITIAL
                                                   THEN ls_vbap-matnr
                                                   ELSE matnumbers && ';' && ls_vbap-matnr )
) .

cl_demo_output=>new( )->write( material_number_txt )->display( ).



cl_demo_output=>new( )->write(
REDUCE #( INIT matnumbers TYPE string
                                        FOR ls_vbap IN orderitems
                                        NEXT matnumbers =
                                         COND #( WHEN matnumbers IS INITIAL
                                                   THEN ls_vbap-matnr
                                                   ELSE matnumbers && ';' && ls_vbap-matnr )
)
)->display( ).

"determine the length of longest string in an internal table
SELECT maktx FROM makt INTO TABLE @DATA(material_texts) UP TO 100 ROWS where spras = @sy-langu.

cl_demo_output=>new( )->write(


 REDUCE i( INIT max = 0 FOR i IN material_texts NEXT max = nmax( val1 = max val2 = strlen( i-maktx ) ) )


)->display( ).


DATA(max_text_length) =  REDUCE i( INIT max = 0
                                   FOR i IN material_texts
                                   NEXT max = nmax( val1 = max val2 = strlen( i-maktx ) ) ).
BREAK-POINT.
