mongoose = require('mongoose')
_ = require('underscore')

module.exports = (modelName) ->
  # Hack to deal with 'require' trying to define mongoose.model multiple times
  # for the same collection.
  if (_(mongoose.modelNames()).indexOf(modelName))
    require('./' + modelName)

  mongoose.model(modelName)



