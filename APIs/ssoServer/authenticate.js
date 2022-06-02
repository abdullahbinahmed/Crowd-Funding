// var util = require('util')
//     , OAuth2Strategy = require('passport-oauth').OAuth2Strategy
//     , InternalOAuthError = require('passport-oauth').InternalOAuthError;

// const e = require('express');
// const { query } = require('express');
const passport = require('passport');
const options = require('./config/OAuthConfig');
var ExtractJwt = require('passport-jwt').ExtractJwt;
var JwtStrategy = require('passport-jwt').Strategy;
var jwt = require('jsonwebtoken');
var config = require('./config/config');
var GoogleStrategy = require("passport-google-oauth2").Strategy;
var userDB = require('./db');

// passport.serializeUser(userDB.serializeUser());
// passport.deserializeUser(User.deserializeUser());

exports.getToken = function(user) {
    return jwt.sign(user, config.secretKey,
        {expiresIn: 2628288});
}

var opts = {};
opts.jwtFromRequest = ExtractJwt.fromAuthHeaderAsBearerToken();
opts.secretOrKey = config.secretKey;

module.exports = (jwtPassport) = passport.use(new JwtStrategy(opts,
    (jwt_payload, done) => {
            console.log("JWT payload: ", jwt_payload);
            User.findOne({_id: jwt_payload._id}, (err, user) => {
               if (err) {
                   return done(err, false);
               }
               else if (user) {
                   return done(null, user);
               }
               else {
                   return done(null, false);
               }
            });
    }));
module.exports = (googlePassport) = passport.use(new GoogleStrategy({
    clientID: options.clientId,
    clientSecret: options.clientSecret,
    callbackURL: options.signUpURL,
    passReqToCallback : false
},
    async function (accessToken, refreshToken, profile, done) {
        try{
            console.log('In google strategy function');
            console.log(JSON.stringify(profile));
            var existingUser = await userDB.where('emailId', '==', profile.email).get();
            console.log('Read the records successfully');
            console.log(existingUser.empty);
            if(!existingUser.empty) {
                console.log('User exists');  
                return done(null, existingUser);
            }
            else {
                console.log('Creating new user...');
                var newUser = userDB.add({
                    googleId: profile.id,
                    emailId: profile.email,
                    name: profile.displayName
                });
                console.log('Have written to db successfully');
                return done(null, newUser);
            }      
        }
        catch(error) {
            console.log("error:" + error);
        }
    }
));
module.exports = (verifyUser) = passport.authenticate('jwt', {session: false});
module.exports = (verifyAdmin) = (req, res, next) => {
    if (!req.user.admin) {
        err = new Error('You are not authorized to perform this operation!');
        err.status = 403;
        return next(err);
    }
    else {
        return next();
    }
}


// function GoogleTokenStrategy(options, verify) {
//     OAuth2Strategy.call(this, options, verify);
//     this.name = 'google-token';
// }

// util.inherits(GoogleTokenStrategy, OAuth2Strategy);

// GoogleTokenStrategy.prototype.authenticate = function(req, options) {
//     options = options || {};
//     var self = this;
  
//     if (req.query && req.query.error) {
//       // TODO: Error information pertaining to OAuth 2.0 flows is encoded in the
//       //       query parameters, and should be propagated to the application.
//       return this.fail();
//     }
  
//     if (!req.body) {
//       return this.fail();
//     }
  
//     var accessToken = req.body.access_token || req.query.access_token || req.headers.access_token;
//     var refreshToken = req.body.refresh_token || req.query.refresh_token || req.headers.refresh_token;
  
//     self._loadUserProfile(accessToken, function(err, profile) {
//       if (err) { return self.fail(err); };
  
//       function verified(err, user, info) {
//         if (err) { return self.error(err); }
//         if (!user) { return self.fail(info); }
//         self.success(user, info);
//       }
  
//       if (self._passReqToCallback) {
//         self._verify(req, accessToken, refreshToken, profile, verified);
//       } else {
//         self._verify(accessToken, refreshToken, profile, verified);
//       }
//     });
//   }


// GoogleTokenStrategy.prototype.userProfile = function(accessToken, done) {
// this._oauth2.get('https://www.googleapis.com/oauth2/v1/userinfo', accessToken, function (err, body, res) {
//   if (err) { return done(new InternalOAuthError('failed to fetch user profile', err)); }

//   try {
//     var json = JSON.parse(body);

//     var profile = { provider: 'google' };
//     profile.id = json.id;
//     profile.displayName = json.name;
//     profile.name = { familyName: json.family_name,
//                      givenName: json.given_name };
//     profile.emails = [{ value: json.email }];

//     profile._raw = body;
//     profile._json = json;

//     done(null, profile);
//   } catch(e) {
//     done(e);
//   }
// });
// }


// GoogleTokenStrategy.prototype._loadUserProfile = function(accessToken, done) {
// var self = this;

// function loadIt() {
//   return self.userProfile(accessToken, done);
// }
// function skipIt() {
//   return done(null);
// }

// if (typeof this._skipUserProfile == 'function' && this._skipUserProfile.length > 1) {
//   // async
//   this._skipUserProfile(accessToken, function(err, skip) {
//     if (err) { return done(err); }
//     if (!skip) { return loadIt(); }
//     return skipIt();
//   });
// } else {
//   var skip = (typeof this._skipUserProfile == 'function') ? this._skipUserProfile() : this._skipUserProfile;
//   if (!skip) { return loadIt(); }
//   return skipIt();
// }
// }


// module.exports = GoogleTokenStrategy;