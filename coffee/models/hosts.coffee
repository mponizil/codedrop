define [
  'backbone'
  'models/host'
  'backbone-localstorage'
], (Backbone, Host) ->

  class Hosts extends Backbone.Collection

    localStorage: new Backbone.LocalStorage('hosts')

    model: Host
