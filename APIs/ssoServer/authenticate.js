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

module.exports.jwtPassport = passport.use(new JwtStrategy(opts, async function (jwt_payload, done) {
            var existingUser = await userDB.where('emailId', '==', jwt_payload._id.toString()).get();
            var abc;
            if(!existingUser.empty) {
                return done(null, existingUser);
            } else {
                error = new Error('User is not authorized');
                return done(error, false);
            }
    }));
module.exports.googlePassport = passport.use(new GoogleStrategy({
    clientID: options.clientId,
    clientSecret: options.clientSecret,
    callbackURL: options.callbackURL,
    passReqToCallback : false
},
    async function (accessToken, refreshToken, profile, done) {
        try{
            var existingUser = await userDB.where('emailId', '==', profile.email).get();
            profile.isExists = false;
            profile.user = null;
            if(!existingUser.empty) {
                profile.isExists = true;
                profile.existingUser = existingUser.docs[0].data();
                return done(null, profile);
            }
            else {
                return done(null, profile);
            }      
        }
        catch(error) {
            return(error);
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