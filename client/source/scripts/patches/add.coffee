define ['quilt'], (Quilt) ->

  # Add a default model to the collection.
  Quilt.patches.add = (el, options) ->
    new Add({ el, @collection })

  class Add extends Quilt.View

    events:
      'click': 'add'

    add: (e) ->
      e.preventDefault()

      model = new @collection.model
      @collection.add(model)

      @$el.trigger('add', [model])
