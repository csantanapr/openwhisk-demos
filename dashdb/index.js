var ibmdb = require("ibm_db");
function main(args){
  return {
    SQL_DESTROY:ibmdb.SQL_DESTROY
  };
}
exports.main = main;