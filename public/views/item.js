var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['underscore', 'quilt', 'views/input'], function(_, Quilt, InputView) {
  var ItemView;
  return ItemView = (function(_super) {
    __extends(ItemView, _super);

    function ItemView(options) {
      _.extend(this, _.pick(options, 'attr', 'inputView', 'sesh'));
      if (this.inputView == null) {
        this.inputView = InputView;
      }
      ItemView.__super__.constructor.apply(this, arguments);
    }

    ItemView.prototype.master = function() {
      return this.sesh;
    };

    ItemView.prototype.template = function() {
      return "<span data-button-radio>\n  <input type='radio' name='" + this.attr + "' data-attrs='{\"value\":\"" + this.attr + "\"}' />\n  <button class='btn' data-escape='" + this.attr + "'></button>\n</span>\n<span data-ref='input'></span>";
    };

    ItemView.prototype.render = function() {
      ItemView.__super__.render.apply(this, arguments);
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
