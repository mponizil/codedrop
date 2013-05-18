http = require 'http'
express = require 'express'
httpProxy = require 'http-proxy'
ip = require './ip'

host = process.env.HOST or '0.0.0.0'
port = process.env.PORT or 8000

# Test server to see if stuff is working ...
testServer = http.createServer (req, res) ->
  res.writeHead(200, 'Content-Type': 'text/plain')
  res.write('request successfully proxied!' + '\n' + JSON.stringify(req.headers, true, 2))
  res.end()
testServer.listen(9000)


# Proxy magic ...
proxy = new httpProxy.RoutingProxy
server = express()
server.use(express.bodyParser())
server.use(express.cookieParser())

server.all /^\/proxy\/(.*)|.*/, (req, res) ->

  console.log "incoming: #{ req.url }"

  if host = req.params[0]

    console.log "setting cookie host to #{ host }"
    res.cookie('host', host)

    res.send """
      now add this to your hosts file:<br />
      #{ ip.addresses[0] } #{ host }"""

  else

    host = req.headers.host

    proxy.proxyRequest req, res,
      host: host
      port: 80

server.listen(port, host)
