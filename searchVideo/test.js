// jshint esversion: 6

const action = require('./action');
const params = require('./params.json');
action(params)
  .then(result => console.log("test passed",JSON.stringify(result, null, 2)))
  .catch(error => console.err("test failed",error));
