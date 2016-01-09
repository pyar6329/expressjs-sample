passport = require 'passport'
LocalStrategy = require('passport-local').Strategy
Authentication = require '../app/helpers/authentication'
User = require '../app/models/user'

class Passport

  passport.use 'local-signin', new LocalStrategy {
    usernameField: 'email'
    passwordField: 'password'
    # failureFlash: true
  }, (email, password, done) ->
    auth = new Authentication {
      email: email
      password: password
    }
    auth.sign_in(done)

  passport.serializeUser (user, done) ->
    done null, user._id

  passport.deserializeUser (_id, done) ->
    User.findOne {_id: _id}, (err, user) ->
      done err, user

module.export = Passport
