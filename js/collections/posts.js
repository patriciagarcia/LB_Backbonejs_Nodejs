// Generated by CoffeeScript 1.6.3
(function() {
  define(['backbone', 'models/post', 'appConfig'], function(Backbone, Post, AppConfig) {
    return Backbone.Collection.extend({
      model: Post,
      url: AppConfig.LIVEBLOG_URL,
      parse: function(data) {
        return data.PostList;
      }
    });
  });

}).call(this);
