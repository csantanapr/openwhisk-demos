# DashDB with OpenWhisk

OpenWhisk has a limit of 48MB for zip actions
The npm package for dashb `ibm_db` it's too large (~80MB) and makes the action zip too large.

Gladly OpenWhisk supports Docker Actions.
You can upload a docker image to docker hub and then create an action that uses this image.

## Build docker image for nodejs6 with additional npm modules
For this solution we are going to create a docker image using nodejs and adding `ibm_db`
Then creating an action using a zip but only including our code and no npm dependencies

To create a new image use docker
```
docker build . -t user/action-nodejs-ibm-v6
docker push user/action-nodejs-ibm-v6
```
Adjust user to match your user name on docker hub

You can skip this step to **experiment** by using a prebuilt image [csantanapr/action-nodejs-ibm-v6](https://hub.docker.com/r/csantanapr/action-nodejs-ibm-v6/tags), for production you must use your own image

## Deploy action
Setup the `wsk` CLI and configure for your OpenWhisk host



Run `./deploy.sh` to build the action.zip with `index.js` inside and deploy the action to OpenWhisk specifying your docker image wich includes `ibm_db` package

```
./deloy.sh
```

## Customizing deployent
You can override some settings in deploy.sh using environment variables:
```
OPENWHISK_ACTION_NAME
OPENWHISK_ACTION_DOCKER_IMAGE
OPENWHISK_HOST
OPENWHISK_AUTH
```
For example to deploy using your own image
```
OPENWHISK_ACTION_DOCKER_IMAGE="user/action-nodejs-ibm-v6" \
./deploy.sh
```

You can also pass as arguments the name of the action, an existing zip archive, and the name of the image
```
./deloy.sh myaction myaction.zip csantanapr/action-nodejs-ibm-v6
```

Adjust the `./deloy.sh` as necessary for more customizations

# Invoke the action
Invoke the action using the `wsk` CLI using default action name `dash_db`
```
wsk action invoke dash_db -r
```