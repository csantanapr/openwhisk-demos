# Watson Discovery API using OpenWhisk
This demo shows how to use [webpack](https://webpack.js.org) to build a bundle that includes npm dependencies and the user's action code into a single JavaScript file.

The action code is located in [./index.js](./index.js) notice that a `global.main = main` is added at the end, this allows webpack to expose the main function globaly that will be invoke by OpenWhisk.

The resulting bundle to deploy to OpenWhisk is located in [./dist/bundle.js](./dist/bundle.js)

## Install
install dependencies
```
npm intall
```

## Build 
Build the [./dist/bundle.js](./dist/bundle.js) using webpack
```
npm run deploy
```

## Deploy
Deploy action with credentials set as default parameters
```
wsk action update myaction dist/bundle.js --kind nodejs:8
```
Or you can use the npm script `deploy`
```
npm run deploy
```

## Invoke
Run a query by invoking the action
```
wsk action invoke myaction -r
```

## Test
Run the `npm test` command, this will run the `test` script in `package.json`
```
npm test
```
