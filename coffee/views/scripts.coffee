define [
  'views/item-list'
  'views/item'
  'views/textarea'
], (ItemListView, ItemView, TextareaView) ->

  class ScriptsView extends ItemListView

    label: "script"

    itemView: do -> ItemView.extend(attr: 'script', inputView: TextareaView)
