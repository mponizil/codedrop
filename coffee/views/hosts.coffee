define [
  'underscore'
  'views/item-list'
  'views/item'
], (_, ItemListView, ItemView) ->

  class HostsView extends ItemListView

    constructor: (options) ->
      _.extend(@, _.pick(options, 'drop'))
      super

    label: "host"

    itemView: -> ItemView.extend
      attr: 'host'
      drop: @drop
