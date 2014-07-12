define [
  'underscore'
  'quilt'
  'views/input'
], (_, Quilt, InputView) ->

  class ItemView extends Quilt.View

    constructor: (options) ->
      _.extend(@, _.pick(options, 'attr', 'inputView', 'drop'))
      @inputView ?= InputView
      super

    master: -> @drop

    template: -> """
      <span data-button-radio>
        <input type='radio' name='#{ @attr }' data-attrs='{"value":"#{ @attr }"}' />
        <button class='btn' data-escape='#{ @attr }'></button>
      </span>
      <span data-ref='input'></span>
    """

    render: ->
      super
      @views.push(new @inputView
        el: @$input
        model: @model
        attr: @attr
      .render())
      return this
