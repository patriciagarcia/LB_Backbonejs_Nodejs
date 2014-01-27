define ['backbone', 'collections/posts', 'views/blog', 'text!templates/base.tmpl', 'dust'], (Backbone, Posts, BlogView, BaseTmpl) ->
  return Backbone.Router.extend
    routes:
      '*path': 'default'

    initialize: ->
      #Register base template
      dust.loadSource(dust.compile(BaseTmpl, 'base'))

    default: (path) ->
      posts = new Posts()
      blogView = new BlogView({ collection: posts, el: '.liveblog' })
      posts.fetch()
