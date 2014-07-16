stream = require 'stream'
http = require 'http'
predropScript = require './predrop'

class Injector extends stream.Transform

  constructor: (proxyHost, targetHost, userScript) ->
    @headReplace = "<head>\n#{predropScript(proxyHost, targetHost)}"
    @bodyReplace = "#{userScript}</body>"
    super

  _transform: (chunk, encoding, done) ->
    blob = chunk.toString().replace('<head>', @headReplace)
                           .replace('</body>', @bodyReplace)
    @push(new Buffer(blob))
    done()

uuid = ->
  Math.random().toString(36)[2..]

class Drop

  constructor: ({@script, @host, domain, @subdomain}) ->
    @subdomain or= uuid()
    @targetHost = "#{@subdomain}.#{domain}"

  serve: (req, res) ->
    console.log "[incoming request] #{req.url}"

    # Modify request headers as needed.
    req.headers.host = @host
    delete req.headers['accept-encoding']

    # prevent IE keep-alive bug
    # http://support.microsoft.com/kb/287705
    delete req.headers['connection']

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
      contentType = remoteRes.headers['content-type'] or 'text/plain'

      delete remoteRes.headers['content-length']
      try res.writeHeader(remoteRes.statusCode, remoteRes.headers)

      isText = /text\/html/.test(contentType)
      isXhr = req.headers['x-requested-with'] is 'XMLHttpRequest'
      if isText and not isXhr
        console.log "[injecting script] #{req.url}"
        output = new Injector(@targetHost, @host, @script)
        output.pipe(res)
      else
        output = res

      remoteRes.pipe(output)
      remoteRes.resume()

    req.pipe(remoteReq)
    req.resume()

module.exports = Drop
