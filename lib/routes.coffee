Sesh = require './sesh'
SeshsStorage = require './storage'

seshs = []
seshsBySubdomain = {}
seshsStorage = new SeshsStorage 'seshstore.json'

seshsStorage.loadFromFile (s) ->
  for sesh in seshs = s
    seshsBySubdomain[sesh.subdomain] = sesh

domain = ''

module.exports =

  index: (req, res) ->
    res.render 'index',
      seshsJSON: JSON.stringify(seshs).replace(/<\/script>/g, '</"+"script>')

  setDomain: (d) ->
    domain = d

  seshRequest: (req, res) ->
    if host = req.headers.host
      subdomain = host[0..host.indexOf('.')-1]
      if sesh = seshsBySubdomain[subdomain]
        sesh.serve(req, res)
        return
    res.send("unknown host #{host}")

  createSesh: (req, res) ->
    sesh = new Sesh
      domain: domain
      script: req.body.script
      host: req.body.host
    seshs.push sesh
    seshsBySubdomain[sesh.subdomain] = sesh
    res.send
      subdomain: sesh.subdomain
      id: sesh.subdomain
    seshsStorage.saveToFile(seshs)

  getSeshs: (req, res) ->
    res.send(seshs)

  sesh: (req, res) ->
    console.log 'id', req.url, req.method, req.query, req.params, req.body, req.headers
    res.send([])
