define [
  'jquery'
  'underscore'
  'backbone'
  'quilt'
  'list'
  'models/scripts'
  'models/hosts'
  'models/sesh'
  'models/seshs'
  'views/widget'
  'views/configure'
  'jquery-cookie'
  'backbone-localstorage'
  'patches/add'
  'patches/destroy'
  'patches/button-radio'
], ($, _, Backbone, Quilt, List, Scripts, Hosts, Sesh, Seshs, WidgetView, ConfigureView) ->

  seshs = new Seshs
  seshs.fetch()

  $ ->

    ###
    configureView = new ConfigureView({ el: '#configure', seshs })
    configureView.render()
    ###
