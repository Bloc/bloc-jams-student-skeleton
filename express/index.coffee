express = require 'express'
{join} = require 'path'
{config} = require './config'
controllers = require './controllers'

app = express()

app.configure 'production', ->
  app.use express.limit '5mb'

app.configure ->
  app.set 'views', join __dirname, 'views'
  app.set 'view engine', config.view.engine
  app.use express.favicon()
  app.use express.logger 'dev'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.compress()
  app.use express.cookieParser(config.cookie.secret)
  app.use express.session()
  app.use express.csrf()
  app.use app.router
  app.use express.static join __dirname, '..', 'public'

app.configure 'development', ->
  app.use express.errorHandler()
  app.locals.pretty = true

app.get '/', controllers.landing()
app.get '/collection', controllers.collection()
app.get '/album', controllers.album('Album View')
app.get '/test', controllers.test('Mocha Tests')
app.get '/user', controllers.user('User')
app.get '/practice', controllers.practice('Practice your HTML')

### Default 404 middleware ###
app.use controllers.error('Page not found :(', 404)

module.exports = exports = app
