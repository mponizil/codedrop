var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['jquery', 'backbone'], function($, Backbone) {
  var Drop, _ref;

  return Drop = (function(_super) {
    __extends(Drop, _super);

    function Drop() {
      _ref = Drop.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Drop.prototype.idAttribute = 'subdomain';

    Drop.prototype.defaults = {
      host: 'www.bestbuy.com',
      script: '<script>alert("I am scriptorz")</script>',
      subdomain: ''
    };

    return Drop;

  })(Backbone.Model);
});
