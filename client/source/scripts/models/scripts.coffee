define [
  'backbone'
  'models/script'
  'backbone-localstorage'
], (Backbone, Script) ->

  class Scripts extends Backbone.Collection

    localStorage: new Backbone.LocalStorage('scripts')

    model: Script
