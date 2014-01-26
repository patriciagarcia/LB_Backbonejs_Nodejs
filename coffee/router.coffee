define ['backbone', 'views/blog', 'collections/posts', 'views/posts'], (Backbone, BlogView, Posts, PostsView) ->
  return Backbone.Router.extend
    routes:
      '*path': 'default'

    default: (path) ->
      posts = new Posts()
      postsView = new PostsView({ collection: posts })
      postsView.render()
      posts.fetch()
