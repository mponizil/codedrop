define [
  'jquery'
  'underscore'
  'backbone'
  'quilt'
  'list'
  'models/scripts'
  'models/hosts'
  'models/sesh'
  'views/widget'
  'views/configure'
  'jquery-cookie'
  'backbone-localstorage'
  'patches/add'
  'patches/destroy'
], ($, _, Backbone, Quilt, List, Scripts, Hosts, Sesh, WidgetView, ConfigureView) ->

  scripts = new Scripts
  scripts.fetch()

  hosts = new Hosts
  hosts.fetch()

  sesh = new Sesh
  sesh.fetch()

  $ ->

    # Rendering on the target host.
    if $.cookie('host')
      $widget = $("<div class='proxy-sesh-widget proxy-sesh-configure'>")
      $widget.appendTo('body')

      $("<link href='/public/css/style.css' rel='stylesheet' />").appendTo('head')

      widgetView = new WidgetView({ el: $widget, scripts, hosts, sesh })
      widgetView.render()

    # Render on the homepage.
    else
      configureView = new ConfigureView({ el: '#configure', scripts, hosts, sesh })
      configureView.render()
