module.exports = (grunt) ->

  grunt.initConfig
    coffee:
      public:
        options: bare: true
        expand: true
        cwd: 'coffee'
        src: ['**/*.coffee']
        dest: 'public'
        ext: '.js'
    requirejs:
      compile:
        options:
          baseUrl: 'public'
          name: 'vendor/almond'
          include: ['sesh']
          insertRequire: ['sesh']
          out: 'public/phat-sesh.js'
          paths:
            'cookie': 'vendor/cookie'
            'jquery': 'vendor/jquery-1.9.1'
            'underscore': 'vendor/underscore'
            'backbone': 'vendor/backbone'
            'backbone-localstorage': 'vendor/backbone.localstorage'
            'quilt': 'vendor/quilt'
            'list': 'vendor/list'
          optimize: 'none'
    watch:
      public:
        files: ['coffee/**/*.coffee', 'public/vendor/*.js']
        tasks: ['coffee', 'requirejs']

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-requirejs')
  grunt.loadNpmTasks('grunt-contrib-watch')

  grunt.registerTask('default', ['watch'])
