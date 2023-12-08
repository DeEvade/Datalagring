 const constructListInstrumentsQuery = () => {
  return `
  select * from instrument
  full join instrument_contract ic on ic.instrument_id = instrument.id
  where ic."isActive"  = false or ic."isActive" is null 
  ;
  `
}
exports.constructListInstrumentsQuery = constructListInstrumentsQuery;