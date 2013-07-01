fs = require 'fs'

class SeshsStorage
  json: '[]'

  constructor: (@fileName) ->
    @all = []
    @bySubdomain = {}

  toJSON: -> @json

  add: (sesh) ->
    @all.push(sesh)
    @bySubdomain[sesh.subdomain] = sesh
    @save()

  remove: (sesh) ->
    delete @bySubdomain[sesh.subdomain]
    @all.splice(@all.indexOf(sesh), 1)
    @save()

  get: (subdomain) ->
    @bySubdomain[subdomain]

  save: ->
    @json = JSON.stringify(@all)
    fs.writeFile @fileName, @json, (err) ->
      throw err if err
      console.log 'saved seshs to file'

  load: ->
    fs.readFile @fileName, encoding: 'ascii', (err, @json) =>
      throw err if err
      try
        @all = JSON.parse @json
      catch err
        @all = []
        @json = '[]'
      for sesh in @all
        @bySubdomain[sesh.subdomain] = sesh

module.exports = SeshsStorage
