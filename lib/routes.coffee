seshRequest = require './sesh'

domain = ''

module.exports =

  index: (req, res) ->
    res.render 'index',
      seshsJSON: JSON.stringify(seshRequest.seshs).replace(/<\/script>/g, '</"+"script>')

  setDomain: (d) ->
    domain = d

  seshRequest: seshRequest.serve

  createSesh: (req, res) ->
    sesh = seshRequest.create
      domain: domain
      script: req.body.script
      host: req.body.host
    res.send
      subdomain: sesh.subdomain
      id: sesh.subdomain

  getSeshs: (req, res) ->
    res.send(seshRequest.seshs)
    #console.log req.url, req.method, req.query, req.params, req.body, req.headers

  sesh: (req, res) ->
    console.log 'id', req.url, req.method, req.query, req.params, req.body, req.headers
    res.send([])
