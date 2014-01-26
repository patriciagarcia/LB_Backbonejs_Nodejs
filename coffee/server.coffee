requirejs     = require('requirejs')
express       = require('express')
dust          = require('dustjs-linkedin')

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

requirejs ['models/blog', 'text!templates/blog.tmpl'], (Blog, BlogTmpl) ->

  models =
    blog: new Blog()

  app.get('/', (req, res) ->
    compiledTmpl = dust.compile(BlogTmpl, 'blog')
    dust.loadSource(compiledTmpl)
    dust.render('blog', models.blog.toJSON(), (err,out) ->
      res.send(out)
    )
  )

  port = 3000
  app.listen port, ->
    console.log('Listening on port %d', port)
