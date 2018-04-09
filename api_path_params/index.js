const UrlPattern = require('url-pattern');
const pattern = new UrlPattern('/api/v1/contacts/:id');
function main({__ow_path:path}) {
  return { body: findContactById(pattern.match(path)) }
}


function findContactById({id}){
  return {
    firstName: "Carlos",
    lastName: "Santana",
    twitter: "csantanapr",
    id
  }
}

global.main = main;