define ['backbone', 'models/post', 'appConfig'], (Backbone, Post, AppConfig) ->
  return Backbone.Collection.extend
    model: Post
    url: AppConfig.LIVEBLOG_URL

    parse: (data) ->
      return data.PostList
