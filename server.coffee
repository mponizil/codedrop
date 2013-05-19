http = require 'http'
express = require 'express'
httpProxy = require 'http-proxy'
ip = require './ip'

listenHost = process.env.HOST or '0.0.0.0'
listenPort = process.env.PORT or 8000

anchorScript = (targetHost, proxyHost) -> """
<script>
var anchors = document.getElementsByTagName('a');
for (i in anchors) {
  if (!anchors[i].href) continue;
  anchors[i].href = anchors[i].href.replace('#{ targetHost }', '#{ proxyHost }');
}
</script>
"""
chatidScript = """
<script> window.derp = true; var __cidw_config = {BOSH_URL:'http://stage-chat.api.chatid.com/http-bind'};var s = document.createElement('script'); s.src = "http://s3.amazonaws.com/chatid-mojo-private/development/w/demo/charles_1368214390_bulletproof/charles_demo.js"; s.onload = function() {this.parentNode.removeChild(this);}; (document.head||document.documentElement).appendChild(s); </script> </body>
"""

inject = (proxyHost, targetHost, data) ->
  replace = anchorScript(proxyHost, targetHost) + chatidScript
  data.replace(/<\/body>/, replace)

# Proxy magic ...
proxy = new httpProxy.RoutingProxy
server = express()
server.use(express.bodyParser())
server.use(express.cookieParser())

server.all /^\/proxy\/(.*)|.*/, (req, res) ->

  console.log "incoming: #{ req.url }"

  if targetHost = req.params[0]

    console.log "setting cookie host to #{ targetHost }"
    res.cookie('host', targetHost)

    res.send "ok, i've got you browsing #{ targetHost }"

  else

    proxyHost = req.headers.host
    targetHost = req.cookies.host

    req.headers.host = targetHost
    delete req.headers['accept-encoding']

    write = res.write
    res.write = (data) ->
      injected = inject(targetHost, proxyHost, data.toString())
      write.call(res, injected)

    proxy.on 'proxyResponse', (req, res, response) ->
      delete response.headers['content-length']

    console.log 'proxying request to: ', targetHost
    proxy.proxyRequest req, res,
      host: targetHost
      port: 80

server.listen(listenPort, listenHost)
console.log "listening on #{ listenHost }:#{ listenPort }"
