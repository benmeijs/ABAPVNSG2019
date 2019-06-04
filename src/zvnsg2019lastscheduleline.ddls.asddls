@AbapCatalog.sqlViewName: 'ZVLASTSCHEDULE'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'VNSG 2019 Verkoopgegevens met laatste indelingsregel (EDATU)'
define view ZVNSG2019LASTSCHEDULEline
  as select from vbep
{
  key vbeln,
  key posnr,
      max( edatu ) as edatu
}
group by
  vbeln,
  posnr
