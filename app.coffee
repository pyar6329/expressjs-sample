express = require('express')
path = require('path')
favicon = require('serve-favicon')
logger = require('morgan')
cookieParser = require('cookie-parser')
bodyParser = require('body-parser')
app = express()
ECT = require('ect')
ectRenderer = ECT(
  watch: true
  root: __dirname + '/app/views'
  ext: '.ect')

app.set 'views', path.join(process.cwd(), 'app', 'views')
# view engine setup
#app.set 'views', path.join(__dirname, 'views')
#app.set 'view engine', 'ejs'
app.set 'view engine', 'ect'
app.engine 'ect', ectRenderer.render

# uncomment after placing your favicon in /public
#app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use logger('dev')
app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: false)
app.use cookieParser()
# app.use require('node-sass-middleware')(
#   src: path.join(__dirname, 'public')
#   dest: path.join(__dirname, 'public')
#   indentedSyntax: true
#   sourceMap: true)

# mongodb settings
# mongoose = require('mongoose')
# mongoose.connect process.env.MONGOLAB_URI

# passport
# app.use express.session({secret: 'foo'})
session = require('express-session')
app.use session(
  secret: 'secrethogehoge'
  resave: false
  saveUninitialized: false)
  # cookie: maxAge: 30 * 60 * 1000)
  # resave: false
  # saveUninitialized: false

passport = require('passport')
app.use passport.initialize()
app.use passport.session()

# Account = require('./models/account')
# passport.use new LocalStrategy(
#   Account.authenticate())
# passport.serializeUser Account.serializeUser()
# passport.deserializeUser Account.deserializeUser()
# passport.serializeUser (user, done) ->
#   console.log user
#   done null, user.id
#
# passport.deserializeUser (id, done) ->
#   User.findById id, (err, user) ->
#   done err, user

# load routes settings
controllers = require('./app/controllers/index')
users = require('./app/controllers/users')
# api_users = require('./app/controllers/api/v1/users')
# express = require('express')
# app = express()
# path = require('path')

app.use '/static', express.static(path.join(__dirname, 'build'))
# app.use express.static(path.join(__dirname, 'public'))
app.use '/', controllers
# app.use '/', require('./app/controllers/index')
app.use '/users', users
# app.use '/users', require('./app/controllers/users')
# app.use '/api/v1/users', api_users

# require('./config/routes')(app, express)

# catch 404 and forward to error handler
app.use (req, res, next) ->
  err = new Error('Not Found')
  err.status = 404
  next err
  return

# error handlers
# development error handler
# will print stacktrace
if app.get('env') == 'development'
  app.use (err, req, res, next) ->
    res.status err.status or 500
    res.render 'error',
      message: err.message
      error: err
    return

# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next) ->
  res.status err.status or 500
  res.render 'error',
    message: err.message
    error: {}
  return
module.exports = app
