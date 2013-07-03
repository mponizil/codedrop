var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['underscore', 'quilt', 'list', 'views/sesh'], function(_, Quilt, List, SeshView) {
  var ConfigureView;
  return ConfigureView = (function(_super) {
    __extends(ConfigureView, _super);

    ConfigureView.prototype.itemView = function() {
      return SeshView;
    };

    function ConfigureView(_arg) {
      this.seshs = _arg.seshs;
      ConfigureView.__super__.constructor.apply(this, arguments);
    }

    ConfigureView.prototype.template = function() {
      return "<form>\n  <h4>Seshs</h4>\n  <table>\n    <thead>\n    <tr>\n      <th>Host</th>\n      <th>Script</th>\n      <th>Link</th>\n    </tr>\n    </head>\n    <tbody data-ref='seshs'></tbody>\n    <tfoot>\n    <tr>\n      <td><input type='text' data-ref='host'></td>\n      <td><input type='text' data-ref='script' class='script'></td>\n      <td><button class='btn' type='submit'>Create</button></td>\n    </tr>\n    </tfoot>\n  </table>\n</form>";
    };

    ConfigureView.prototype.events = {
      'submit form': 'submit'
    };

    ConfigureView.prototype.render = function() {
      var defaultSesh;
      ConfigureView.__super__.render.apply(this, arguments);
      this.views.push(new List({
        el: this.$seshs,
        collection: this.seshs,
        view: this.itemView()
      }).render());
      if (!this.inited) {
        this.inited = true;
        defaultSesh = new this.seshs.model;
        this.$host.val(defaultSesh.get('host'));
        this.$script.val(defaultSesh.get('script'));
      }
      return this;
    };

    ConfigureView.prototype.submit = function(e) {
      var sesh;
      if (e != null) {
        e.preventDefault();
      }
      sesh = new this.seshs.model({
        host: this.$host.val(),
        script: this.$script.val()
      });
      this.seshs.add(sesh);
      return sesh.save();
    };

    return ConfigureView;

  })(Quilt.View);
});
