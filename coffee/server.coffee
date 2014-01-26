requirejs     = require('requirejs')
express       = require('express')
dust          = require('dustjs-linkedin')
request       = require('request')
LIVEBLOG_URL  = 'http://master.sd-test.sourcefabric.org/resources/LiveDesk/Blog/1/Post/Published/?X-Filter=*&limit=1000'

app = express()

# Serve static files
app.configure ->
  app.use(express.static(__dirname + '/..'))

requirejs.config
  paths:
    templates: '../templates'
  
  packages: [
    name: 'text'
    location: '../node_modules/text',
    main: 'text.js'
  ],

  # Pass the top-level main.js/index.js require
  # function to requirejs so that node modules
  # are loaded relative to the top-level JS file.
  nodeRequire: require

requirejs ['models/blog', 'collections/posts', 'text!templates/blog.tmpl', 'text!templates/post.tmpl'], (Blog, Posts, BlogTmpl, PostTmpl) ->

  objects =
    blog: new Blog()

  app.get('/', (req, res) ->
    request LIVEBLOG_URL, (error, response, data) ->
      if (!error && response.statusCode == 200)
        objects.posts = new Posts(JSON.parse(data), {parse: true})
    
        dust.loadSource(dust.compile(PostTmpl, 'post'))
        dust.render('post', objects.posts.first().toJSON(), (err,out) ->
          res.send(out)
        )
    #compiledTmpl = dust.compile(BlogTmpl, 'blog')
    #dust.loadSource(compiledTmpl)
    #dust.render('blog', models.blog.toJSON(), (err,out) ->
      #res.send(out)
    #)
  )

  port = 3000
  app.listen port, ->
    console.log('Listening on port %d', port)
