class ZCL_VNSG_2019_ALV_OUTPUT definition
  public
  final
  create public .

public section.

  class-methods SHOW
    changing
      !ITAB type STANDARD TABLE .
protected section.
private section.
ENDCLASS.



CLASS ZCL_VNSG_2019_ALV_OUTPUT IMPLEMENTATION.


  method SHOW.

   TRY.

        cl_salv_table=>factory(
          IMPORTING
            r_salv_table   = DATA(alv)
          CHANGING
            t_table        = itab
        ).
        alv->get_functions( )->set_all( ).
        alv->get_display_settings( )->set_striped_pattern( cl_salv_display_settings=>true ).
        alv->get_display_settings( )->set_list_header( sy-title ).

        DATA(columns) = alv->get_columns( ).
        columns->set_optimize( ).
        DATA(columns_tab) = alv->get_columns( )->get( ).
        LOOP AT columns_tab ASSIGNING FIELD-SYMBOL(<column>).
          IF <column>-r_column->get_long_text( ) IS INITIAL.
            <column>-r_column->set_long_text( CONV #( <column>-columnname ) ).
          ENDIF.
        ENDLOOP.

        alv->display( ).

      CATCH cx_salv_msg INTO DATA(alv_exc).
        MESSAGE alv_exc->get_text( ) TYPE 'E'.
    ENDTRY.

  endmethod.
ENDCLASS.
