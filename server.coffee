app = require('./pallur/server.coffee').app

app.router.get "/", (request, response) ->
    app.render response, 'index'

app.start()