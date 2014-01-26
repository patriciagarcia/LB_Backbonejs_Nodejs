define ['backbone', 'dust', 'text!templates/post.tmpl'], (Backbone, Dust, PostTmpl) ->
  return Backbone.View.extend
    #el: '.root'

    initialize: ->
      dust.loadSource(dust.compile(PostTmpl, 'postTmpl'))
      @.listenTo(@collection, 'reset', @render)
      @.listenTo(@collection, 'sync', @render)
      @.listenTo(@collection, 'change', @render)

    render: ->
      @.$el.empty()
      @collection.forEach(@renderPost, @)
      @

    renderPost: (post) ->
      self = @
      dust.render 'postTmpl', post.toJSON(), (err, out) ->
        self.$el.append(out)
