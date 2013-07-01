var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['underscore', 'quilt'], function(_, Quilt) {
  var SeshsView;
  return SeshsView = (function(_super) {
    __extends(SeshsView, _super);

    function SeshsView(_arg) {
      this.sesh = _arg.sesh;
      SeshsView.__super__.constructor.apply(this, arguments);
    }

    return SeshsView;

  })(Quilt.View);
});
