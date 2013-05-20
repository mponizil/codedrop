define [
  'backbone'
], (Backbone) ->

  class Host extends Backbone.Model

    defaults:
      host: 'herpderp.com'
