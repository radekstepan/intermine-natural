http = require 'http'

server = http.createServer (req, res) ->
    console.log req.method, req.url
    data = 'hi\n'
    res.writeHead 200,
        'Content-Type':     'text/plain'
        'Content-Length':   data.length
    res.end data

server.listen 1115
console.log 