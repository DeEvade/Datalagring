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

  async query(queryString, values) {
    try {
      const result = await this.pool.query(queryString, values);
      return result.rows;
    } catch (err) {
      console.error("Error executing query:", err.message);
      throw err;
    }
  }

  async listInstrument() {
    //ReadInstruments
    try {
      const result = await this.pool.query(constructListInstrumentsQuery());
      return result.rows;
    } catch (err) {
      console.error("Error executing query:", err.message);
      throw err;
    }
  }

  async test() {
    try {
      const result = await this.pool.query("select * from student");
      return result.rows;
    } catch (err) {
      console.error("Error executing query:", err.message);
      throw err;
    }
  }
  /*
    const client = await this.pool.connect();
    try {
      await client.query('BEGIN');

      const result = await client.query(createContractQuery(), [studentId, instrumentId]);

      await client.query('COMMIT');
      return result.rows[0];
    } catch (err) {
      await client.query('ROLLBACK');
      console.error('Error creating contract:', err.message);
      throw err;
    } finally {
      client.release();
    }


*/
  async createContract(studentId, instrumentId) {
    return this.wrapInTransaction(async (client) => {
      try {
        const result = await client.query(createContractQuery(), [
          studentId,
          instrumentId,
        ]);
        return result.rows[0];
      } catch (error) {
        throw error;
      }
    });
  }

  async fetchContract(instrumentId, client) {
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
