var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone'], function(Backbone) {
  var Script, _ref;

  return Script = (function(_super) {
    __extends(Script, _super);

    function Script() {
      _ref = Script.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Script.prototype.defaults = {
      script: '<script>alert("some dope js")</script>'
    };

    return Script;

  })(Backbone.Model);
});
