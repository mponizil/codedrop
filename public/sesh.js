var ConfigureView, Host, Hosts, HostsView, InputView, ItemView, RadioView, Script, Scripts, ScriptsView, TextareaView, hosts, scripts, _ref, _ref1, _ref2, _ref3, _ref4, _ref5, _ref6,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

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

RadioView = (function(_super) {
  __extends(RadioView, _super);

  function RadioView(options) {
    _.extend(this, _.pick(options, 'attr'));
    RadioView.__super__.constructor.apply(this, arguments);
  }

  RadioView.prototype.template = _.template("<input type='radio' name='<%= view.attr %>' value='<%= model.get(view.attr) %>' />");

  return RadioView;

})(Quilt.View);

InputView = (function(_super) {
  __extends(InputView, _super);

  function InputView(options) {
    _.extend(this, _.pick(options, 'attr'));
    InputView.__super__.constructor.apply(this, arguments);
  }

  InputView.prototype.editJst = _.template("<input type='text' name='<%= view.attr %>' value='<%= model.get(view.attr) %>' data-input />\n<button data-save>save</button>");

  InputView.prototype.viewJst = _.template("<%= model.get(view.attr) %>\n(<a href='javascript:void(0)' data-edit>edit</a>)");

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
    _ref4 = TextareaView.__super__.constructor.apply(this, arguments);
    return _ref4;
  }

  TextareaView.prototype.editJst = _.template("<textarea name='<%= view.attr %>' data-input><%= model.get(view.attr) %></textarea>\n<button data-save>save</button>");

  return TextareaView;

})(InputView);

ItemView = (function(_super) {
  __extends(ItemView, _super);

  function ItemView(options) {
    var _ref5;

    _.extend(this, _.pick(options, 'attr', 'inputView'));
    if ((_ref5 = this.inputView) == null) {
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

HostsView = (function(_super) {
  __extends(HostsView, _super);

  function HostsView() {
    _ref5 = HostsView.__super__.constructor.apply(this, arguments);
    return _ref5;
  }

  HostsView.prototype.template = function() {
    return "<h4>Choose host</h4>\n<div data-ref='list'></div>\n<button data-add>+ add new</button>";
  };

  HostsView.prototype.render = function() {
    HostsView.__super__.render.apply(this, arguments);
    this.views.push(new List({
      el: this.$list,
      collection: this.collection,
      view: ItemView.extend({
        attr: 'host'
      })
    }).render());
    return this;
  };

  return HostsView;

})(Quilt.View);

ScriptsView = (function(_super) {
  __extends(ScriptsView, _super);

  function ScriptsView() {
    _ref6 = ScriptsView.__super__.constructor.apply(this, arguments);
    return _ref6;
  }

  ScriptsView.prototype.template = function() {
    return "<h4>And a script</h4>\n<div data-ref='list'></div>\n<button data-add>+ add new</button>";
  };

  ScriptsView.prototype.render = function() {
    ScriptsView.__super__.render.apply(this, arguments);
    this.views.push(new List({
      el: this.$list,
      collection: this.collection,
      view: ItemView.extend({
        attr: 'script',
        inputView: TextareaView
      })
    }).render());
    return this;
  };

  return ScriptsView;

})(Quilt.View);

ConfigureView = (function(_super) {
  __extends(ConfigureView, _super);

  function ConfigureView(options) {
    _.extend(this, _.pick(options, 'hosts', 'scripts'));
    ConfigureView.__super__.constructor.apply(this, arguments);
  }

  ConfigureView.prototype.template = function() {
    return "<div data-ref='hosts'></div>\n<div data-ref='scripts'></div>";
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

  return ConfigureView;

})(Quilt.View);

scripts = new Scripts;

scripts.fetch();

hosts = new Hosts;

hosts.fetch();

$(function() {
  return (new ConfigureView({
    el: '#configure',
    scripts: scripts,
    hosts: hosts
  })).render();
});
