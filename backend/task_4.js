 const constructListInstrumentsQuery = () => {
  return `
  select * from instrument
  join instrument_contract ic on ic.instrument_id = instrument.id
  where ic."isActive" = true
  ;
  `
}

exports.constructListInstrumentsQuery = constructListInstrumentsQuery;