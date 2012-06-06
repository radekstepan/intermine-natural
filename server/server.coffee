fs      = require 'fs'
http    = require 'http'
eco     = require 'eco'
colors  = require 'colors'
mime    = require 'mime'

# Eco template rendering.
render = (res, path, data={}) ->
    fs.readFile "./server/templates/#{path}.eco", "utf8", (err, template) ->
        if err then throw err

        out = eco.render template, data
        res.writeHead 200,
            'Content-Type':  'text/html'
            'Content-Length': out.length
        res.write out
        res.end()

server = http.createServer (req, res) ->

    console.log "#{req.method} #{req.url}".grey

    switch req.url
        when '/'
            render res, 'index'
        else
            fs.readFile "./server#{req.url}", "utf8", (err, resource) ->
                if not err
                    res.writeHead 200,
                        'Content-Type':   mime.lookup "./server#{req.url}"
                        'Content-Length': resource.length
                    res.write resource
                    res.end()
                else
                    console.log "#{req.url} not found".red

server.listen 1115
console.log "Listening on port 1115".green.bold