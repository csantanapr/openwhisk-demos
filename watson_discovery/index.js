var DiscoveryV1 = require('watson-developer-cloud/discovery/v1');
var discovery = null;


function main (args){
  if(!discovery){
    discovery = new DiscoveryV1({
      username: args.username,
      password: args.password,
      version_date: DiscoveryV1.VERSION_DATE_2017_08_01
    });
  }
  
  return new Promise((resolve, reject)=>{
    discovery.query({
      environment_id: 'system',
      collection_id: 'news',
      aggregation: 'nested(enriched_text.entities).filter(enriched_text.entities.type::Company).filter(enriched_text.entities.sentiment.score>=0.8).term(enriched_text.entities.text)'
    }, function(err, response) {
          if (err) {
            console.error(err);
            reject(err)
          } else {
            console.log(JSON.stringify(response, null, 2));
            resolve(response)
          }
     });
  });

  
}
global.main = main;