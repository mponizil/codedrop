#!/usr/bin/env coffee

http = require 'http'
express = require 'express'
Routes = require './library/routes'
Storage = require './library/storage'
drop = require './library/drop'
argv = require('optimist')
  .default
    h: process.env.HOST or '0.0.0.0',
    p: process.env.PORT or 8000
    mainHost: 'codedrop.dev'
    user: undefined
    password: undefined
  .alias('h', 'host').alias('p', 'port').argv

fullMainHost = argv.mainHost
fullMainHost += ":#{argv.port}" unless argv.port is 80

drops = new Storage
  mainHost: argv.mainHost
  fullMainHost: fullMainHost
  fileName: 'db.json'
routes = new Routes
  mainHost: argv.mainHost
  fullMainHost: fullMainHost
  drops: drops

server = express()
main = express()

# Use basic auth if username and password provided
if argv.user? and argv.password?
  console.log "Using basic auth with username: '#{argv.user}' and password: '#{argv.password}'"
  main.use(express.basicAuth(argv.user, argv.password))

server.use(express.vhost(argv.mainHost, main))
server.all('*', routes.dropCode)

main.use(express.bodyParser())
main.use('/public', express.static("#{ __dirname }/public"))

main.set('view engine', 'ejs')

main.get('/', routes.index)
main.get('/drops', routes.getDrops)
main.post('/drops', routes.createDrop)
main.put('/drops', routes.createDrop)
main.delete('/drops/:id', routes.deleteDrop)

server.listen(argv.port, argv.host)
console.log "listening on #{ argv.host }:#{ argv.port }"
