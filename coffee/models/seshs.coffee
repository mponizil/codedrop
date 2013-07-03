define [
  'backbone'
  'models/sesh'
], (Backbone, Sesh) ->

  class Seshs extends Backbone.Collection

    model: Sesh
    url: '/seshs'

