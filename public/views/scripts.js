var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['views/item-list', 'views/item', 'views/textarea'], function(ItemListView, ItemView, TextareaView) {
  var ScriptsView, _ref;

  return ScriptsView = (function(_super) {
    __extends(ScriptsView, _super);

    function ScriptsView() {
      _ref = ScriptsView.__super__.constructor.apply(this, arguments);
      return _ref;
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
});
