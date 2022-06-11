var express = require('express');
const bodyParser = require('body-parser');
var passport = require('passport');
var authenticate = require('../authenticate');
var userDB = require('../db');
const {auth} = require("firebase-admin");

var router = express.Router();

router.use(bodyParser.json());

/* GET users listing. */
router.get('/auth/google', 
  passport.authenticate('google', { scope : ['profile', 'email'] }),
  (req, res) => {
  });
 
router.get('/auth/google/callback',
authenticate.verifyGoogle,
  function(req, res) {
    var token = null;
    var statusMessage = 'You need to sign up!';
    var status = false;
    var user = null;
    if (req.user.isExists) {
      statusMessage = 'Logged in!';
       status = true;
       user = req.user.existingUser;
       var token = authenticate.getToken({_id: req.user.email});
    }
    res.statusCode = 200;
    res.setHeader('Content-Type', 'application/json');
    res.json({success: status, token: token, status: statusMessage,user: user, email: req.user.email, firstname: req.user.given_name, lastname: req.user.family_name});

  });
 router.post('/signup',async (req, res) => {
     var user = await userDB.add({
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
         CNICNumber: req.body.cnic,
         BankCode: req.body.bankCode
     });
     var token = authenticate.getToken({_id: req.body.emailId});
     var statusMessage = 'You have successfully signed up!';
     var status = true;
     success = true;
     res.setHeader('Content-Type', 'text/plain');
     res.statusCode = 200;
     if(!user) {
         res.statusCode =  400;
         user = null;
         success = false;
         var statusMessage = 'You need to sign up!';
         token = null;
     }
     res.json({status: success, token: token, status: statusMessage, email:req.body.emailId, user: req.body});
 });
 router.get('/validate', authenticate.verifyUser, (req, res) => {
    res.statusCode = 200;
    verified = true;
    res.json({authenticated: verified});
 });
router.get('/users/:userId', authenticate.verifyUser, async (req, res) => {
    res.statusCode = 200;
    var existingUser = await userDB.where('emailId', '==', req.params.userId).get();
    res.json({user: existingUser.docs[0].data()});
});
module.exports = router;