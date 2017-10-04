# Watson Discovery API using OpenWhisk

This demo shows how to use webpack to build a bundle that includes the watson sdk and the user's action code into a single JavaScript file

The action code is located in [./index.js](./index.js) notice that a `global.main = main` is added at the end, this allows webpack to expose the main function globaly that will be invoke by OpenWhisk.

## Install

install dependencies
```
npm intall
```

## Build 

Build the bundle using webpac
```
npm start
```

## Configure

Edit [./params.json](./params.json) and enter your credentials for the Watson Discovery API
```
{
  "username":"",
  "password":""
}
```

Deploy action with credentials set as default parameters
```
wsk action update myaction dist/bundle.js --param-file params.json
```

## Invoke

Run a query by invoking the action
```
wsk action invoke myaction -r
```

