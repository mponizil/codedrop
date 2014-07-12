define [
  'jquery'
  'backbone'
], ($, Backbone) ->

  class Drop extends Backbone.Model

    idAttribute: 'subdomain'

    defaults:
      host: 'www.bestbuy.com'
      script: '<script>alert("I am scriptorz")</script>'
      subdomain: ''
