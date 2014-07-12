define [
  'models/drops'
  'views/configure'
  'patches/all'
], (Drops, ConfigureView) ->

  (dropsJSON) ->

    drops = new Drops(dropsJSON)
    drops.fetch()
    configureView = new ConfigureView({ el: '#configure', drops })
    configureView.render()
