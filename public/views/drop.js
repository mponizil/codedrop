var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['underscore', 'quilt'], function(_, Quilt) {
  var DropView;

  return DropView = (function(_super) {
    __extends(DropView, _super);

    DropView.prototype.tagName = 'tr';

    function DropView(_arg) {
      this.model = _arg.model;
      this.model.on('change', this.render, this);
      DropView.__super__.constructor.apply(this, arguments);
    }

    DropView.prototype.template = function() {
      return "<td>" + (this.model.get('host')) + "</td>\n<td>" + (_.escape(this.model.get('script'))) + "</td>\n<td><a href=\"//" + (this.model.get('subdomain')) + "." + location.host + "/\">" + (this.model.get('subdomain')) + "</a></td>\n<td><button class=\"btn\" data-destroy>delete</button></td>";
    };

    return DropView;

  })(Quilt.View);
});
