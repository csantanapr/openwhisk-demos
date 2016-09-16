## OpenWhisk Stock Trigger project
  This demo shows how to use OpenWhisk to send email 
  - Shows how to create a trigger `sendEmailTrigger`
  - Shows how to create an action `sendEmailAction`
  - Shows how to create a rule `sendEmailRule` between the trigger `sendEmailTrigger` and the action `sendEmailAction`

### Requirements
  - Access to a running [OpenWhisk](https://github.com/openwhisk/openwhisk) instance
  - The OpenWhisk CLI configured with correct `apihost`, `namespace`, and `auth`

> To use Gmail you may need to configure ["Allow Less Secure Apps"](https://www.google.com/settings/security/lesssecureapps) in your Gmail account unless you are using 2FA in which case you would have to create an [Application Specific](https://security.google.com/settings/security/apppasswords) password. You also may need to unlock your account with ["Allow access to your Google account"](https://accounts.google.com/DisplayUnlockCaptcha) to use SMTP.

### Usage
  ```
  Usage: 
  ./wskproject.sh [--install, --update, --reinstall, --uninstall]
  ./wskproject.sh --test <username> <password> <to> <subject> <text>
  ```

### Testing

## Testing Locally
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
  Minimum replace `username`, `password`, `to` fields
  ```json
  {
    "username": "XXXXXX@gmail.com",
    "password": "XXXXXXXXXXXXXXXXXX",
    "from": "\"OpenWhisk  📫\" <wsk@example.com>",
    "to": "XXXXXXXX@gmail.com",
    "subject": "Hello from OpenWhisk ✔",
    "text": "Hello world in text 😹, if you pass html text doesn't get use",
    "html": "<b>Hello world in html 😹</b>"
  }
  ```

  Then run the testing using `npm test` like the cool kids or just `node test.js`
  ```bash
  npm test
  ```

## Testing using OpenWhisk
  Run `wsk activation poll` in one terminal then run `./wskproject.sh --test <username> <password> <to> <subject> <text>` in another terminal window.

### Learn how the project works
  - Read [wskproject.sh](./wskproject.sh) to learn how to use the wsk cli.
  - Modify [sendEmail.js](./sendEmail.js) action to adjust and play :-). Remember to run `./wskproject.sh --update` to push your code to OpenWhisk
