const constructListInstrumentsQuery = () => {
  return `
  select * from instrument
  full join instrument_contract ic on ic.instrument_id = instrument.id
  where ic."isActive"  = false or ic."isActive" is null 
  ;
  `
}
const createContractQuery = () =>{
  return `
  insert into instrument_contract("student_id","instrument_id")
  VALUES ($1, $2);
  
  `;
}
exports.constructListInstrumentsQuery = constructListInstrumentsQuery;
exports.createContractQuery = createContractQuery;