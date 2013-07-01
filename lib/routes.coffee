Sesh = require './sesh'
SeshsStorage = require './storage'

seshs = new SeshsStorage 'seshstore.json'
seshs.load()
domain = ''

module.exports =

  index: (req, res) ->
    res.render 'index',
      seshsJSON: seshs.toJSON().replace(/<\/script>/g, '</"+"script>')

  setDomain: (d) ->
    domain = d

  seshRequest: (req, res) ->
    host = req.headers.host
    if !host or host == domain
      res.redirect('/')
      return

    subdomain = host[0..host.indexOf('.')-1]
    if sesh = seshs.get(subdomain)
      sesh.serve(req, res)
      return
    res.send("unknown host #{host}")

  createSesh: (req, res) ->
    sesh = new Sesh
      domain: domain
      script: req.body.script
      host: req.body.host
    seshs.add(sesh)
    res.send
      subdomain: sesh.subdomain

  getSeshs: (req, res) ->
    res.send(seshs.toJSON())

  deleteSesh: (req, res) ->
    sesh = seshs.get(req.params.id)
    if sesh
      seshs.remove(sesh)
      res.send(true)
    else
      res.send(false)
