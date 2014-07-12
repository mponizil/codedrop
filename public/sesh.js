define(['jquery', 'underscore', 'backbone', 'quilt', 'list', 'models/scripts', 'models/hosts', 'models/sesh', 'models/seshs', 'views/widget', 'views/configure', 'jquery-cookie', 'backbone-localstorage', 'patches/add', 'patches/destroy', 'patches/button-radio'], function($, _, Backbone, Quilt, List, Scripts, Hosts, Sesh, Seshs, WidgetView, ConfigureView) {
  var seshs;

  seshs = new Seshs;
  seshs.fetch();
  return $(function() {
    /*
    configureView = new ConfigureView({ el: '#configure', seshs })
    configureView.render()
    */

  });
});
