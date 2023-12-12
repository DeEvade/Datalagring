const constructListInstrumentsQuery = () => {
  return `
  select *, i.id as instr_id from instrument i
    where i.id not in (
      select ic.instrument_id from instrument_contract ic
    where ic.is_active = true)
    ;
  `
}
const createContractQuery = () =>{
  return `
  insert into instrument_contract("student_id","instrument_id", "time_slot_id")
  VALUES ($1, $2, $3);
  `;
}

const selectContractForUpdate = () =>{
  return `
  select * from instrument_contract where instrument_id = $1 for update;
  `;
}



const updateContractQuery = () =>{
  return `
  update instrument_contract 
    set "is_active" = $2,
    "student_id" = $3,
    "instrument_id" = $4,
    "time_slot_id" = $5
  where id = $1;
  `;
}
exports.updateContractQuery = updateContractQuery;

exports.selectContractForUpdate = selectContractForUpdate;

exports.constructListInstrumentsQuery = constructListInstrumentsQuery;
exports.createContractQuery = createContractQuery;