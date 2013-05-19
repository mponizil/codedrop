httpProxy = require 'http-proxy'

proxy = new httpProxy.RoutingProxy

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

phatSeshScript = """
  <script type='text/javascript' src='/public/phat-sesh.js'></script>
"""

inject = (proxyHost, targetHost, data) ->
  replace = anchorScript(proxyHost, targetHost) + phatSeshScript + '</body>'
  data.replace(/<\/body>/, replace)

module.exports = (req, res) ->

  console.log "sesh this request: #{ req.url }"

  proxyHost = req.headers.host

  targetHost = req.cookies.host
  targetScript = req.cookies.script

  # Modify request headers as needed.
  req.headers.host = targetHost
  delete req.headers['accept-encoding']

  # Override `res.write` with injection code.
  write = res.write
  res.write = (data) ->
    injected = inject(targetHost, proxyHost, data.toString())
    write.call(res, injected)

  # Modify response headers as needed.
  proxy.on 'proxyResponse', (req, res, response) ->
    delete response.headers['content-length']

  console.log 'proxying request to: ', targetHost
  proxy.proxyRequest req, res,
    host: targetHost
    port: 80
