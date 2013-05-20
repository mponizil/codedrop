define [
  'jquery'
  'underscore'
  'quilt'
], ($, _, Quilt) ->

  Quilt.patches.buttonRadio = (el, options) ->
    master = _.result(@, 'master')
    $radio = $(el).children('input:radio')
    $button = $(el).children('button')
    attr = $radio.attr('name')
    new ButtonRadio({ el, @model, master, $radio, $button, attr })

  class ButtonRadio extends Quilt.View

    constructor: (options) ->
      _.extend(@, _.pick(options, 'master', '$radio', '$button', 'attr'))
      super

    initialize: ->
      super
      @$radio.addClass('hide')

      if @master
        @listenTo(@master, "change:#{ @attr }", @render)
      else
        @listenTo(@model, "change:#{ @attr }", @render)

    events:
      'click button': 'toggle'

    render: ->
      if @master
        chosen = @model.get(@attr) is @master.get(@attr)
      else
        chosen = @model.get(@attr) is 'true'

      if chosen
        @$radio.prop('checked', 'checked')
      else
        @$radio.removeProp('checked')

      @$button.toggleClass('active', chosen)
      return this

    toggle: (e) ->
      e?.stopPropagation()

      if @master
        value = @model.get(@attr)
        @master.set(@attr, value)
      else
        value = @model.get(@attr)
        @model.set(@attr, not value)

      return false
