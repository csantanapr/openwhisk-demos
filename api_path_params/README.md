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
curl https://<apigatewayhost>/<tenantid>/api/v1/contacts/{id}
```

## Bonus Points
Using [IBM Cloud API Management](https://console.bluemix.net/docs/apis/management/manage_apis.html#custom_domains) you can map the URL to your cutom domain.
For example uploading a SSL certificate generated using something like [Let's Encrypt](https://letsencrypt.org/) and mapping the API to your custom domain name.
Then you can have the API endpoint on your domain (i.e. https://example.com//api/v1/contacts/{id})