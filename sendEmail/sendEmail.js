// jshint esversion: 6
/*
 sendEmail
*/
var nodemailer = require('nodemailer');
function main({
  username: username,
  password: password,
  smtp: smtp='smtp.gmail.com',
  from: from,
  to: to,
  subject: subject,
  text: text,
  html: html
}) {

  const url = `smtps://${username}:${password}@${smtp}`;
  const transporter = nodemailer.createTransport(url);
  
  function sendEmail(resolve, reject){
    transporter.sendMail(
    {
      from: from,
      to: to,
      subject: subject,
      text: text,
      html: html
    },(error, info) => {
        if (error) {
          console.error(`error sending email ${error}`);
          reject(JSON.stringify(error));
        } else {
          console.log(`Message sent:  ${info.response}`);
          resolve({ info: info });
        }
    });
  }
  return new Promise(sendEmail);
}

/*
Only required for testing locally, running in OpenWhisk this get's ignored
Export main function only if its being use as a module (i.e. require(./sendEmail.js))
*/
if(require.main !== module){
  module.exports = main;
}


