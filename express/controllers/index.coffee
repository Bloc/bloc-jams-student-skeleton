

exports.collection = (title) ->
  (req, res) ->
    res.render 'album_collection', {title: title}

exports.error = (title, errnum) ->
  (req, res, next) ->
    res.render errnum, {title: title, errnum: errnum}, (err, html) ->
      return next err if err
      res.send errnum, html

exports.test = (title) ->
  (req, res) ->
    res.render 'test', {title: title}

exports.album = (title) ->
  (req, res) ->
    res.render 'album', {title: title}

exports.landing = (title) ->
  (req, res) ->
    res.render 'landing', {title: title}

exports.user = (title) ->
  (req, res) ->
    res.render 'user', {title: title}

exports.practice = (title) ->
  (req, res) ->
    res.render 'practice', {title: title}
