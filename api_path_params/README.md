# Shows how to create an API to handle path parameters using OpenWhisk

Let's say you want a web API in the form of `https://hostname/api/v1/constacts/:id`

The OpenWhisk Action shows an example on how to handle a http request with `GET` and path `/constacts/:id`
```javascript
const UrlPattern = require('url-pattern');
const pattern = new UrlPattern('/api/v1/contacts/:id');
function main({__ow_path:path}) {
  return { body: findContactById(pattern.match(path)) }
}
```

## Install dependencies
1. Install and Configure CLI `bx wsk` using [IBM Cloud CLI Functions plugin](https://console.bluemix.net/docs/openwhisk/bluemix_cli.html#cloudfunctions_cli)
    ```
    bx wsk list
    ```
2. Install nodejs deps:
    ```
    npm install
    ```

## TLDR;
```
npm start
```

## Build
```
npm run build
```

## Deploy
```
npm run deploy
```

## Build and Deploy
```
npm run all
```

## Get API URL
```
npm run api
```
API info display including `URL`
```
Action: /csantana@us.ibm.com_demo/getContact
   API Name: contacts
   Base path: /api/v1
   Path: /contacts/{id}
   Verb: get
   URL: https://<apigatewayhost>/<tenantid>/api/v1/contacts/{id}
```

## Call API
Open a browser, or use tool of choice using the `URL` from previous step
```
curl https://<apigatewayhost>/<tenantid>/api/v1/contacts/1234
```
Output: Found contact from data store with id `1234` return resource with content-type `application/json` and statusCode `200`
```json
{
  "firstName": "Carlos",
  "lastName": "Santana",
  "twitter": "csantanapr",
  "id": "1234"
}
```

## Bonus Points
Using [IBM Cloud API Management](https://console.bluemix.net/docs/apis/management/manage_apis.html#custom_domains) you can map the URL to your cutom domain.
For example uploading a SSL certificate generated using something like [Let's Encrypt](https://letsencrypt.org/) and mapping the API to your custom domain name.
Then you can have the API endpoint on your domain (i.e. https://example.com//api/v1/contacts/{id})
