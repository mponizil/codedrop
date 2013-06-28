define [
  'jquery'
  'backbone'
], ($, Backbone) ->

  class Sesh extends Backbone.Model

    defaults:
      host: 'www.bestbuy.com'
      script: '<script>alert("I am scriptorz")</script>'
      subdomain: ''

    syncX: (method, model, options) ->
      if method in ['create', 'update']
        $.cookie(key, value) for key, value of model.attributes
        options.success(model.attributes)
      else if method is 'read'
        attrs = {}
        attrs[key] = value for key in ['host', 'script'] when value = $.cookie(key)
        options.success(attrs)
