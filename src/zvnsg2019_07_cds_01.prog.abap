*&--------------------------------------------------------------------------------
*& VNSG 2019 - Dag voor ontwikkelaars
*& Ben Meijs Ctac NL - 04-04-2019
*&-------------------------------
*& Get the most out of ABAP on S4HANA
*& - CDS voorbeeld met ALV IDA
*& - WAS740 vv
*&------------------------------------
REPORT zvnsg2019_07_cds_01.

DATA: selectiontext TYPE string VALUE 'VBAK-VBELN'.
SELECT-OPTIONS: so_vbeln FOR (selectiontext).

TRY.
    DATA(alv) =  cl_salv_gui_table_ida=>create_for_cds_view( 'ZVNSG2019ORDERSCHEDULE' ).
    DATA(lo_collector) = NEW cl_salv_range_tab_collector( ).
    lo_collector->add_ranges_for_name( iv_name = 'VBELN'     it_ranges = so_vbeln[] ).
    lo_collector->get_collected_ranges( IMPORTING et_named_ranges = DATA(lt_name_range_pairs) ).
    alv->set_select_options( it_ranges = lt_name_range_pairs ).
    alv->fullscreen( )->display( ).
  CATCH cx_salv_function_not_supported INTO DATA(lo_exc).
    MESSAGE lo_exc TYPE 'I'.
ENDTRY.
