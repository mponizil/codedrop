var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['underscore', 'quilt', 'views/configure'], function(_, Quilt, ConfigureView) {
  var WidgetView;
  return WidgetView = (function(_super) {
    __extends(WidgetView, _super);

    function WidgetView(options) {
      _.extend(this, _.pick(options, 'hosts', 'scripts', 'sesh'));
      WidgetView.__super__.constructor.apply(this, arguments);
    }

    WidgetView.prototype.template = function() {
      return "<button class='btn btn-small' data-toggle>Toggle</button>\n<div data-ref='configure'></div>";
    };

    WidgetView.prototype.events = {
      'click [data-toggle]': 'toggle'
    };

    WidgetView.prototype.render = function() {
      WidgetView.__super__.render.apply(this, arguments);
      this.views.push(new ConfigureView({
        el: this.$configure,
        hosts: this.hosts,
        scripts: this.scripts,
        sesh: this.sesh
      }).render());
      this.$configure.slideUp(0);
      return this;
    };

    WidgetView.prototype.toggle = function() {
      return this.$configure.slideToggle();
    };

    return WidgetView;

  })(Quilt.View);
});
