var Add, _ref,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Quilt.patches.add = function(el, options) {
  return new Add({
    el: el,
    collection: this.collection
  });
};

Add = (function(_super) {
  __extends(Add, _super);

  function Add() {
    _ref = Add.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  Add.prototype.events = {
    'click': 'add'
  };

  Add.prototype.add = function(e) {
    var model;

    e.preventDefault();
    model = new this.collection.model;
    this.collection.add(model);
    return this.$el.trigger('add', [model]);
  };

  return Add;

})(Quilt.View);
