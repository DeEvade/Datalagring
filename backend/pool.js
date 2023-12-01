const { Pool } = require('pg');

let sqlPool = undefined;

 function getSQLPool() {
  if (!sqlPool) {
    sqlPool = new Pool({ ...getConnectionConfig() });
  }

  return sqlPool;
}

function getConnectionConfig() {
  const config = {
    host: process.env.DB_HOST,
    port: Number(process.env.DB_PORT),
    database: process.env.DB_NAME,
    user: process.env.DB_USERNAME,
    password: process.env.DB_PASSWORD,
    max: 10,
  };

  for (const key in config) {
    if (!config[key]) {
      throw new Error(`Missing database config: ${key}`);
    }
  }

  return config;
}


module.exports = { getSQLPool };
