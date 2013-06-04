stream = require 'stream'
http = require 'http'

anchorScript = (proxyHost, targetHost) -> """
<script>
var anchors = document.getElementsByTagName('a');
for (i in anchors) {
  if (!anchors[i].href) continue;
  anchors[i].href = anchors[i].href.replace('#{ targetHost }', '#{ proxyHost }');
}
document.domain = '#{ proxyHost }';
</script>
"""

phatSeshScript = """
  <script type='text/javascript' src='/public/phat-sesh.js'></script>
"""

class Injector extends stream.Transform
  constructor: (proxyHost, targetHost, userScript) ->
    @bodyReplace = anchorScript(proxyHost, targetHost) + phatSeshScript + userScript + '</body>'
    super

  _transform: (chunk, encoding, done) ->
    @push new Buffer(chunk.toString().replace(/<\/body>/, @bodyReplace))
    done()

module.exports = (req, res) ->

  return unless targetHost = req.cookies.host

  # Modify request headers as needed.
  req.headers.host = targetHost
  delete req.headers['accept-encoding']

  console.log "sesh this request: #{ req.url }"

  proxyHost = req.headers.host
  userScript = req.cookies.script

  req.pause()

  options =
    hostname: targetHost
    port: 80
    path: req.url
    headers: req.headers
    method: req.method
    agent: false

  remoteReq = http.request options, (remoteRes) ->
    remoteRes.pause()
    contentType = remoteRes.headers['content-type'] || 'text/plain'

    delete remoteRes.headers['content-length']
    res.writeHeader(remoteRes.statusCode, remoteRes.headers)

    isText = /text|html/.test(contentType)
    if isText
      output = new Injector(proxyHost, targetHost, userScript)
      output.pipe(res)
    else
      output = res

    remoteRes.pipe(output)
    remoteRes.resume()

  console.log 'proxying request to:', targetHost

  req.pipe(remoteReq)
  req.resume()
