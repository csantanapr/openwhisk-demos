// jshint esversion:6
const ibmdb = require('ibm_db')
const queryString = 'SELECT FIRST_NAME, LAST_NAME, EMAIL from GOSALESHR.employee FETCH FIRST 3 ROWS ONLY'
async function main ({
  __bx_creds: { dashDB: { ssldsn } }
}) {
  let connection, result, rows
  try {
    connection = await ibmdb.open(ssldsn)
    rows = await connection.query(queryString)
    connection.close()
    result = { employees: rows }
  } catch (err) {
    console.error(err.message)
    result = { message: err.message }
  }
  return result
};
