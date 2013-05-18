http = require 'http'
httpProxy = require 'http-proxy'

proxy = new httpProxy.RoutingProxy

proxyServer = http.createServer (req, res) ->
  proxy.proxyRequest req, res,
    host: 'mponizil.com'
    port: 80
proxyServer.listen(8000)

targetServer = http.createServer (req, res) ->
  res.writeHead(200, 'Content-Type': 'text/plain')
  res.write('request successfully proxied!' + '\n' + JSON.stringify(req.headers, true, 2))
  res.end()
targetServer.listen(9000)
