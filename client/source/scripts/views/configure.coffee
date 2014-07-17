define [
  'underscore'
  'quilt'
  'list'
  'views/drop'
], (_, Quilt, List, DropView) ->

  class ConfigureView extends Quilt.View

    itemView: -> DropView

    constructor: ({@drops}) ->
      super

    template: -> """
      <form>
        <h4>Code Drops</h4>
        <table>
          <thead>
          <tr>
            <th>Host</th>
            <th>Script</th>
            <th>Link</th>
          </tr>
          </head>
          <tbody data-ref='drops'></tbody>
          <tfoot>
          <tr>
            <td><input type='text' data-ref='host'></td>
            <td><textarea data-ref='script' class='script'></textarea></td>
            <td><button class='btn' type='submit'>Create</button></td>
          </tr>
          </tfoot>
        </table>
      </form>
    """

    events:
      'submit form': 'submit'

    render: ->
      super
      @views.push(new List
        el: @$drops
        collection: @drops
        view: @itemView()
      .render())
      unless @inited
        @inited = yes
        defaultDrop = new @drops.model
        @$host.val(defaultDrop.get('host'))
        @$script.val(defaultDrop.get('script'))
      return this

    submit: (e) ->
      e?.preventDefault()

      drop = new @drops.model
        host: @$host.val()
        script: @$script.val()
      @drops.add(drop)
      drop.save()
