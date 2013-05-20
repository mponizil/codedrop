var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['underscore', 'quilt'], function(_, Quilt) {
  var RadioView;

  return RadioView = (function(_super) {
    __extends(RadioView, _super);

    function RadioView(options) {
      _.extend(this, _.pick(options, 'attr'));
      RadioView.__super__.constructor.apply(this, arguments);
    }

    RadioView.prototype.initialize = function() {
      RadioView.__super__.initialize.apply(this, arguments);
      return this.listenTo(this.model, "change:" + this.attr, this.render);
    };

    RadioView.prototype.template = _.template("<input type='radio' name='<%= view.attr %>' value='<%= _.escape(model.get(view.attr)) %>' />");

    return RadioView;

  })(Quilt.View);
});
