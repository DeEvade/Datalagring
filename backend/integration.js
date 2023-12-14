const {
  createContractQuery,
  selectContractForUpdate,
  constructListInstrumentsQuery,
  updateContractQuery,
} = require("./task_4");

class Integration {
  pool;

  constructor(pool) {
    this.pool = pool;
  }

  // async query(queryString, values) {
  //   try {
  //     const result = await this.pool.query(queryString, values);
  //     return result.rows;
  //   } catch (err) {
  //     console.error("Error executing query:", err.message);
  //     throw err;
  //   }
  // }

  async readInstrument() {
    try {
      const result = await this.pool.query(constructListInstrumentsQuery());
      return result.rows;
    } catch (err) {
      console.error("Error executing query:", err.message);
      throw err;
    }
  }

  async createContract(studentId, instrumentId) {
    return this.wrapInTransaction(async (client) => {
      try {
        const result = await client.query(createContractQuery(), [
          studentId,
          instrumentId,
          "874f979b-7587-4fe5-aa5b-1678c7cb66e8"
        ]);
        return result.rows[0];
      } catch (error) {
        throw error;
      }
    });
  }

  async readContract(instrumentId, client) {
    try {
      const result = await client.query(selectContractForUpdate(), [
        instrumentId,
      ]);
      return result;
    } catch (error) {
      throw error;
    }
  }

  async updateContract(newContract, client) {
    try {
      const result = await client.query(updateContractQuery(), [
        ...newContract,
      ]);
      return result;
    } catch (error) {
      throw error;
    }
  }
  

  async wrapInTransaction(callback) {
    const client = await this.pool.connect();
    try {
      await client.query("BEGIN");

      const result = await callback(client);

      await client.query("COMMIT");
      return result;
    } catch (err) {
      await client.query("ROLLBACK");
      console.error("Error executing update:", err.message);
      throw err;
    } finally {
      client.release();
    }
  }
}
module.exports = Integration;
