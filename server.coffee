http = require 'http'
express = require 'express'
httpProxy = require 'http-proxy'
ip = require './ip'


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

    if not host = req.cookies.host
      res.cookie('host', host = req.headers.host)

    # Modify the req headers accordingly.
    console.log "setting headers.host to #{ host }"
    req.headers.host = host

    proxy.proxyRequest req, res,
      host: host
      port: 80

server.listen(8000, '0.0.0.0')
