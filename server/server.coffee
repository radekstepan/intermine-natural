fs      = require 'fs'
http    = require 'http'
util    = require 'util'
eco     = require 'eco'
colors  = require 'colors'
mime    = require 'mime'
less    = require 'less'

# Eco template rendering.
render = (request, response, path, data={}) ->
    console.log "#{request.method} #{request.url}".bold

    fs.readFile "./server/templates/#{path}.eco", "utf8", (err, template) ->
        throw err if err

        resource = eco.render template, data
        response.writeHead 200,
            'Content-Type':  'text/html'
            'Content-Length': resource.length
        response.write resource
        response.end()

# LESS CSS rendering.
css = (request, response, path) ->
    fs.readFile path, "utf8", (err, f) ->
        throw err if err

        less.render f, (err, resource) ->
            throw err.message if err

            # Info header about the source.
            t = resource.split("\n") ; t.splice(0, 0, "/* #{path} */\n") ; resource = t.join("\n")

            response.writeHead 200,
                'Content-Type':  'text/css'
                'Content-Length': resource.length
            response.write resource
            response.end()

server = http.createServer (request, response) ->

    switch request.url
        when '/natural'
            render request, response, 'natural'
        when '/apper'
            render request, response, 'apper'
        when '/cargo'
            render request, response, 'cargo'
        when '/cargo/alt'
            render request, response, 'cargo-alt'
        else
            # Public resource?
            console.log "#{request.method} #{request.url}".grey

            file = "./server#{request.url}"
            # LESS?
            if file[-9...] is '.less.css'
                css request, response, file.replace('.less.css', '.less')
            else
                fs.stat file, (err, stat) ->
                    if err
                        # 404.
                        console.log "#{request.url} not found".red
                        response.writeHead 404
                        response.end()
                    else
                        # Stream file.
                        response.writeHead 200,
                            "Content-Type":   mime.lookup file
                            "Content-Length": stat.size

                        util.pump fs.createReadStream(file), response, (err) ->
                            throw err if err

server.listen 1115
console.log "Listening on port 1115".green.bold