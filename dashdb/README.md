OpenWhisk has a limit of 48MB for zip actions
The npm package for dashb `ibm_db` it's too large and makes the action zip too large.

Gladly OpenWhisk supports Docker Actions.
You can upload a docker image to docker hub and then create an action that uses this image.

For this solution we are going to create a docker image using nodejs and adding `ibm_db`
Then creating an action using a zip but only including our code and no npm dependencies

To create a new image use docker
```
docker build -t user/action-nodejs-ibm-v6`
```
Adjust user to match your user name on docker hub

You can skip this step to experiment by using a prebuilt image `csantanapr/action-nodejs-ibm-v6`

Edit `index.js` to use the `ibm_db` npm package
Run `./deploy.sh` to build the action.zip with index.js and deploy the action to OpenWhisk.

Adjust the `./deloy.sh` as necessary

