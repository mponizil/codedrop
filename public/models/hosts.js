var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone', 'models/host', 'backbone-localstorage'], function(Backbone, Host) {
  var Hosts, _ref;

  return Hosts = (function(_super) {
    __extends(Hosts, _super);

    function Hosts() {
      _ref = Hosts.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Hosts.prototype.localStorage = new Backbone.LocalStorage('hosts');

    Hosts.prototype.model = Host;

    return Hosts;

  })(Backbone.Collection);
});
