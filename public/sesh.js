define(['jquery', 'underscore', 'backbone', 'quilt', 'list', 'models/scripts', 'models/hosts', 'models/sesh', 'views/widget', 'views/configure', 'jquery-cookie', 'backbone-localstorage', 'patches/add', 'patches/destroy'], function($, _, Backbone, Quilt, List, Scripts, Hosts, Sesh, WidgetView, ConfigureView) {
  var hosts, scripts, sesh;

  scripts = new Scripts;
  scripts.fetch();
  hosts = new Hosts;
  hosts.fetch();
  sesh = new Sesh;
  sesh.fetch();
  return $(function() {
    var $widget, configureView, widgetView;

    if ($.cookie('host')) {
      $widget = $("<div class='proxy-sesh-widget proxy-sesh-configure'>");
      $widget.appendTo('body');
      $("<link href='/public/css/style.css' rel='stylesheet' />").appendTo('head');
      widgetView = new WidgetView({
        el: $widget,
        scripts: scripts,
        hosts: hosts,
        sesh: sesh
      });
      return widgetView.render();
    } else {
      configureView = new ConfigureView({
        el: '#configure',
        scripts: scripts,
        hosts: hosts,
        sesh: sesh
      });
      return configureView.render();
    }
  });
});
