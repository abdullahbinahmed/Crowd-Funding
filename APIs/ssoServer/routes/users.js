var express = require('express');
const bodyParser = require('body-parser');
var passport = require('passport');
var authenticate = require('../authenticate');
var userDB = require('../db');

var router = express.Router();

router.use(bodyParser.json());

/* GET users listing. */
router.get('/auth/google', 
  passport.authenticate('google', { scope : ['profile', 'email'] }),
  (req, res) => {
    console.log("In /auth/google");
  });
 
router.get('/auth/google/callback',
authenticate.verifyGoogle,
  function(req, res) {
    console.log("In /auth/google/callback");
    var token = authenticate.getToken({_id: req.user.email[0]});
    var statusMessage = 'Logged in!';
    var status = true;
    console.log("Welcome", req.user);
    if (!res.isExists) {
      statusMessage = 'You need to sign up!';
       status = false;
    }
    res.statusCode = 200;
    res.setHeader('Content-Type', 'application/json');
    res.json({success: status,token: token , status: statusMessage, email:req.user.email});

  });
 router.post('/signup', async (req, res) => {
     console.log(req.body );
     await userDB.add({
         emailId: req.body.email,
         FirstName: req.body.firstName,
         LastName: req.body.lastName,
         PhoneNumber: req.body.phone,
         Address: req.body.address,
         City: req.body.city,
         PostalCode: req.body.postCode,
         Country: req.body.country,
         Zone: req.body.zone,
         Company: req.body.company,
         BankAccountNumber: req.body.bankAccountNumber,
         BankName: req.body.bankName,
         Role: req.body.role,
         CNICNumber: req.body.cnic
     });
     res.setHeader('Content-Type', 'text/plain'),
         res.statusCode = 200;
     res.end('Data written in db');
 });

module.exports = router;