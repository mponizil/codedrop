fs = require 'fs'
Drop = require './drop'

class Storage
  json: '[]'

  constructor: ({@fileName, @domain}) ->
    @all = []
    @bySubdomain = {}

  toJSON: -> @json

  add: (drop) ->
    @all.push(drop)
    @bySubdomain[drop.subdomain] = drop
    @save()

  remove: (drop) ->
    delete @bySubdomain[drop.subdomain]
    @all.splice(@all.indexOf(drop), 1)
    @save()

  get: (subdomain) ->
    @bySubdomain[subdomain]

  save: ->
    @json = JSON.stringify(@all, null, 2)
    fs.writeFile @fileName, @json, (err) ->
      throw err if err

  load: ->
    fs.readFile @fileName, encoding: 'ascii', (err, @json) =>
      throw err if err
      try
        @all = JSON.parse(@json).map (drop) =>
          drop.domain = @domain
          new Drop(drop)
      catch err
        @all = []
        @json = '[]'
      for drop in @all
        @bySubdomain[drop.subdomain] = drop

module.exports = Storage
