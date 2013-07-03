#!/usr/bin/env coffee

http = require 'http'
express = require 'express'
SeshRoutes = require './lib/routes'
SeshsStorage = require './lib/storage'
sesh = require './lib/sesh'
argv = require('optimist')
    .default({
        h: process.env.HOST or '0.0.0.0',
        p: process.env.PORT or 8000
        user: undefined
        password: undefined
    }).alias('h', 'host').alias('p', 'port').argv

mainHostname = 'proxysesh.celehner.com'

seshs = new SeshsStorage
  domain: mainHostname
  fileName: 'seshstore.json'
routes = new SeshRoutes
  seshs: seshs
  domain: mainHostname

server = express()
main = express()

# Use basic auth if username and password provided
if argv.user? and argv.password?
    console.log "Using basic auth with username: '#{argv.user}' and password: '#{argv.password}'"
    main.use(express.basicAuth(argv.user, argv.password))

server.use(express.vhost(mainHostname, main))
server.all('*', routes.seshRequest)

main.use(express.bodyParser())
main.use('/public', express.static("#{ __dirname }/public"))

main.set('view engine', 'ejs')

main.get('/', routes.index)
main.get('/seshs', routes.getSeshs)
main.post('/seshs', routes.createSesh)
main.put('/seshs', routes.createSesh)
main.delete('/seshs/:id', routes.deleteSesh)

server.listen(argv.port, argv.host)
console.log "listening on #{ argv.host }:#{ argv.port }"
