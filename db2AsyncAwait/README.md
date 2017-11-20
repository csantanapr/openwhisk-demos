# Action using nodejs:8 and async/await
This demo shows how to use [ibm_db](https://www.npmjs.com/package/ibm_db) npm package and async/await from nodejs 8.

The action code is located in [./index.js](./index.js)

## Deploy
Deploy action with credentials set as default parameters
```
wsk action update my-action index.js --kind nodejs:8
```
Or you can use the npm script
```
npm run deploy
```

## [Optional] Create db2 service using bx
Use the bx CLI to create service instance
```
npm run service
```
Or you can use the npm script
```
bx service create dashDB Entry db2
```
## Bind the service to the action 
Use the bx CLI to copy the service credentials as default parameters into the action
```
bx wsk service bind dashDB my-action
```
Or you can use the npm script
```
npm run bind
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
