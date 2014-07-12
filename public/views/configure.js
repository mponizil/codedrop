var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['underscore', 'quilt', 'list', 'views/drop'], function(_, Quilt, List, DropView) {
  var ConfigureView;

  return ConfigureView = (function(_super) {
    __extends(ConfigureView, _super);

    ConfigureView.prototype.itemView = function() {
      return DropView;
    };

    function ConfigureView(_arg) {
      this.drops = _arg.drops;
      ConfigureView.__super__.constructor.apply(this, arguments);
    }

    ConfigureView.prototype.template = function() {
      return "<form>\n  <h4>Code Drops</h4>\n  <table>\n    <thead>\n    <tr>\n      <th>Host</th>\n      <th>Script</th>\n      <th>Link</th>\n    </tr>\n    </head>\n    <tbody data-ref='drops'></tbody>\n    <tfoot>\n    <tr>\n      <td><input type='text' data-ref='host'></td>\n      <td><input type='text' data-ref='script' class='script'></td>\n      <td><button class='btn' type='submit'>Create</button></td>\n    </tr>\n    </tfoot>\n  </table>\n</form>";
    };

    ConfigureView.prototype.events = {
      'submit form': 'submit'
    };

    ConfigureView.prototype.render = function() {
      var defaultDrop;

      ConfigureView.__super__.render.apply(this, arguments);
      this.views.push(new List({
        el: this.$drops,
        collection: this.drops,
        view: this.itemView()
      }).render());
      if (!this.inited) {
        this.inited = true;
        defaultDrop = new this.drops.model;
        this.$host.val(defaultDrop.get('host'));
        this.$script.val(defaultDrop.get('script'));
      }
      return this;
    };

    ConfigureView.prototype.submit = function(e) {
      var drop;

      if (e != null) {
        e.preventDefault();
      }
      drop = new this.drops.model({
        host: this.$host.val(),
        script: this.$script.val()
      });
      this.drops.add(drop);
      return drop.save();
    };

    return ConfigureView;

  })(Quilt.View);
});
