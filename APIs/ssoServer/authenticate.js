const passport = require('passport');
const options = require('./config/OAuthConfig');
var ExtractJwt = require('passport-jwt').ExtractJwt;
var JwtStrategy = require('passport-jwt').Strategy;
var jwt = require('jsonwebtoken');
var config = require('./config/config');
var GoogleStrategy = require("passport-google-oauth2").Strategy;
var userDB = require('./db');

module.exports.getToken = function(user) {
    return jwt.sign(user, config.secretKey,
        {expiresIn: 2628288});
}

var opts = {};
opts.jwtFromRequest = ExtractJwt.fromAuthHeaderAsBearerToken();
opts.secretOrKey = config.secretKey;

module.exports.jwtPassport = passport.use(new JwtStrategy(opts,
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
module.exports.googlePassport = passport.use(new GoogleStrategy({
    clientID: options.clientId,
    clientSecret: options.clientSecret,
    callbackURL: options.callbackURL,
    passReqToCallback : false
},
    async function (accessToken, refreshToken, profile, done) {
        try{
            console.log('In google strategy function');
            console.log(JSON.stringify(profile));
            var existingUser = await userDB.where('emailId', '==', profile.email).get();
            console.log('Read the records successfully');
            profile.isExists = false;
            console.log(existingUser.empty);
            if(!existingUser.empty) {
                console.log('User exists');
                profile.isExists = true;
                return done(null, profile);
            }
            else {
                console.log('Creating new user...');
                console.log('Have written to db successfully');
                return done(null, profile);
            }      
        }
        catch(error) {
            console.log("error:" + error);
        }
    }
));
module.exports.verifyUser = passport.authenticate('jwt', {session: false});
module.exports.verifyAdmin = (req, res, next) => {
    if (!req.user.admin) {
        err = new Error('You are not authorized to perform this operation!');
        err.status = 403;
        return next(err);
    }
    else {
        return next();
    }
}
module.exports.verifyGoogle = passport.authenticate('google', { session: false});