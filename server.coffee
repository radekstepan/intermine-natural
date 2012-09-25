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

app.router.path "/api/ask", ->
    @get ->
        prolog.suggest @req.query.q, (answer) =>
            answers = []
            
            # Do we have an answer?
            if answer?
                # Split on pipe character.
                for answer in answer.split(' | ')

                    # Capture all but answer wrapper regex.
                    match = /q\(\[(.*)\]\)/
                    # Remove wrapper and split into nodes.
                    nodes = match.exec(answer)[1].split(', ')

                    # Resolve classes into Classes and their fields.
                    model = {}

                    i = 0 ; previous = null
                    while i < nodes.length
                        # Fetch this object.
                        obj = nodes[i]

                        # Resolve the object.
                        [ type, value ] = modelTextToType obj
                        
                        switch type
                            # Is this a class?
                            when 'class'
                                # Resolve to Model.
                                clazz = modelSerializeClass value
                                # Do we have a previous object up the tree?
                                if previous? and previous.references?
                                    # Find the reference to us.
                                    for k in Object.keys previous.references
                                        if k is value
                                            # Refer to us.
                                            previous.references[value] = clazz
                                else
                                    # Make this the starting class of the answer adding the Prolog response.
                                    clazz.prolog = nodes.join(', ')
                                    model = clazz

                                # This was the previous class.
                                previous = clazz

                            # Make attribute "selected".
                            when 'attribute'
                                # Do we have a previous object up the tree?
                                if previous? and previous.attributes?
                                    # Find the reference to us.
                                    for k in Object.keys previous.attributes
                                        if k is value
                                            # Say we are selected.
                                            previous.attributes[value].selected = true
                        
                            # A Reference needs to be resolved to a class and "selected" as a whole.
                            when 'reference'
                                # Resolve to Model.
                                clazz = modelSerializeClass value
                                # Say we are selected.
                                clazz.selected = true
                                # Do we have a previous object up the tree?
                                if previous? and previous.references?
                                    # Find the reference to us.
                                    for k in Object.keys previous.references
                                        if k is value
                                            # Refer to us.
                                            previous.references[value] = clazz

                        i++

                    answers.push model

            @res.writeHead 200, 'application/json'
            @res.write JSON.stringify 'answers': answers

            @res.end()

# Resolve answer text into the model.
modelTextToType = (text) ->
    # A class?
    if text.match new RegExp /\(Class\)$/
        [ 'class', text[0...-8] ]
    # An attribute?
    else if text.match new RegExp /\(Attribute\)$/
        [ 'attribute', text[0...-12] ]
    # A reference?
    else if text.match new RegExp /\(Reference\)$/
        [ 'reference', text[0...-12] ]

# Serialize class type in a model.
modelSerializeClass = (clazz) ->
    # Uppercase so we can get the Type.
    clazz = clazz.charAt(0).toUpperCase() + clazz.slice(1)

    # In.
    obj = config.model.classes[clazz]

    # Out.
    result = { 'class': clazz }
    # All possible references.
    for attr in [ 'attributes', 'references', 'collections' ]
        # Traverse all attrs.
        for key, value of obj[attr]
            # Classify.
            if attr isnt 'attributes'
                result['references'] ?= {} # only when needed
                result['references'][key.charAt(0).toLowerCase() + key.slice(1)] = {}
            else
                result['attributes'] ?= {} # only when needed
                result['attributes'][key] = {}

    result