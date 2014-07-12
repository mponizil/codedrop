#!/usr/bin/env coffee

http = require 'http'
express = require 'express'
Routes = require './lib/routes'
Storage = require './lib/storage'
drop = require './lib/drop'
argv = require('optimist')
  .default
    h: process.env.HOST or '0.0.0.0',
    p: process.env.PORT or 8000
    hostname: 'codedrop.dev'
    user: undefined
    password: undefined
  .alias('h', 'host').alias('p', 'port').argv

drops = new Storage
  domain: argv.hostname
  fileName: 'db.json'
routes = new Routes
  drops: drops
  domain: argv.hostname

server = express()
main = express()

# Use basic auth if username and password provided
if argv.user? and argv.password?
  console.log "Using basic auth with username: '#{argv.user}' and password: '#{argv.password}'"
  main.use(express.basicAuth(argv.user, argv.password))

server.use(express.vhost(argv.hostname, main))
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
