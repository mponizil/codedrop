define [
  'underscore'
  'quilt'
  'list'
  'views/item'
], (_, Quilt, List, ItemView) ->

  class ItemListView extends Quilt.View

    constructor: (options) ->
      _.extend(@, _.pick(options, 'label', 'itemView'))
      super

    label: 'item'

    itemView: ItemView

    template: -> """
      <h4>Choose #{ @label }</h4>
      <div data-ref='list'></div>
      <button class='btn' data-add>+ add new</button>
    """

    events:
      'add [data-add]': 'edit'

    render: ->
      super
      @views.push(new List
        el: @$list
        collection: @collection
        view: @itemView
      .render())
      return this

    edit: (e, model) -> model.trigger('edit')
