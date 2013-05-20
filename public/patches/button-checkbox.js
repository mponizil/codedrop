var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['underscore', 'quilt'], function(_, Quilt) {
  var ButtonCheckbox;

  Quilt.patches.buttonCheckbox = function(el, options) {
    var attr;

    attr = $(el).attr('name');
    return new ButtonCheckbox({
      el: el,
      model: this.model,
      attr: attr
    });
  };
  return ButtonCheckbox = (function(_super) {
    __extends(ButtonCheckbox, _super);

    function ButtonCheckbox(options) {
      _.extend(this, _.pick(options, 'attr'));
      ButtonCheckbox.__super__.constructor.apply(this, arguments);
    }

    ButtonCheckbox.prototype.initialize = function() {
      ButtonCheckbox.__super__.initialize.apply(this, arguments);
      return this.listenTo(this.model, "change:" + this.attr, this.render);
    };

    ButtonCheckbox.prototype.events = {
      'click': 'toggle'
    };

    ButtonCheckbox.prototype.render = function() {};

    ButtonCheckbox.prototype.toggle = function() {
      var value;

      value = this.model.get(this.attr);
      return this.model.set(this.attr, !value);
    };

    return ButtonCheckbox;

  })(Quilt.View);
});
