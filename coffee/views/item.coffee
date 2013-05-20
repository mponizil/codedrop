define [
  'underscore'
  'quilt'
  'views/radio'
  'views/input'
], (_, Quilt, RadioView, InputView) ->

  class ItemView extends Quilt.View

    constructor: (options) ->
      _.extend(@, _.pick(options, 'attr', 'inputView'))
      @inputView ?= InputView
      super

    template: -> """
      <span data-ref='radio'></span>
      <span data-ref='input'></span>
    """

    render: ->
      super
      @views.push(new RadioView
        el: @$radio
        model: @model
        attr: @attr
      .render())
      @views.push(new @inputView
        el: @$input
        model: @model
        attr: @attr
      .render())
      return this
