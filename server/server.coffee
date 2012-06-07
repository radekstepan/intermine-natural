fs      = require 'fs'
http    = require 'http'
util    = require 'util'
eco     = require 'eco'
colors  = require 'colors'
mime    = require 'mime'

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

server = http.createServer (request, response) ->

    switch request.url
        when '/'
            render request, response, 'index'
        else
            # Public resource?
            console.log "#{request.method} #{request.url}".grey

            file = "./server#{request.url}"
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