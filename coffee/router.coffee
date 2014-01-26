define ['backbone', 'views/blog'], (Backbone, BlogView) ->
  return Backbone.Router.extend
    routes:
      '*path': 'default'

    default: (path) ->
      blogView = new BlogView()
      $('.root').html(blogView.render().$el)
