define [
  'cookie'
  'jquery'
  'underscore'
  'backbone'
  'quilt'
  'list'
  'backbone-localstorage'
  'patches/add'
  'patches/destroy'
], (Cookie, $, _, Backbone, Quilt, List) ->

  # Dat data

  class Host extends Backbone.Model
    defaults:
      host: 'herpderp.com'

  class Hosts extends Backbone.Collection
    localStorage: new Backbone.LocalStorage('hosts')
    model: Host

  class Script extends Backbone.Model
    defaults:
      script: '<script>alert("some dope js")</script>'

  class Scripts extends Backbone.Collection
    localStorage: new Backbone.LocalStorage('scripts')
    model: Script

  class Sesh extends Backbone.Model
    url: '/sesh'
    isNew: -> true
    sync: (method, model, options, attrs = {}) ->
      if method is 'read'
        attrs[key] = Cookie.get(key) for key in ['host', 'script']
        options.success(attrs)
      else
        super


  # Dem views

  class RadioView extends Quilt.View

    constructor: (options) ->
      _.extend(@, _.pick(options, 'attr'))
      super

    initialize: ->
      super
      @listenTo(@model, "change:#{ @attr }", @render)

    template: _.template """
      <input type='radio' name='<%= view.attr %>' value='<%= _.escape(model.get(view.attr)) %>' />
    """

  class InputView extends Quilt.View

    constructor: (options) ->
      _.extend(@, _.pick(options, 'attr'))
      super

    initialize: ->
      super
      @listenTo(@model, 'edit', @edit)

    editJst: _.template """
      <input type='text' name='<%= view.attr %>' value='<%= model.get(view.attr) %>' data-input />
      <button class='btn' data-save>save</button>
    """

    viewJst: _.template """
      <pre><%= _.escape(model.get(view.attr)) %></pre>
      (<a href='javascript:void(0)' data-edit>edit</a>)
      (<a href='javascript:void(0)' data-destroy>delete</a>)
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
      <button class='btn' data-save>save</button>
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

  class ItemListView extends Quilt.View

    constructor: (options) ->
      _.extend(@, _.pick(options, 'label', 'itemView'))
      super

    label: 'item'

    itemView: ItemView

    template: -> """
      <h4>Choose #{ @label }</h4>
      <div data-ref='list'></div>
      <button class='btn' data-add>+ add new</button>
    """

    events:
      'add [data-add]': 'edit'

    render: ->
      super
      @views.push(new List
        el: @$list
        collection: @collection
        view: @itemView
      .render())
      return this

    edit: (e, model) -> model.trigger('edit')

  class HostsView extends ItemListView
    label: "host"
    itemView: do -> ItemView.extend(attr: 'host')

  class ScriptsView extends ItemListView
    label: "script"
    itemView: do -> ItemView.extend(attr: 'script', inputView: TextareaView)

  class ConfigureView extends Quilt.View

    constructor: (options) ->
      _.extend(@, _.pick(options, 'hosts', 'scripts', 'sesh'))
      super

    template: -> """
      <form>
        <div data-ref='hosts'></div>
        <div data-ref='scripts'></div>
        <button class='btn' type='submit' data-start>Start Sesh</button>
      </form>
    """

    events:
      'submit form': 'submit'
      'click [data-start]': 'submit'

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

    submit: (e) ->
      e?.preventDefault()

      host = @$('input:radio:checked[name=host]').val()
      script = @$('input:radio:checked[name=script]').val()

      @sesh.save({ host, script }).done ->
        if confirm "hitting up #{ host } and injecting some #{ script }. ready, go!"
          window.location.href = '/'

  class WidgetView extends Quilt.View
    constructor: (options) ->
      _.extend(@, _.pick(options, 'hosts', 'scripts', 'sesh'))
      super
    template: -> """
      <button class='btn btn-small' data-toggle>Toggle</button>
      <div data-ref='configure'></div>
    """
    events:
      'click [data-toggle]': 'toggle'
    render: ->
      super
      @views.push(new ConfigureView
        el: @$configure
        hosts: @hosts
        scripts: @scripts
        sesh: @sesh
      .render())
      @$configure.slideUp(0)
      return this
    toggle: -> @$configure.slideToggle()

  # App code

  scripts = new Scripts
  scripts.fetch()

  hosts = new Hosts
  hosts.fetch()

  sesh = new Sesh
  sesh.fetch()

  $ ->

    # Rendering on the target host.
    if Cookie.get('host')
      $widget = $("<div class='proxy-sesh-widget proxy-sesh-configure'>")
      $widget.appendTo('body')

      $("<link href='/public/css/style.css' rel='stylesheet' />").appendTo('head')

      widgetView = new WidgetView({ el: $widget, scripts, hosts, sesh })
      widgetView.render()

    # Render on the homepage.
    else
      configureView = new ConfigureView({ el: '#configure', scripts, hosts, sesh })
      configureView.render()
