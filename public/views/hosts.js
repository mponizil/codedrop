var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['views/item-list', 'views/item'], function(ItemListView, ItemView) {
  var HostsView, _ref;

  return HostsView = (function(_super) {
    __extends(HostsView, _super);

    function HostsView() {
      _ref = HostsView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    HostsView.prototype.label = "host";

    HostsView.prototype.itemView = (function() {
      return ItemView.extend({
        attr: 'host'
      });
    })();

    return HostsView;

  })(ItemListView);
});
