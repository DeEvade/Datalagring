const unrent = async (instrumentId, integration) => {
  return integration.wrapInTransaction(async (client) => {
    try {
      const contractResult = await integration.fetchContract(
        instrumentId,
        client
      );
      const filtered = contractResult["rows"].filter(
        (row) => row["is_active"] === true
      );
      console.log("filtered", filtered);
      if (filtered.length === 0) {
        return "The instrument is not rented! So you cannot unrent!";
      } else {
        const contract = filtered[0];
        const attributeArray = [
          contract["id"],
          false,
          contract["student_id"],
          contract["instrument_id"],
          contract["time_slot_id"],
        ];
        const updateResult = await integration.updateContract(
          attributeArray,
          client
        );
        return updateResult["rowCount"] === 1
          ? "Successfully unrented instrument."
          : "No update occured.";
      }
    } catch (error) {
      throw error;
    }
  });
};
exports.unrent = unrent;
