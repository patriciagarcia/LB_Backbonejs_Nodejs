define ['backbone', 'text!templates/blog.tmpl'], (Backbone, BlogTmpl) ->
  return Backbone.View.extend
    render: ->
      @.$el.html('Backbone is working')
      @
