// jshint esversion: 6

action = require('./sendEmail');
params = require('./params.json');
action(params)
.then((result)=>console.log("test passed",JSON.stringify(result)))
.catch((error)=>console.err("test failed",error));
