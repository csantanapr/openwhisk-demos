function main(params) {
  console.log(params);
  if(params.IBM){
    console.log("typeof params.IBM="+typeof params.IBM);
    console.log("Woot ! IBM = "+params.IBM);
  }
  return params || {};
}