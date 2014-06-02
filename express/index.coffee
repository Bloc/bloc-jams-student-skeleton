require './lib/passport_integration'
passport = require 'passport'
express = require 'express'
{join} = require 'path'
{config} = require './config'
controllers = require './controllers'
#User = require('./models')('user')

app = express()

app.configure 'production', ->
  app.use express.limit '5mb'

app.configure ->
  app.set 'views', join __dirname, 'views'
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use express.logger 'dev'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.compress()
  app.use express.cookieParser(config.cookie.secret)
  app.use express.session({
    secret: "test",
    cookie: {httpOnly: true}
  })
  #app.use(passport.initialize())
  #app.use(passport.session())

  app.use express.csrf()
  app.use((req, res, next) ->
    res.cookie('_csrf', req.csrfToken())
    next()
  )
  app.use app.router
  app.use express.static join __dirname, '..', 'public'

app.configure 'development', ->
  app.use express.errorHandler()
  app.locals.pretty = true


api_users_controller = require('./controllers/api/users_controller')
app.get('/api/users/:id', api_users_controller.show)
app.put('/api/users/:id', api_users_controller.update)
app.put('/api/users/:id/password', api_users_controller.password)
app.get('/api/currentUser', api_users_controller.currentUser)

#app.get('/login', controllers.login)
#app.post('/login',
#  passport.authenticate('local', {
#    failureFlash: true
#  })
#)

app.get(/^[^.]+$/, (req, res) ->
  res.sendfile('./public/index.html')
)

#app.get '/', controllers.landing()
app.get '/collection', controllers.collection()
app.get '/album', controllers.album('Album View')
app.get '/test', controllers.test('Mocha Tests')
app.get '/user', controllers.user('User')
app.get '/practice', controllers.practice('Practice your HTML')

### Default 404 middleware ###
app.use controllers.error('Page not found :(', 404)

module.exports = exports = app
