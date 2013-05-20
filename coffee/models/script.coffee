define [
  'backbone'
], (Backbone) ->

  class Script extends Backbone.Model

    defaults:
      script: '<script>alert("some dope js")</script>'
