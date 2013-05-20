define [
  'underscore'
  'quilt'
  'views/hosts'
  'views/scripts'
], (_, Quilt, HostsView, ScriptsView) ->

  class ConfigureView extends Quilt.View

    constructor: (options) ->
      _.extend(@, _.pick(options, 'hosts', 'scripts', 'sesh'))
      super

    template: -> """
      <form>
        <div data-ref='hosts'></div>
        <div data-ref='scripts'></div>
        <button class='btn' type='submit' data-start>Start Sesh</button>
      </form>
      <button class='btn' data-reset>Reset</button>
    """

    events:
      'submit form': 'submit'
      'click [data-start]': 'submit'
      'click [data-reset]': 'reset'

    render: ->
      super
      @views.push(new HostsView
        el: @$hosts
        collection: @hosts
        sesh: @sesh
      .render())
      @views.push(new ScriptsView
        el: @$scripts
        collection: @scripts
        sesh: @sesh
      .render())
      return this

    submit: (e) ->
      e?.preventDefault()

      host = @$('input:radio:checked[name=host]').val()
      script = @$('input:radio:checked[name=script]').val()

      @sesh.save({ host, script })

      if confirm "hitting up #{ host } and injecting some #{ script }. ready, go!"
        window.location.href = '/'

    reset: (e) ->
      @sesh.reset()
