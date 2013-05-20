var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['jquery', 'underscore', 'quilt'], function($, _, Quilt) {
  var ButtonRadio;

  Quilt.patches.buttonRadio = function(el, options) {
    var $button, $radio, attr, master;

    master = _.result(this, 'master');
    $radio = $(el).children('input:radio');
    $button = $(el).children('button');
    attr = $radio.attr('name');
    return new ButtonRadio({
      el: el,
      model: this.model,
      master: master,
      $radio: $radio,
      $button: $button,
      attr: attr
    });
  };
  return ButtonRadio = (function(_super) {
    __extends(ButtonRadio, _super);

    function ButtonRadio(options) {
      _.extend(this, _.pick(options, 'master', '$radio', '$button', 'attr'));
      ButtonRadio.__super__.constructor.apply(this, arguments);
    }

    ButtonRadio.prototype.initialize = function() {
      ButtonRadio.__super__.initialize.apply(this, arguments);
      this.$radio.addClass('hide');
      if (this.master) {
        return this.listenTo(this.master, "change:" + this.attr, this.render);
      } else {
        return this.listenTo(this.model, "change:" + this.attr, this.render);
      }
    };

    ButtonRadio.prototype.events = {
      'click button': 'toggle'
    };

    ButtonRadio.prototype.render = function() {
      var chosen;

      if (this.master) {
        chosen = this.model.get(this.attr) === this.master.get(this.attr);
      } else {
        chosen = this.model.get(this.attr) === 'true';
      }
      if (chosen) {
        this.$radio.prop('checked', 'checked');
      } else {
        this.$radio.removeProp('checked');
      }
      this.$button.toggleClass('active', chosen);
      return this;
    };

    ButtonRadio.prototype.toggle = function(e) {
      var value;

      if (e != null) {
        e.stopPropagation();
      }
      if (this.master) {
        value = this.model.get(this.attr);
        this.master.set(this.attr, value);
      } else {
        value = this.model.get(this.attr);
        this.model.set(this.attr, !value);
      }
      return false;
    };

    return ButtonRadio;

  })(Quilt.View);
});
