var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['underscore', 'quilt'], function(_, Quilt) {
  var InputView;

  return InputView = (function(_super) {
    __extends(InputView, _super);

    function InputView(options) {
      _.extend(this, _.pick(options, 'attr'));
      InputView.__super__.constructor.apply(this, arguments);
    }

    InputView.prototype.initialize = function() {
      InputView.__super__.initialize.apply(this, arguments);
      return this.listenTo(this.model, 'edit', this.edit);
    };

    InputView.prototype.editJst = _.template("<input type='text' name='<%= view.attr %>' value='<%= model.get(view.attr) %>' data-input />\n<button class='btn' data-save>save</button>");

    InputView.prototype.viewJst = _.template("(<a href='javascript:void(0)' data-edit>edit</a>)\n(<a href='javascript:void(0)' data-destroy>delete</a>)");

    InputView.prototype.template = function() {
      return this.viewJst.apply(this, arguments);
    };

    InputView.prototype.events = {
      'click [data-edit]': 'edit',
      'click [data-save]': 'save',
      'keyup [data-input]': 'keyup'
    };

    InputView.prototype.render = function(jst) {
      if (jst) {
        this.template = jst;
      }
      return InputView.__super__.render.apply(this, arguments);
    };

    InputView.prototype.edit = function() {
      return this.render(this.editJst);
    };

    InputView.prototype.save = function() {
      this.model.save(this.attr, this.$('[data-input]').val());
      return this.render(this.viewJst);
    };

    InputView.prototype.keyup = function(e) {
      if (e.keyCode === 13) {
        return this.save();
      }
    };

    return InputView;

  })(Quilt.View);
});
