define ['backbone', 'models/post'], (Backbone, Post) ->
  return Backbone.Collection.extend
    model: Post,
    url: 'http://master.sd-test.sourcefabric.org/resources/LiveDesk/Blog/1/Post/Published/?X-Filter=*&limit=1000',

    parse: (data) ->
      return data.PostList
