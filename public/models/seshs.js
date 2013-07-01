var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone', 'models/sesh'], function(Backbone, Sesh) {
  var Seshs, _ref;
  return Seshs = (function(_super) {
    __extends(Seshs, _super);

    function Seshs() {
      _ref = Seshs.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Seshs.prototype.model = Sesh;

    Seshs.prototype.url = '/seshs';

    return Seshs;

  })(Backbone.Collection);
});
