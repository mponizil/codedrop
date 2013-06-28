var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['jquery', 'backbone'], function($, Backbone) {
  var Sesh, _ref;
  return Sesh = (function(_super) {
    __extends(Sesh, _super);

    function Sesh() {
      _ref = Sesh.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Sesh.prototype.defaults = {
      host: 'www.bestbuy.com',
      script: '<script>alert("I am scriptorz")</script>',
      subdomain: ''
    };

    Sesh.prototype.syncX = function(method, model, options) {
      var attrs, key, value, _i, _len, _ref1, _ref2;
      if (method === 'create' || method === 'update') {
        _ref1 = model.attributes;
        for (key in _ref1) {
          value = _ref1[key];
          $.cookie(key, value);
        }
        return options.success(model.attributes);
      } else if (method === 'read') {
        attrs = {};
        _ref2 = ['host', 'script'];
        for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
          key = _ref2[_i];
          if (value = $.cookie(key)) {
            attrs[key] = value;
          }
        }
        return options.success(attrs);
      }
    };

    return Sesh;

  })(Backbone.Model);
});
