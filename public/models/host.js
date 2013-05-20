var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone'], function(Backbone) {
  var Host, _ref;

  return Host = (function(_super) {
    __extends(Host, _super);

    function Host() {
      _ref = Host.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Host.prototype.defaults = {
      host: 'herpderp.com'
    };

    return Host;

  })(Backbone.Model);
});
