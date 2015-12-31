express = require 'express'
router = express.Router()

passport = require 'passport'
request = require 'request'
User = require '../models/user'

Authentication = require '../helpers/authentication'

### GET users listing. ###

# GET: /users/
router.get '/', (req, res, next) ->
  res.send 'respond with a resource'
  return

# GET: /users/success
router.get '/success', (req, res, next) ->
  res.send 'login success'
  return

# GET: /users/failed
router.get '/failed', (req, res, next) ->
  res.send '' + req.flash('error')
  return

# GET: /users/sign_in
# router.get '/sign_in', (req, res, next) ->
#   auth = new Authentication(
#     'pyar6329@gmail.com'
#     'qwixYXU8v8NzGUzjqBcapHsEUVimEcEYrpLWmYExT8tQEN9XBP'
#   )
#   auth.sign_in()
#   res.render 'login'

# GET: /users/login
router.get '/login', (req, res, next) ->
  res.render 'login'

# POST: /users/login
router.post '/login',
  passport.authenticate('local',{
    successRedirect: '/users/success'
    failureRedirect: '/users/failed'
    failureFlash: true
  }), (req, res) ->

module.exports = router
