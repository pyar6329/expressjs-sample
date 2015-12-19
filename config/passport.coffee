passport = require 'passport'
LocalStrategy = require('passport-local').Strategy

passport.serializeUser (user, done) ->
  console.log user
  done null, user.id

passport.deserializeUser (id, done) ->
  User.findById id, (err, user) ->
  done err, user

Account = require '../app/models/users'
passport.use new LocalStrategy(Account.authenticate())
