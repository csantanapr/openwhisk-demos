// jshint esversion: 6

const action = require('./sendEmail');
const params = require('./params.json');
action(params)
  .then(result => console.log("test passed",JSON.stringify(result)))
  .catch(error => console.err("test failed",error));
