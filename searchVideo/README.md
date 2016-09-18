## OpenWhisk search Video Demo
  This demo shows how to use OpenWhisk to send email 
  - Shows how to create a trigger `searchVideoTrigger`
  - Shows how to create an action `searchVideoAction`
  - Shows how to create a rule `searchVideoRule` between the trigger `searchVideoTrigger` and the action `searchVideoAction`

### Requirements
  - Access to a running [OpenWhisk](https://github.com/openwhisk/openwhisk) instance
  - The OpenWhisk CLI configured with correct `apihost`, `namespace`, and `auth`

> This action uses the Youtube API, for production please get your own API Key from Google.
See the [Youtube API](https://developers.google.com/youtube/v3/docs/search/list)

### Usage
  ```bash
  Usage: 
  ./wskproject.sh [--install, --update, --reinstall, --uninstall]
  ./wskproject.sh --test <query>
  ```

### Testing

#### Testing Locally
  Make sure you are using same version of node as OpenWhisk NodeJS environment.
  You can use [nvm](https://github.com/creationix/nvm) to easily install and switch node versions
  
  ```bash
  # switch to the specific node version 
  nvm install 6.2.0
  # to verify version
  node -v
  6.2.0
  ```

  Install dependencies using npm, use exact versioning for npm packages
  ```bash
  npm install
  ```
  
  Run test Locally
  Put the testing parameters in [./params.json](./params.json)
  Minimum replace `query` fields
  ```json
  {
    "query": "OpenWhisk",
  }
  ```
  This example will search video with the query "OpenWhisk"

  Then run the testing using `npm test` like the cool kids or just `node test.js`
  ```bash
  npm test
  ```

#### Testing using OpenWhisk
  Run `wsk activation poll` in one terminal then run `./wskproject.sh --test <query>` in another terminal window.

### Learn how the project works
  - Read [wskproject.sh](./wskproject.sh) to learn how to use the wsk cli.
  - Modify [action.js](./action.js) action to adjust and play :-). Remember to run `./wskproject.sh --update` to push your code to OpenWhisk
