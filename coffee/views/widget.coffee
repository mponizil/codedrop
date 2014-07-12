define [
  'underscore'
  'quilt'
  'views/configure'
], (_, Quilt, ConfigureView) ->

  class WidgetView extends Quilt.View

    constructor: (options) ->
      _.extend(@, _.pick(options, 'hosts', 'scripts', 'sesh'))
      super

    template: -> """
      <button class='btn btn-small' data-toggle>Toggle</button>
      <div data-ref='configure'></div>
    """

    events:
      'click [data-toggle]': 'toggle'

    render: ->
      super
      @views.push(new ConfigureView
        el: @$configure
        hosts: @hosts
        scripts: @scripts
        sesh: @sesh
      .render())
      @$configure.slideUp(0)
      return this

    toggle: -> @$configure.slideToggle()
