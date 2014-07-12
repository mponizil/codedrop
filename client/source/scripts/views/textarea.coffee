define [
  'underscore'
  'views/input'
], (_, InputView) ->

  class TextareaView extends InputView

    editJst: _.template """
      <textarea name='<%= view.attr %>' data-input><%= model.get(view.attr) %></textarea>
      <button class='btn' data-save>save</button>
    """
