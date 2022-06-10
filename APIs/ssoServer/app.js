var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
const firestoredb = require('./db');
var usersRouter = require('./routes/users');
const passport = require('passport');


//   const userCol = firestoredb.collection('users');
//   const usersDocument = firestoredb.collection('users').doc('HwX0rlZotsvfojhEIZWB');
//   var userSnapshot = usersDocument.get();
//   if (!userSnapshot) {
//     console.log('No document');
//   }
//   else {
//     firestoredb.collection("users").get().then((querySnapshot) => {
//       querySnapshot.forEach((doc) => {

//           console.log(`${doc.id} => ${doc.data().name},${doc.data().lastname} `);
//       });
  
//   });
// }
// userCol.doc('abc')
// .set({
//   firstname: 'abc',
//   lastname: 'def',
//   comment: "test"
// });
// userCol.add({
//   firstname: 'test',
//   lastname: 'test',
//   comment: "updated test"
// });


var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

app.use(passport.initialize());

app.use(express.static(path.join(__dirname, 'public')));

app.use('/', usersRouter);
passport.serializeUser(function(user, cb) {
  cb(null, user);
});

passport.deserializeUser(function(obj, cb) {
  cb(null, obj);
});

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
