http = require 'http'
express = require 'express'
routes = require './lib/routes'

listenHost = process.env.HOST or '0.0.0.0'
listenPort = process.env.PORT or 8000

server = express()

server.use(express.bodyParser())
server.use(express.cookieParser())
server.use('/public', express.static("#{ __dirname }/public"))

server.set('view engine', 'ejs')

server.get('/', routes.index)
server.all('*', routes.seshRequest)

server.listen(listenPort, listenHost)
console.log "listening on #{ listenHost }:#{ listenPort }"
