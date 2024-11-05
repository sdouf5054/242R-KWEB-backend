const mysql = require("mysql2/promise");

const pool = mysql.createPool({
  host: <db-host>,
  port: 3306,
  user: "root",
  password: <db-password>,
  database: "train_sys",
});

const runQuery = async (pstmt, data) => {
  const conn = await pool.getConnection();
  try {
    const sql = conn.format(pstmt, data);
    const [result] = await conn.query(sql);
    return result;
  } finally {
    conn.release();
  }
};
module.exports = { runQuery };
