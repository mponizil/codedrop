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

class Injector extends stream.Transform
  constructor: (proxyHost, targetHost, userScript) ->
    @bodyReplace = anchorScript(proxyHost, targetHost) + userScript + '</body>'
    super

  _transform: (chunk, encoding, done) ->
    @push new Buffer(chunk.toString().replace(/<\/body>/, @bodyReplace))
    done()

uuid = ->
  Math.random().toString(36)[2..]

class Sesh
  constructor: ({@script, @host, @domain}) ->
    @subdomain = uuid()
    @targetHost = "#{@subdomain}.#{@domain}"

  serve: (req, res) ->
    # Modify request headers as needed.
    req.headers.host = @host
    delete req.headers['accept-encoding']

    console.log "sesh this request: #{ req.url }"

    req.pause()

    options =
      hostname: @host
      port: 80
      path: req.url
      headers: req.headers
      method: req.method
      agent: false

    remoteReq = http.request options, (remoteRes) =>
      remoteRes.pause()
      contentType = remoteRes.headers['content-type'] || 'text/plain'

      delete remoteRes.headers['content-length']
      try res.writeHeader(remoteRes.statusCode, remoteRes.headers)

      isText = /text|html/.test(contentType)
      if isText
        output = new Injector(@targetHost, @host, @script)
        output.pipe(res)
      else
        output = res

      remoteRes.pipe(output)
      remoteRes.resume()

    console.log 'proxying request to:', @host

    req.pipe(remoteReq)
    req.resume()

module.exports = Sesh
