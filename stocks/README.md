## OpenWhisk Stock Trigger project
  This demo shows how to use OpenWhisk to process stock data
  - Shows how to create a trigger `stockTrigger`
  - Shows how to create an action `processStocks`
  - Shows how to create a rule between the trigger `stockTrigger` and action `processStocks`

### Requirements
  Access to deploy [OpenWhisk](https://github.com/openwhisk/openwhisk) instance
  The OpenWhisk CLI configured with correct `apihost`, `namespace`, and `auth`

### Usage
  ```
  Usage: ./wskproject.sh [--install,--test,--update,--reinstall]
  ```

### Testing
  Run `wsk activation poll` in one terminal then run `./wskproject.sh --test` in another terminal window.

### Learn how the project works
  - Read [wskproject.sh](./wskproject.sh) to learn how to use the wsk cli, and use curl to access the OpenWhisk API
  - Modify [processStocks.js](./processStocks.js) action to adjust and play :-)
