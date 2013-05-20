define [
  'jquery'
  'backbone'
], ($, Backbone) ->

  class Sesh extends Backbone.Model

    sync: (method, model, options) ->
      if method in ['create', 'update']
        $.cookie(key, value) for key, value of model.attributes
        options.success(model.attributes)
      else if method is 'read'
        attrs = {}
        attrs[key] = value for key in ['host', 'script'] when value = $.cookie(key)
        options.success(attrs)

    reset: ->
      $.removeCookie(key) for key in ['host', 'script']
      @clear()
      window.location.reload()
