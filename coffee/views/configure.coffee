define [
  'underscore'
  'quilt'
  'list'
  'views/sesh'
], (_, Quilt, List, SeshView) ->

  class ConfigureView extends Quilt.View

    itemView: -> SeshView

    constructor: ({@seshs}) ->
      #_.extend(@, _.pick(options, 'hosts', 'scripts', 'sesh'))
      super

    template: -> """
      <form>
        <h4>Seshs</h4>
        <table>
          <thead>
          <tr>
            <th>Host</th>
            <th>Script</th>
            <th>Link</th>
          </tr>
          </head>
          <tbody data-ref='seshs'></tbody>
          <tfoot>
          <tr>
            <td><input type='text' data-ref='host'></td>
            <td><input type='text' data-ref='script' class='script'></td>
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
        el: @$seshs
        collection: @seshs
        view: @itemView()
      .render())
      unless @inited
        @inited = yes
        defaultSesh = new @seshs.model
        @$host.val(defaultSesh.get('host'))
        @$script.val(defaultSesh.get('script'))
      return this

    submit: (e) ->
      e?.preventDefault()

      sesh = new @seshs.model
        host: @$host.val()
        script: @$script.val()
      @seshs.add sesh
      sesh.save()
