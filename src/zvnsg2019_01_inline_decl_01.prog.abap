*&--------------------------------------------------------------------------------
*& VNSG 2019 - Dag voor ontwikkelaars
*& Ben Meijs Ctac NL - 04-04-2019
*&-------------------------------
*& Get the most out of ABAP on S4HANA
*& - Inline Declarations
*& - WAS740 vv
*&------------------------------------
REPORT zvnsg2019_01_inline_decl_01.

"Oude Code 1
DATA: my_daynumber TYPE i.
my_daynumber = sy-datum + 5.

"Inline Declaration 1
DATA(my_daynumber_inline) = sy-datum + 5.

WRITE: / my_daynumber,
       / my_daynumber_inline.



"Oude Code 2 : resultaat van een methode aanroep
DATA: randomizer    TYPE REF TO if_random_number,
      random_number TYPE i.
CREATE OBJECT randomizer TYPE cl_random_number.
random_number = randomizer->get_random_int( 100 ).

"Nieuwe Code 2 : resultaat van een methode aanroep
DATA: randomizer2    TYPE REF TO if_random_number.
CREATE OBJECT randomizer2 TYPE cl_random_number.
DATA(random_number_inline) = randomizer2->get_random_int( 100 ).

WRITE: / random_number.
WRITE: / random_number_inline.

"Oude code 3: resultaat van een Select statement
TYPES: BEGIN OF ty_st_result,
         vbeln TYPE vbak-vbeln,
         posnr TYPE vbap-posnr,
         matnr TYPE vbap-matnr,
       END   OF ty_st_result,
       ty_ta_result TYPE STANDARD TABLE OF ty_st_result
       WITH DEFAULT KEY.
DATA: ta_result TYPE ty_ta_result.
SELECT vbeln posnr matnr
  FROM vbap
  INTO TABLE ta_result
  UP TO 10 ROWS.


"Nieuwe code 3: resultaat van een Select statement
SELECT vbeln, posnr, matnr
  FROM vbap
  INTO TABLE @DATA(ta_result_inline)
  UP TO 10 ROWS.




  if ta_result <> ta_result_inline.
    BREAK-POINT.
  endif.
