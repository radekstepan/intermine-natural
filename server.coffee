#!/usr/bin/env coffee

flatiron = require 'flatiron'
connect  = require 'connect'

app = flatiron.app
app.use flatiron.plugins.http,
    'before': [
        # Have a nice favicon.
        connect.favicon()
        # Static file serving.
        connect.static './public'
    ]

app.start 1115, (err) ->
    throw err if err
    app.log.info "Listening on port #{app.server.address().port}".green