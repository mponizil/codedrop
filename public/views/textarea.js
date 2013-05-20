var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['underscore', 'views/input'], function(_, InputView) {
  var TextareaView, _ref;

  return TextareaView = (function(_super) {
    __extends(TextareaView, _super);

    function TextareaView() {
      _ref = TextareaView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    TextareaView.prototype.editJst = _.template("<textarea name='<%= view.attr %>' data-input><%= model.get(view.attr) %></textarea>\n<button class='btn' data-save>save</button>");

    return TextareaView;

  })(InputView);
});
