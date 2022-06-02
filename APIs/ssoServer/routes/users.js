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
    var token = authenticate.getToken({_id: req.user._id});
    res.statsCode = 200;
    res.setHeader('Content-Type', 'application/json');
    res.json({
      success: true,
      token: token,
      status: 'You are successfully authenticated!'
    });
    console.log('token:', token);
    console.log('Redirecting');
  });
 
router.get('/auth/google/callback',
passport.authenticate('google', { session: false}),
  function(req, res) {
    console.log("In /auth/google/callback");
    // Successful authentication, redirect success.
    
    console.log('Welcome');
    res.redirect('/success');
  });
 // profile route after successful sign in 
 router.get("/success", (req, res) => {
  console.log('Success');
 });
 router.get("/profile", (req, res) => {
  console.log(req);
  res.send("Welcome");
 });

module.exports = router;