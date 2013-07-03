var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['underscore', 'views/item-list', 'views/item', 'views/textarea'], function(_, ItemListView, ItemView, TextareaView) {
  var ScriptsView;
  return ScriptsView = (function(_super) {
    __extends(ScriptsView, _super);

    function ScriptsView(options) {
      _.extend(this, _.pick(options, 'sesh'));
      ScriptsView.__super__.constructor.apply(this, arguments);
    }

    ScriptsView.prototype.label = "script";

    ScriptsView.prototype.itemView = function() {
      return ItemView.extend({
        attr: 'script',
        inputView: TextareaView,
        sesh: this.sesh
      });
    };

    return ScriptsView;

  })(ItemListView);
});
