#!/usr/bin/env coffee

flatiron = require 'flatiron'
connect  = require 'connect'
request  = require 'request'
fs       = require 'fs'

prolog   = require './prolog/prolog.coffee'

# Read the config file.
config = JSON.parse fs.readFileSync './config.json'

# Write the model into Prolog rules representation.
prolog.writeModel config.model.classes

# Start the service.
app = flatiron.app
app.use flatiron.plugins.http,
    'before': [
        # Have a nice favicon.
        connect.favicon()
        # Static file serving.
        connect.static './public'
    ]
    
app.start config.port, (err) ->
    throw err if err
    app.log.info "Listening on port #{app.server.address().port}".green