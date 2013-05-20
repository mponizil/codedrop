var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['underscore', 'quilt', 'list', 'views/item'], function(_, Quilt, List, ItemView) {
  var ItemListView;

  return ItemListView = (function(_super) {
    __extends(ItemListView, _super);

    function ItemListView(options) {
      _.extend(this, _.pick(options, 'label', 'itemView'));
      ItemListView.__super__.constructor.apply(this, arguments);
    }

    ItemListView.prototype.label = 'item';

    ItemListView.prototype.itemView = ItemView;

    ItemListView.prototype.template = function() {
      return "<h4>Choose " + this.label + "</h4>\n<div data-ref='list'></div>\n<button class='btn' data-add>+ add new</button>";
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
});
