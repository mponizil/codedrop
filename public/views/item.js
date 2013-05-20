var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['underscore', 'quilt', 'views/radio', 'views/input'], function(_, Quilt, RadioView, InputView) {
  var ItemView;

  return ItemView = (function(_super) {
    __extends(ItemView, _super);

    function ItemView(options) {
      var _ref;

      _.extend(this, _.pick(options, 'attr', 'inputView'));
      if ((_ref = this.inputView) == null) {
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
});
