passport = require('passport')
LocalStrategy = require('passport-local').Strategy
User = require('../models')('user')

passport.serializeUser((user, done) ->
  done(null, user.id)
)
passport.deserializeUser((id, done) ->
  User.findOne({ id: id }, (err, user) ->
    return done(err) if err
    done(null, user)
  )
)

passport.use(new LocalStrategy(
  (username, password, done) ->
    User.findOne({}, (err, user) ->
      return done(null, user)
    )

    #User.findOne({ username: username }, (err, user) ->
    #  return done(err) if err

    #  console.log(user)
    #  unless user && user.validPassword(password)
    #    return done(null, false)

    #  return done(null, user)
    #)
))
