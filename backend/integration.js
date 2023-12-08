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

  async wrapInTransaction() {
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
};
module.exports = Integration;
