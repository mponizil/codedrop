var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone', 'models/drop'], function(Backbone, Drop) {
  var Drops, _ref;

  return Drops = (function(_super) {
    __extends(Drops, _super);

    function Drops() {
      _ref = Drops.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Drops.prototype.model = Drop;

    Drops.prototype.url = '/drops';

    return Drops;

  })(Backbone.Collection);
});
