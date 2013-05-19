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

phatSeshScript = """
  <script type='text/javascript' src='/public/phat-sesh.js'></script>
"""

inject = (proxyHost, targetHost, body, userScript) ->
  replace = anchorScript(proxyHost, targetHost) + phatSeshScript + userScript + '</body>'
  body.replace(/<\/body>/, replace)

module.exports = (req, res) ->

  console.log "sesh this request: #{ req.url }"

  proxyHost = req.headers.host

  targetHost = req.cookies.host
  userScript = req.cookies.script

  # Modify request headers as needed.
  req.headers.host = targetHost
  delete req.headers['accept-encoding']

  # Override `res.write` with injection code.
  write = res.write
  res.write = (data) ->
    write.call(res, inject(targetHost, proxyHost, data.toString(), userScript))

  # Modify response headers as needed.
  proxy.on 'proxyResponse', (req, res, response) ->
    delete response.headers['content-length']

  console.log 'proxying request to: ', targetHost
  proxy.proxyRequest req, res,
    host: targetHost
    port: 80
