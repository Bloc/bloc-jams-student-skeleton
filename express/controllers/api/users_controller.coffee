
_ = require('underscore')
User = require('../../models')('user')

bogusUser = {
  name: "John Doe",
  email: "john@example.com",
  city: "Boise",
  state: "Idaho",
  country: "USA",
  id: "BOGUS_ID"
}

module.exports = {
  update: (req, res) ->
    if req.params.id == "BOGUS_ID"
      bogusUser = _.clone(req.body.user)
      console.log(bogusUser)
      res.json()
    else if !(req.body.user?.id?)
      res.json(406, {error: "Malformed request. User data with id is missing from request."})
    else
      res.json(403, {error:"Permission Denied"})

    #User.findOne({_id: req.params.id}).exec((err, user) ->
    #  console.log("id passed: " + req.params.id)
    #  console.log("user: ")
    #  console.log(user)
    #  res.json({})
    #)

  show: (req, res) ->
    id = req.params.id
    User.findById(id, (err, user) ->
      res.json(user[0])
    )

  currentUser: (req, res) ->
    res.json(bogusUser)

    #User.findOne({role: 'dummyUser'}, (err, user) ->
    #  if user
    #    res.json(user)
    #  else if !err?
    #    console.log("creating dummyuser")
    #    User.create({role: 'dummyUser'})
    #        .then((err, user) ->
    #          res.json(user)
    #        )
    #)

  password: (req, res) ->
    if req.params.id != "BOGUS_ID"
      res.json(403, {error: "Permission Denied"})

    passwordForm = req.body.password
    if passwordForm?
      if passwordForm.password == passwordForm.confirmation
        res.json()
      else
        res.json(406, { msg:"Passwords mismatched"})
    else
      res.json(406, { msg:"password data not sent correctly"})




}

