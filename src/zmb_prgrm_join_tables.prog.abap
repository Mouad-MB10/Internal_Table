*&~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*& Report ZMB_PRGRM_JOIN_TABLES
*&~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*&
*&~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
REPORT ZMB_PRGRM_JOIN_TABLES.

TABLES : SFLIGHT  .

types: BEGIN OF st_join ,
          carrid     TYPE  s_carr_id,
        connid     TYPE  s_conn_id,
        fldate     TYPE  s_date,
        price      TYPE  s_price,
        currency   TYPE  s_currcode,
        planetype  TYPE  s_planetye,
        seatsmax   TYPE  s_seatsmax,
        seatsocc   TYPE  s_seatsocc,
        paymentsum TYPE  s_sum,
*SPFLI
        countryfr  TYPE  land1,
        cityfrom   TYPE  s_from_cit,
        airpfrom   TYPE  s_fromairp,
        countryto  TYPE  land1,
        cityto     TYPE  s_to_city,
        airpto     TYPE  s_toairp,
        fltime     TYPE  s_fltime,
*SCARR
        carrname   TYPE s_carrname,
        currcode   TYPE s_currcode,
        url        TYPE s_carrurl,
     END OF st_join .


DATA : it_join type STANDARD TABLE OF st_join .



 SELECT-OPTIONS: s_carrid FOR sflight-carrid .

     SELECT sflight~carrid
            sflight~connid
            sflight~fldate
            sflight~price
            sflight~currency
            sflight~planetype
            sflight~seatsmax
            sflight~seatsocc
            sflight~paymentsum
            spfli~countryfr
            spfli~cityfrom
            spfli~airpfrom
            spfli~countryto
            spfli~cityto
            spfli~airpto
            spfli~fltime
            scarr~carrname
            scarr~currcode
            scarr~url
            INTO TABLE it_join FROM sflight INNER JOIN spfli ON  sflight~CARRID = spfli~carrid
                                            INNER JOIN scarr ON  spfli~carrid = scarr~carrid
            where sflight~carrid IN s_carrid .


         cl_demo_output=>display( it_join[] ).
