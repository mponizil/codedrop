# Dat data

class Host extends Backbone.Model
  defaults:
    host: 'herpderp.com'

class Hosts extends Backbone.Collection
  localStorage: new Backbone.LocalStorage('hosts')
  model: Host

class Script extends Backbone.Model
  defaults:
    script: 'some dope js'

class Scripts extends Backbone.Collection
  localStorage: new Backbone.LocalStorage('scripts')
  model: Script


# Dem views

class RadioView extends Quilt.View

  constructor: (options) ->
    _.extend(@, _.pick(options, 'attr'))
    super

  template: _.template """
    <input type='radio' name='<%= view.attr %>' value='<%= model.get(view.attr) %>' />
  """

class InputView extends Quilt.View

  constructor: (options) ->
    _.extend(@, _.pick(options, 'attr'))
    super

  editJst: _.template """
    <input type='text' name='<%= view.attr %>' value='<%= model.get(view.attr) %>' data-input />
    <button data-save>save</button>
  """

  viewJst: _.template """
    <%= model.get(view.attr) %>
    (<a href='javascript:void(0)' data-edit>edit</a>)
  """

  template: -> @viewJst(arguments...)

  events:
    'click [data-edit]': 'edit'
    'click [data-save]': 'save'
    'keyup [data-input]': 'keyup'

  render: (jst) ->
    @template = jst if jst
    super

  edit: ->
    @render(@editJst)

  save: ->
    @model.save(@attr, @$('[data-input]').val())
    @render(@viewJst)

  keyup: (e) ->
    @save() if e.keyCode is 13

class TextareaView extends InputView

  editJst: _.template """
    <textarea name='<%= view.attr %>' data-input><%= model.get(view.attr) %></textarea>
    <button data-save>save</button>
  """

class ItemView extends Quilt.View

  constructor: (options) ->
    _.extend(@, _.pick(options, 'attr', 'inputView'))
    @inputView ?= InputView
    super

  template: -> """
    <span data-ref='radio'></span>
    <span data-ref='input'></span>
  """

  render: ->
    super
    @views.push(new RadioView
      el: @$radio
      model: @model
      attr: @attr
    .render())
    @views.push(new @inputView
      el: @$input
      model: @model
      attr: @attr
    .render())
    return this

class HostsView extends Quilt.View

  template: -> """
    <h4>Choose host</h4>
    <div data-ref='list'></div>
    <button data-add>+ add new</button>
  """

  render: ->
    super
    @views.push(new List
      el: @$list
      collection: @collection
      view: ItemView.extend(attr: 'host')
    .render())
    return this

class ScriptsView extends Quilt.View

  template: -> """
    <h4>And a script</h4>
    <div data-ref='list'></div>
    <button data-add>+ add new</button>
  """

  render: ->
    super
    @views.push(new List
      el: @$list
      collection: @collection
      view: ItemView.extend(attr: 'script', inputView: TextareaView)
    .render())
    return this

class ConfigureView extends Quilt.View

  constructor: (options) ->
    _.extend(@, _.pick(options, 'hosts', 'scripts'))
    super

  template: -> """
    <div data-ref='hosts'></div>
    <div data-ref='scripts'></div>
  """

  render: ->
    super
    @views.push(new HostsView
      el: @$hosts
      collection: @hosts
    .render())
    @views.push(new ScriptsView
      el: @$scripts
      collection: @scripts
    .render())
    return this


# App code

scripts = new Scripts
scripts.fetch()

hosts = new Hosts
hosts.fetch()

$ ->

  (new ConfigureView({ el: '#configure', scripts, hosts })).render()
