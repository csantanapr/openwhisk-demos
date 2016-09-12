// jshint esversion: 6
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
  const nodemailer = require('nodemailer');
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
          reject(error);
        } else {
          console.log(`Message sent:  ${info.response}`);
          resolve({ info: info });
        }
    });
  }
  return new Promise(sendEmail);
}

// Test locally
// $ node sendEmail.js
/* 
main({
  username: 'user@gmail.com',
  password: 'xxxxxxxxx',
  from: '"OpenWhisk  📫" <wsk@example.com>',
  to: 'user@gmail.com',
  subject: 'Hello from OpenWhisk ✔',
  text: 'Hello world in text 😹',
  html: '<b>Hello world in html 😹</b>'
});
*/

