express = require 'express'
routes  = require './routes'
app     = express()

app.get '/', routes.index
app.use express.static(__dirname + '/public')

app.listen 5000
