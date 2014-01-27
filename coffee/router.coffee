define ['backbone', 'views/blog', 'collections/posts'], (Backbone, BlogView, Posts) ->
  return Backbone.Router.extend
    routes:
      '*path': 'default'

    default: (path) ->
      posts = new Posts()
      blogView = new BlogView({ collection: posts, el: '.liveblog' })
      posts.fetch()
