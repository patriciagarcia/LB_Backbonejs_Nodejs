requirejs     = require('requirejs')
express       = require('express')
dust          = require('dustjs-linkedin')
request       = require('request')

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

requirejs ['models/blog', 'collections/posts', 'text!templates/blog.tmpl', 'text!templates/base.tmpl', 'appConfig'], (Blog, Posts, BlogTmpl, BaseTmpl, AppConfig) ->

  objects =
    blog: new Blog()

  # Register base template
  dust.loadSource(dust.compile(BaseTmpl, 'base'))

  app.get '/', (req, res) ->
    request AppConfig.LIVEBLOG_URL, (error, response, data) ->
      if (!error && response.statusCode == 200)
        # Parse the JSON to a Posts collection
        objects.posts = new Posts(JSON.parse(data), {parse: true})

        context =
          'notice': 'This was rendered from the backend'
          'length': objects.posts.length
          'posts' : objects.posts.toJSON()
          'post'  : (chunk, context, bodies) ->
            return chunk.map (chunk) ->
              chunk.render(bodies.block, context).end()

        dust.loadSource(dust.compile(BlogTmpl, 'blog'))
        dust.render 'blog', context, (err,out) ->
          res.send(out)

  port = 3000
  app.listen port, ->
    console.log('Listening on port %d', port)
