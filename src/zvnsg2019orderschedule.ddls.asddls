@AbapCatalog.sqlViewName: 'ZVNSG2019VBAP'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'VNSG 2019 Verkoopgegevens met laatste indelingsregeL'
define view ZVNSG2019ORDERSCHEDULE 
as select from vbap 
inner join ZVNSG2019LASTSCHEDULEline as LAST_VBEP
            on LAST_VBEP.vbeln = vbap.vbeln 
           and LAST_VBEP.posnr = vbap.posnr
inner join vbep 
            on vbep.vbeln = LAST_VBEP.vbeln
           and vbep.posnr = LAST_VBEP.posnr
           and vbep.edatu = LAST_VBEP.edatu 
          
{
 key vbap.vbeln,
 key vbap.posnr,
     vbap.waerk,
     vbap.netwr,
     vbep.etenr,
     vbep.edatu,
     vbap.kwmeng,
     vbap.vrkme,
     vbep.wmeng,
     vbep.bmeng    
}
