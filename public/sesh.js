var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['jquery', 'underscore', 'backbone', 'quilt', 'list', 'cookie', 'backbone-localstorage', 'patches/add', 'patches/destroy'], function($, _, Backbone, Quilt, List) {
  var ConfigureView, Host, Hosts, HostsView, InputView, ItemListView, ItemView, RadioView, Script, Scripts, ScriptsView, Sesh, TextareaView, hosts, scripts, _ref, _ref1, _ref2, _ref3, _ref4, _ref5, _ref6, _ref7;

  Host = (function(_super) {
    __extends(Host, _super);

    function Host() {
      _ref = Host.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Host.prototype.defaults = {
      host: 'herpderp.com'
    };

    return Host;

  })(Backbone.Model);
  Hosts = (function(_super) {
    __extends(Hosts, _super);

    function Hosts() {
      _ref1 = Hosts.__super__.constructor.apply(this, arguments);
      return _ref1;
    }

    Hosts.prototype.localStorage = new Backbone.LocalStorage('hosts');

    Hosts.prototype.model = Host;

    return Hosts;

  })(Backbone.Collection);
  Script = (function(_super) {
    __extends(Script, _super);

    function Script() {
      _ref2 = Script.__super__.constructor.apply(this, arguments);
      return _ref2;
    }

    Script.prototype.defaults = {
      script: 'some dope js'
    };

    return Script;

  })(Backbone.Model);
  Scripts = (function(_super) {
    __extends(Scripts, _super);

    function Scripts() {
      _ref3 = Scripts.__super__.constructor.apply(this, arguments);
      return _ref3;
    }

    Scripts.prototype.localStorage = new Backbone.LocalStorage('scripts');

    Scripts.prototype.model = Script;

    return Scripts;

  })(Backbone.Collection);
  Sesh = (function(_super) {
    __extends(Sesh, _super);

    function Sesh() {
      _ref4 = Sesh.__super__.constructor.apply(this, arguments);
      return _ref4;
    }

    Sesh.prototype.url = '/sesh';

    return Sesh;

  })(Backbone.Model);
  RadioView = (function(_super) {
    __extends(RadioView, _super);

    function RadioView(options) {
      _.extend(this, _.pick(options, 'attr'));
      RadioView.__super__.constructor.apply(this, arguments);
    }

    RadioView.prototype.template = _.template("<input type='radio' name='<%= view.attr %>' value='<%= _.escape(model.get(view.attr)) %>' />");

    return RadioView;

  })(Quilt.View);
  InputView = (function(_super) {
    __extends(InputView, _super);

    function InputView(options) {
      _.extend(this, _.pick(options, 'attr'));
      InputView.__super__.constructor.apply(this, arguments);
    }

    InputView.prototype.initialize = function() {
      InputView.__super__.initialize.apply(this, arguments);
      return this.listenTo(this.model, 'edit', this.edit);
    };

    InputView.prototype.editJst = _.template("<input type='text' name='<%= view.attr %>' value='<%= model.get(view.attr) %>' data-input />\n<button data-save>save</button>");

    InputView.prototype.viewJst = _.template("<pre><%= _.escape(model.get(view.attr)) %></pre>\n(<a href='javascript:void(0)' data-edit>edit</a>)\n(<a href='javascript:void(0)' data-destroy>delete</a>)");

    InputView.prototype.template = function() {
      return this.viewJst.apply(this, arguments);
    };

    InputView.prototype.events = {
      'click [data-edit]': 'edit',
      'click [data-save]': 'save',
      'keyup [data-input]': 'keyup'
    };

    InputView.prototype.render = function(jst) {
      if (jst) {
        this.template = jst;
      }
      return InputView.__super__.render.apply(this, arguments);
    };

    InputView.prototype.edit = function() {
      return this.render(this.editJst);
    };

    InputView.prototype.save = function() {
      this.model.save(this.attr, this.$('[data-input]').val());
      return this.render(this.viewJst);
    };

    InputView.prototype.keyup = function(e) {
      if (e.keyCode === 13) {
        return this.save();
      }
    };

    return InputView;

  })(Quilt.View);
  TextareaView = (function(_super) {
    __extends(TextareaView, _super);

    function TextareaView() {
      _ref5 = TextareaView.__super__.constructor.apply(this, arguments);
      return _ref5;
    }

    TextareaView.prototype.editJst = _.template("<textarea name='<%= view.attr %>' data-input><%= model.get(view.attr) %></textarea>\n<button data-save>save</button>");

    return TextareaView;

  })(InputView);
  ItemView = (function(_super) {
    __extends(ItemView, _super);

    function ItemView(options) {
      var _ref6;

      _.extend(this, _.pick(options, 'attr', 'inputView'));
      if ((_ref6 = this.inputView) == null) {
        this.inputView = InputView;
      }
      ItemView.__super__.constructor.apply(this, arguments);
    }

    ItemView.prototype.template = function() {
      return "<span data-ref='radio'></span>\n<span data-ref='input'></span>";
    };

    ItemView.prototype.render = function() {
      ItemView.__super__.render.apply(this, arguments);
      this.views.push(new RadioView({
        el: this.$radio,
        model: this.model,
        attr: this.attr
      }).render());
      this.views.push(new this.inputView({
        el: this.$input,
        model: this.model,
        attr: this.attr
      }).render());
      return this;
    };

    return ItemView;

  })(Quilt.View);
  ItemListView = (function(_super) {
    __extends(ItemListView, _super);

    function ItemListView(options) {
      _.extend(this, _.pick(options, 'label', 'itemView'));
      ItemListView.__super__.constructor.apply(this, arguments);
    }

    ItemListView.prototype.label = 'item';

    ItemListView.prototype.itemView = ItemView;

    ItemListView.prototype.template = function() {
      return "<h4>Choose " + this.label + "</h4>\n<div data-ref='list'></div>\n<button data-add>+ add new</button>";
    };

    ItemListView.prototype.events = {
      'add [data-add]': 'edit'
    };

    ItemListView.prototype.render = function() {
      ItemListView.__super__.render.apply(this, arguments);
      this.views.push(new List({
        el: this.$list,
        collection: this.collection,
        view: this.itemView
      }).render());
      return this;
    };

    ItemListView.prototype.edit = function(e, model) {
      return model.trigger('edit');
    };

    return ItemListView;

  })(Quilt.View);
  HostsView = (function(_super) {
    __extends(HostsView, _super);

    function HostsView() {
      _ref6 = HostsView.__super__.constructor.apply(this, arguments);
      return _ref6;
    }

    HostsView.prototype.label = "host";

    HostsView.prototype.itemView = (function() {
      return ItemView.extend({
        attr: 'host'
      });
    })();

    return HostsView;

  })(ItemListView);
  ScriptsView = (function(_super) {
    __extends(ScriptsView, _super);

    function ScriptsView() {
      _ref7 = ScriptsView.__super__.constructor.apply(this, arguments);
      return _ref7;
    }

    ScriptsView.prototype.label = "script";

    ScriptsView.prototype.itemView = (function() {
      return ItemView.extend({
        attr: 'script',
        inputView: TextareaView
      });
    })();

    return ScriptsView;

  })(ItemListView);
  ConfigureView = (function(_super) {
    __extends(ConfigureView, _super);

    function ConfigureView(options) {
      _.extend(this, _.pick(options, 'hosts', 'scripts'));
      ConfigureView.__super__.constructor.apply(this, arguments);
    }

    ConfigureView.prototype.template = function() {
      return "<form>\n  <div data-ref='hosts'></div>\n  <div data-ref='scripts'></div>\n  <button type='submit' data-start>Start Sesh</button>\n</form>";
    };

    ConfigureView.prototype.events = {
      'submit form': 'submit',
      'click [data-start]': 'submit'
    };

    ConfigureView.prototype.render = function() {
      ConfigureView.__super__.render.apply(this, arguments);
      this.views.push(new HostsView({
        el: this.$hosts,
        collection: this.hosts
      }).render());
      this.views.push(new ScriptsView({
        el: this.$scripts,
        collection: this.scripts
      }).render());
      return this;
    };

    ConfigureView.prototype.submit = function(e) {
      var host, script;

      if (e != null) {
        e.preventDefault();
      }
      host = this.$('input:radio:checked[name=host]').val();
      script = this.$('input:radio:checked[name=script]').val();
      console.log(host, script);
      return new Sesh({
        host: host,
        script: script
      }).save().done(function() {
        if (confirm("hitting up " + host + " and injecting some " + script + ". ready, go!")) {
          return window.location.href = '/';
        }
      });
    };

    return ConfigureView;

  })(Quilt.View);
  scripts = new Scripts;
  scripts.fetch();
  hosts = new Hosts;
  hosts.fetch();
  return $(function() {
    return (new ConfigureView({
      el: '#configure',
      scripts: scripts,
      hosts: hosts
    })).render();
  });
});
