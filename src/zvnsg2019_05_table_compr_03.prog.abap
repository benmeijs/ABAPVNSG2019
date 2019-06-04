*&--------------------------------------------------------------------------------
*& VNSG 2019 - Dag voor ontwikkelaars
*& Ben Meijs Ctac NL - 04-04-2019
*&-------------------------------
*& Get the most out of ABAP on S4HANA
*& - Table Comprehensions - REDUCE
*& - WAS750 vv
*&------------------------------------
REPORT zvnsg2019_05_table_compr_03.



"determine the Highest and Lowest word
SELECT maktx FROM makt INTO TABLE @DATA(material_texts) UP TO 100 ROWS WHERE spras = @sy-langu.
"In this case it is important that first field has a very high value
DATA(min_word) =  REDUCE #( INIT l_min  = `zzzzz`
                                   FOR i IN material_texts
                                   NEXT l_min = cmin( val1 = l_min val2 = i-maktx  ) ).


DATA(max_word) =  REDUCE #( INIT l_max TYPE string
                                   FOR i IN material_texts
                                   NEXT l_max = cmax( val1 = l_max val2 = i-maktx  ) ).



data(demooutputservice) = cl_demo_output=>new( ).
demooutputservice->write( data = material_texts
                )->write( data = max_word
                )->write( data = min_word
                )->display( ).
