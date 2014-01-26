// Generated by CoffeeScript 1.6.3
(function() {
  var app, dust, express, requirejs;

  requirejs = require('requirejs');

  express = require('express');

  dust = require('dustjs-linkedin');

  app = express();

  app.configure(function() {
    return app.use(express["static"](__dirname + '/..'));
  });

  requirejs.config({
    paths: {
      templates: '../templates'
    },
    packages: [
      {
        name: 'text',
        location: '../node_modules/text',
        main: 'text.js'
      }
    ],
    nodeRequire: require
  });

  requirejs(['models/blog', 'text!templates/blog.tmpl'], function(Blog, BlogTmpl) {
    var models, port;
    models = {
      blog: new Blog()
    };
    app.get('/', function(req, res) {
      var compiledTmpl;
      compiledTmpl = dust.compile(BlogTmpl, 'blog');
      dust.loadSource(compiledTmpl);
      return dust.render('blog', models.blog.toJSON(), function(err, out) {
        return res.send(out);
      });
    });
    port = 3000;
    return app.listen(port, function() {
      return console.log('Listening on port %d', port);
    });
  });

}).call(this);