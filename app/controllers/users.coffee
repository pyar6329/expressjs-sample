express = require 'express'
router = express.Router()

passport = require 'passport'
request = require 'request'

### GET users listing. ###

# router.get '/', (req, res, next) ->
#   res.send 'respond with a resource'
#   return
router.get '/', (req, res, next) ->
  res.send 'respond with a resource'
  return

# GET: /users/sign_in
router.get '/sign_in', (req, res, next) ->
  URL = 'https://ootalkbackend.herokuapp.com/api/v1/auth/sign_in'

  request.post URL, {form:
    email: 'test@example.com'
    password: 'hogehogehugahuga'
  },  (err, httpResponse, body) ->
    res.send body
module.exports = router

# passport.serializeUser(body.data)
