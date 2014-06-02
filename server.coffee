BrunchServer = require './lib/server'
{config} = require './config'
mongoose = require('mongoose')


module.exports.startServer = (port, path, callback) ->

    # Configure the database connection
    #  TODO: Comment this back in once mongoose support is back.
    #db = mongoose.connect('mongodb://localhost/test').connection
    #db.on('error', console.error.bind(console, 'connection error:'))
    #db.once('open', ->
    #    console.log("successfully opened mongodb connection with mongoose.")
    #)

    # Configure and start the server.
    port = process.env.PORT || port
    bsvr = new BrunchServer(config)
    io = require('socket.io').listen bsvr.server, logger: bsvr.logger
    io.set 'log level', 2
    sockets = require('./express/sockets')(io)

    bsvr.on 'reload', ->
        sockets.emit '/brunch/reload', 1000
        sockets.destroy()
        sockets = require('./express/sockets')(io)

    bsvr.start(port, callback)
    bsvr
