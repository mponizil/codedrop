define [
  'underscore'
  'quilt'
], (_, Quilt) ->

  class RadioView extends Quilt.View

    constructor: (options) ->
      _.extend(@, _.pick(options, 'attr'))
      super

    initialize: ->
      super
      @listenTo(@model, "change:#{ @attr }", @render)

    template: _.template """
      <input type='radio' name='<%= view.attr %>' value='<%= _.escape(model.get(view.attr)) %>' />
    """
