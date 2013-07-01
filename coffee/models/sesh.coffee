define [
  'jquery'
  'backbone'
], ($, Backbone) ->

  class Sesh extends Backbone.Model

    defaults:
      host: 'www.bestbuy.com'
      script: '<script>alert("I am scriptorz")</script>'
      subdomain: ''
