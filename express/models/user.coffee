
console.log("user.coffee")
mongoose = require('mongoose')
_ = require('underscore')

userSchema = new mongoose.Schema({
  name: String,
  role: String
})

_(userSchema.methods).extend({
  validPassword: (password) ->
    # TODO: make this actually validate.
    return true

  updateUser: (user) ->
    return false
})


user = mongoose.model('user', userSchema)
