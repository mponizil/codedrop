http = require 'http'
express = require 'express'
routes = require './lib/routes'

listenHost = process.env.HOST or '0.0.0.0'
listenPort = process.env.PORT or 8000
mainHostname = 'proxysesh.celehner.com'
routes.setDomain(mainHostname)

server = express()
main = express()
server.use(express.vhost(mainHostname, main))
server.all('*', routes.seshRequest)

main.use(express.bodyParser())
main.use('/public', express.static("#{ __dirname }/public"))

main.set('view engine', 'ejs')

main.get('/', routes.index)
main.get('/seshs', routes.getSeshs)
main.post('/seshs', routes.createSesh)
main.all('/seshs/:id', routes.sesh)

server.listen(listenPort, listenHost)
console.log "listening on #{ listenHost }:#{ listenPort }"
