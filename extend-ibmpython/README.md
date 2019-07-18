This example shows show to create a python action with the following features
1. Extend the a base python image with more python packages using requirement.txt
2. Use multiple python files for the action



Create the docker image
```
docker build . -t csantanapr/ibmpython-extended
```

Push the docker image
```
docker push csantanapr/ibmpython-extended
```

Build the zip `action-src.zip` file using the source code files
```
cd src && zip ../action-src.zip -r * && cd ..
```

Create your openwhisk action
```
ibmcloud fn action update python-action action-src.zip --docker csantanapr/ibmpython-extended
```

Invoke your openwhisk action
```
ibmcloud fn action invoke python-action -p name Carlos -r
```
The output:
```json                               
{
    "greeting": "Hello Carlos!"
}
```