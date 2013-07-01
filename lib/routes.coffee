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
    host = req.headers.host
    if !host or host == domain
      res.redirect('/')
      return

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
    seshsStorage.saveToFile(seshs)

  getSeshs: (req, res) ->
    res.send(seshs)

  deleteSesh: (req, res) ->
    sesh = seshsBySubdomain[req.params.id]
    delete seshsBySubdomain[sesh.subdomain]
    seshs.splice(seshs.indexOf(sesh), 1)
    seshsStorage.saveToFile(seshs)
    res.send(true)
