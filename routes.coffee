seshRequest = require './sesh-request'

module.exports =

  index: (req, res) ->
    if req.cookies.host and false
      console.log 'sesh it because req.cookies.host: ', req.cookies.host
      seshRequest(req, res)
    else
      console.log 'no req.cookies.host, render index'
      res.render('index')

  sesh: (req, res) ->
    {host, script} = req.body

    console.log "create sesh, set cookies:", host, script

    res.cookie('host', host)
    res.cookie('script', script)

    res.json({ host, script })

  seshRequest: seshRequest
