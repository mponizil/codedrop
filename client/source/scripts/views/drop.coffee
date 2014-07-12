define [
  'underscore'
  'quilt'
], (_, Quilt) ->

  class DropView extends Quilt.View

    tagName: 'tr'

    constructor: ({@model}) ->
      @model.on('change', @render, @)
      super

    template: -> """
      <td>#{ @model.get 'host' }</td>
      <td>#{ _.escape @model.get 'script' }</td>
      <td><a href="//#{ @model.get 'subdomain' }.#{ location.host }/">#{ @model.get 'subdomain' }</a></td>
      <td><button class="btn" data-destroy>delete</button></td>
    """
