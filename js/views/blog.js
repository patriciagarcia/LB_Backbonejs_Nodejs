// Generated by CoffeeScript 1.6.3
(function() {
  define(['backbone', 'text!templates/blog.tmpl'], function(Backbone, BlogTmpl) {
    return Backbone.View.extend({
      render: function() {
        this.$el.html('Backbone is working');
        return this;
      }
    });
  });

}).call(this);
