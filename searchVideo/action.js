// jshint esversion: 6
/*
 videoSearch using youtube API https://developers.google.com/youtube/v3/docs/search/list
*/

var request = require('request');
function main({
  query: query,
  part: part = 'snippet',
  maxResults: maxResults = 10,
  type: type = 'video',
  key: key = 'AIzaSyD-AqEfjuN-0jHjb795G1yPg-HR8H_Xi9g',
  baseURl: baseURl = 'https://www.googleapis.com/youtube/v3/search'
}) {
  const url = `${baseURl}?q=${query}&part=${part}&maxResults=${maxResults}&type=${type}&key=${key}`;
  return new Promise((resolve, reject) => {
    request(url, function (error, response, body) {
      if (!error && response.statusCode == 200) {
        console.log('success video search');
        resolve(JSON.parse(body));
      } else {
        console.error('failed video search');
        console.error('error:', error);
        reject(error);
      }
    });
  });
}









/*
Only required for testing locally, running in OpenWhisk this get's ignored
Export main function only if its being use as a module (i.e. require(./sendEmail.js))
*/
if (require.main !== module) {
  module.exports = main;
}


