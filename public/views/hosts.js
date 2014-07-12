var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['underscore', 'views/item-list', 'views/item'], function(_, ItemListView, ItemView) {
  var HostsView;

  return HostsView = (function(_super) {
    __extends(HostsView, _super);

    function HostsView(options) {
      _.extend(this, _.pick(options, 'drop'));
      HostsView.__super__.constructor.apply(this, arguments);
    }

    HostsView.prototype.label = "host";

    HostsView.prototype.itemView = function() {
      return ItemView.extend({
        attr: 'host',
        drop: this.drop
      });
    };

    return HostsView;

  })(ItemListView);
});
