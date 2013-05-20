seshRequest = require './sesh-request'

module.exports =

  index: (req, res) ->
    if req.cookies.host
      console.log 'sesh it because req.cookies.host: ', req.cookies.host
      seshRequest(req, res)
    else
      console.log 'no req.cookies.host, render index'
      res.render('index')

  seshRequest: seshRequest
