## OpenWhisk Stock Trigger project
  This demo shows how to use OpenWhisk to send email 
  - Shows how to create a trigger `sendEmailTrigger`
  - Shows how to create an action `sendEmailAction`
  - Shows how to create a rule `sendEmailRule` between the trigger `sendEmailTrigger` and the action `sendEmailAction`

### Requirements
  - Access to a running [OpenWhisk](https://github.com/openwhisk/openwhisk) instance
  - The OpenWhisk CLI configured with correct `apihost`, `namespace`, and `auth`

### Usage
  ```
  Usage: 
  ./wskproject.sh [--install, --update, --reinstall, --uninstall]
  ./wskproject.sh --test <username> <password> <to> <subject> <text>
  ```

### Testing
  Run `wsk activation poll` in one terminal then run `./wskproject.sh --test` in another terminal window.

### Learn how the project works
  - Read [wskproject.sh](./wskproject.sh) to learn how to use the wsk cli.
  - Modify [sendEmail.js](./sendEmail.js) action to adjust and play :-). Remember to run `./wskproject.sh --update` to push your code to OpenWhisk
