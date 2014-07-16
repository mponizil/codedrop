Drop = require './drop'

class Routes

  constructor: ({@mainHost, @fullMainHost, @drops}) ->
    @drops.load()

  index: (req, res) =>
    res.render 'index',
      dropsJSON: @drops.toJSON().replace(/<\/script>/g, '</"+"script>')

  dropCode: (req, res) =>
    host = req.headers.host
    if not host or host is @mainHost
      res.redirect('/')
      return

    subdomain = host[0..host.indexOf('.')-1]
    if drop = @drops.get(subdomain)
      drop.serve(req, res)
      return
    res.send("unknown host #{host}")

  createDrop: (req, res) =>
    drop = new Drop
      mainHost: @mainHost
      fullMainHost: @fullMainHost
      targetHost: req.body.host
      script: req.body.script
    @drops.add(drop)
    res.send(subdomain: drop.subdomain)

  getDrops: (req, res) =>
    res.send(@drops.toJSON())

  deleteDrop: (req, res) =>
    drop = @drops.get(req.params.id)
    if drop
      @drops.remove(drop)
      res.send(true)
    else
      res.send(false)

module.exports = Routes
