define ['backbone', 'text!templates/blog.tmpl', 'dust'], (Backbone, BlogTmpl) ->
  return Backbone.View.extend

    initialize: ->
      dust.loadSource(dust.compile(BlogTmpl, 'blog'))
      @.listenTo(@collection, 'reset', @render)
      @.listenTo(@collection, 'sync', @render)
      @.listenTo(@collection, 'change', @render)

    render: ->
      self = @

      context =
        'notice': 'This was rendered from the frontend'
        'length': @collection.length
        'posts' : @collection.toJSON()
        'post'  : (chunk, context, bodies) ->
          return chunk.map (chunk) ->
            chunk.render(bodies.block, context).end()

      dust.render 'blog', context, (err,out) ->
        self.$el.html(out)
