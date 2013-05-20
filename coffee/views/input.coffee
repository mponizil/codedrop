define [
  'underscore'
  'quilt'
], (_, Quilt) ->

  class InputView extends Quilt.View

    constructor: (options) ->
      _.extend(@, _.pick(options, 'attr'))
      super

    initialize: ->
      super
      @listenTo(@model, 'edit', @edit)

    editJst: _.template """
      <input type='text' name='<%= view.attr %>' value='<%= model.get(view.attr) %>' data-input />
      <button class='btn' data-save>save</button>
    """

    viewJst: _.template """
      <pre><%= _.escape(model.get(view.attr)) %></pre>
      (<a href='javascript:void(0)' data-edit>edit</a>)
      (<a href='javascript:void(0)' data-destroy>delete</a>)
    """

    template: -> @viewJst(arguments...)

    events:
      'click [data-edit]': 'edit'
      'click [data-save]': 'save'
      'keyup [data-input]': 'keyup'

    render: (jst) ->
      @template = jst if jst
      super

    edit: ->
      @render(@editJst)

    save: ->
      @model.save(@attr, @$('[data-input]').val())
      @render(@viewJst)

    keyup: (e) ->
      @save() if e.keyCode is 13
