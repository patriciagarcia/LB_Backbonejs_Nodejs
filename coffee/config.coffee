require.config
  paths:
    jquery: '../bower_components/jquery/jquery.min'
    underscore: '../node_modules/underscore/underscore-min'
    backbone: '../node_modules/backbone/backbone-min'
    dust: '../node_modules/dustjs-linkedin/dist/dust-full.min'
    text: '../node_modules/text/text'
    templates: '../templates'

  shim:
    underscore:
      exports: '_'
    backbone:
      deps: ['underscore', 'jquery']
      exports: 'Backbone'
    dust:
      exports: 'dust'

require ['router'], (Router) ->
  $ ->
    router = new Router()
    Backbone.history.start({ pushState: true })
