define [
  'backbone'
  'models/drop'
], (Backbone, Drop) ->

  class Drops extends Backbone.Collection

    model: Drop
    url: '/drops'

