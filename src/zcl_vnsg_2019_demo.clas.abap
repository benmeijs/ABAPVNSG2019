class ZCL_VNSG_2019_DEMO definition
  public
  final
  create public .

public section.

  types:
    ty_range_matnr TYPE RANGE OF mara-matnr .

  methods CONSTRUCTOR .
  methods IS_RANDOM_NEW_DATE_VALID
    importing
      !I_DATUM type D
    returning
      value(RETURNING) type ABAP_BOOL .
  methods RECEIVES_A_STRUCTURE
    importing
      !I_BAPIRET2 type BAPIRET2 .
  methods OPTIONAL_PROCESSING
    importing
      !I_REFERENCE_DATE type D .
  methods RECEIVES_A_RANGE
    importing
      !I_MATNR_RANGE type TY_RANGE_MATNR .
protected section.
private section.
ENDCLASS.



CLASS ZCL_VNSG_2019_DEMO IMPLEMENTATION.


  method CONSTRUCTOR.
  endmethod.


  METHOD is_random_new_date_valid.

    IF i_datum < CONV d( ( sy-datum + 50 ) ).
      returning = abap_true.
    ENDIF.
  ENDMETHOD.


  method OPTIONAL_PROCESSING.
  endmethod.


  method RECEIVES_A_RANGE.
    data: lt_matnr_range like i_matnr_range.
    lt_matnr_range = i_matnr_range.

    zcl_vnsg_2019_alv_output=>show(
      CHANGING
        itab = lt_matnr_range
    ).
  endmethod.


  METHOD receives_a_structure.

   cl_DEMO_OUTPUT=>display_data( I_BAPIRET2 ).

  ENDMETHOD.
ENDCLASS.
