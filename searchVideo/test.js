// jshint esversion: 6

const action = require('./action').main;
const params = require('./params.json');
let result = action(params);
Promise.resolve(result)
  .then(result => console.log("test passed",JSON.stringify(result, null, 2)))
  .catch(error => console.err("test failed",error));
