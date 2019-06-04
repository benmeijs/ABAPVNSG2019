*&--------------------------------------------------------------------------------
*& VNSG 2019 - Dag voor ontwikkelaars
*& Ben Meijs Ctac NL - 04-04-2019
*&-------------------------------
*& Get the most out of ABAP on S4HANA
*& - Constructor Expressions 3 - VALUE, CORRESPONDING
*& - WAS740 vv
*&------------------------------------
REPORT zvnsg2019_02_constr_expr_03.

" Original
DATA: ta_bapiret2 TYPE bapiret2_t.

DATA: wa_bapiret2 LIKE LINE OF ta_bapiret2.

wa_bapiret2-id         = '38'.
wa_bapiret2-type       = 'I'.
wa_bapiret2-number     = '001'.
wa_bapiret2-message_v1 = 'Voorbeeld VNSG 2019'.
wa_bapiret2-message_v2 = 'Parameter 2'.
wa_bapiret2-message_v3 = 'Parameter 3'.
wa_bapiret2-message_v4 = 'Parameter 4'.

APPEND wa_bapiret2 TO ta_bapiret2.


"Aangepast

APPEND VALUE #(
   id         = '38'
   type       = 'I'
   number     = '001'
   message_v1 = 'Voorbeeld VNSG 2019'
   message_v2 = 'Parameter 2'
   message_v3 = 'Parameter 3'
   message_v4 = 'Parameter 4'                )
    TO ta_bapiret2.



" Structure to a method

wa_bapiret2-id         = '38'.
wa_bapiret2-type       = 'I'.
wa_bapiret2-number     = '001'.
wa_bapiret2-message_v1 = 'Voorbeeld VNSG 2019'.
wa_bapiret2-message_v2 = 'Parameter 2'.
wa_bapiret2-message_v3 = 'Parameter 3'.
wa_bapiret2-message_v4 = 'Parameter 4'.

NEW zcl_vnsg_2019_demo( )->receives_a_structure( wa_bapiret2 ).


NEW zcl_vnsg_2019_demo( )->receives_a_structure(
 i_bapiret2 =  VALUE #(
                 id         = '38'
                 type       = 'I'
                 number     = '001'
                 message_v1 = 'Voorbeeld VNSG 2019'
                 message_v2 = 'Parameter 2'
                 message_v3 = 'Parameter 3'
                 message_v4 = 'Parameter 4'         )
                            ).
