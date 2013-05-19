http = require 'http'
express = require 'express'
httpProxy = require 'http-proxy'
ip = require './ip'

host = process.env.HOST or '0.0.0.0'
port = process.env.PORT or 8000

chatidScript = """
<script> var s = document.createElement('script'); s.src = "http://s3.amazonaws.com/chatid-mojo-private/development/w/demo/charles_1368214390_bulletproof/charles_demo.js"; s.onload = function() {this.parentNode.removeChild(this);}; (document.head||document.documentElement).appendChild(s); </script> </body>
"""

rewrite = (data) ->
  data.replace(/<\/body>/, chatidScript)

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

    res.send "ok, i've got you browsing #{ host }"

  else

    host = req.cookies.host
    # host = 'www.bestbuy.com'

    req.headers.host = host
    delete req.headers['accept-encoding']

    write = res.write
    res.write = (data) ->
      write.call(res, rewrite(data.toString()))

    proxy.on 'proxyResponse', (req, res, response) ->
      delete response.headers['content-length']

    console.log 'proxying request to: ', host
    proxy.proxyRequest req, res,
      host: host
      port: 80

server.listen(port, host)
console.log "listening on #{ host }:#{ port }"
