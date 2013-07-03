var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone', 'models/script', 'backbone-localstorage'], function(Backbone, Script) {
  var Scripts, _ref;
  return Scripts = (function(_super) {
    __extends(Scripts, _super);

    function Scripts() {
      _ref = Scripts.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Scripts.prototype.localStorage = new Backbone.LocalStorage('scripts');

    Scripts.prototype.model = Script;

    return Scripts;

  })(Backbone.Collection);
});
