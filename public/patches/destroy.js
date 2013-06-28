var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['quilt'], function(Quilt) {
  var Destroy, _ref;
  Quilt.patches.destroy = function(el, options) {
    return new Destroy({
      el: el,
      model: this.model
    });
  };
  return Destroy = (function(_super) {
    __extends(Destroy, _super);

    function Destroy() {
      _ref = Destroy.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Destroy.prototype.events = function() {
      return {
        'click': 'click'
      };
    };

    Destroy.prototype.render = function() {
      return this;
    };

    Destroy.prototype.confirm = function(next) {
      if (confirm('Are you sure?')) {
        return next();
      }
    };

    Destroy.prototype.click = function(e) {
      var _this = this;
      e.preventDefault();
      return this.confirm(function() {
        return _this.model.destroy({
          wait: true
        });
      });
    };

    return Destroy;

  })(Quilt.View);
});
