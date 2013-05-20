var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['underscore', 'quilt', 'views/hosts', 'views/scripts'], function(_, Quilt, HostsView, ScriptsView) {
  var ConfigureView;

  return ConfigureView = (function(_super) {
    __extends(ConfigureView, _super);

    function ConfigureView(options) {
      _.extend(this, _.pick(options, 'hosts', 'scripts', 'sesh'));
      ConfigureView.__super__.constructor.apply(this, arguments);
    }

    ConfigureView.prototype.template = function() {
      return "<form>\n  <div data-ref='hosts'></div>\n  <div data-ref='scripts'></div>\n  <button class='btn' type='submit' data-start>Start Sesh</button>\n</form>\n<button class='btn' data-reset>Reset</button>";
    };

    ConfigureView.prototype.events = {
      'submit form': 'submit',
      'click [data-start]': 'submit',
      'click [data-reset]': 'reset'
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
      this.sesh.save({
        host: host,
        script: script
      });
      if (confirm("hitting up " + host + " and injecting some " + script + ". ready, go!")) {
        return window.location.href = '/';
      }
    };

    ConfigureView.prototype.reset = function(e) {
      return this.sesh.reset();
    };

    return ConfigureView;

  })(Quilt.View);
});
