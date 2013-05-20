define [
  'views/item-list'
  'views/item'
], (ItemListView, ItemView) ->

  class HostsView extends ItemListView

    label: "host"

    itemView: do -> ItemView.extend(attr: 'host')
