module.exports = function(grunt){
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    requirejs: {
      compile: {
        options: {
          mainConfigFile: 'js/main.js',
          baseUrl: 'js/',
          name: '../bower_components/almond/almond',
          include: ['main'],
          out: 'build/app.min.js',
        }
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-requirejs');

  grunt.registerTask('default', ['requirejs']);
}
