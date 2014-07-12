define ['quilt'], (Quilt) ->

  # Destroy a model on click.
  Quilt.patches.destroy = (el, options) ->
    new Destroy({ el, @model })

  class Destroy extends Quilt.View

    events: ->
      'click': 'click'

    render: ->
      return this

    confirm: (next) ->
      next() if confirm('Are you sure?')

    click: (e) ->
      e.preventDefault()
      @confirm => @model.destroy(wait: true)
