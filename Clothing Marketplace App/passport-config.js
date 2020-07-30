const LocalStrategy = require('passport-local').Strategy;
const bcrypt = require('bcrypt');

var mongoose = require('mongoose');
var Seller = require('./models/Seller.js');

function initialize(passport) {
  const authenticateUser = async (username, password, done) => {
    var user;
    await Seller.findOne({username: username}, (err, val) => {
      if (err) {
        return done(err);
      } else {
        console.log(val);
        user = val;
        console.log(user);
      }
    });
    console.log("username:" + username);

    // if user is not found with that username
    if (!user) {
      console.log("no username found");
      // there is no error on server -> null, no user found -> false, error message
      return done(null, false, {message: "No user with that username"});
    }
    console.log("user.username:" + user.username);

    // if user is found
    try {
      // if password is correct
      console.log("password:" + password);
      console.log("password in db:" + user.password);
      if (await bcrypt.compare(password, user.password)) {
        return done(null, user);
      } else {
        return done(null, false, {message: "Password is incorrect"});
      }
    } catch (e) {
      // return error on server
      return done(e);
    }
  }
  passport.use(new LocalStrategy({usernameField: 'username'},
    authenticateUser));
  // get user, no error
  passport.serializeUser((user, done) => done(null, user.id));
  // get user
  passport.deserializeUser((id, done) => {
    return Seller.findById(id, function(err, user) {
      done(err, user);
    });
  });
};

module.exports = initialize;
