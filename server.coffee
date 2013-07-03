#!/usr/bin/env coffee

http = require 'http'
express = require 'express'
routes = require './lib/routes'
argv = require('optimist')
    .default({
        h: process.env.HOST or '0.0.0.0',
        p: process.env.PORT or 8000
        user: undefined
        password: undefined
    }).alias('h', 'host').alias('p', 'port').argv

server = express()
server.use(express.bodyParser())
server.use(express.cookieParser())

# Use basic auth if username and password provided
if argv.user? and argv.password?
    console.log "Using basic auth with username: '#{argv.user}' and password: '#{argv.password}'"
    server.use(express.basicAuth(argv.user, argv.password))

server.use('/public', express.static("#{ __dirname }/public"))
server.set('view engine', 'ejs')
server.get('/', routes.index)
server.all('*', routes.seshRequest)

server.listen(argv.port, argv.host)
console.log "listening on #{ argv.host }:#{ argv.port }"
