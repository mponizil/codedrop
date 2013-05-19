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
          name: 'almond'
          include: ['sesh']
          insertRequire: ['sesh']
          out: 'public/phat-sesh.js'
          paths:
            'cookie': 'cookie'
            'jquery': 'jquery-1.9.1'
            'underscore': 'underscore'
            'backbone': 'backbone'
            'backbone-localstorage': 'backbone.localstorage'
            'quilt': 'quilt'
            'list': 'list'
          optimize: 'none'
    watch:
      public:
        cwd: 'coffee'
        files: '**/*.coffee'
        tasks: ['coffee', 'requirejs']

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-requirejs')
  grunt.loadNpmTasks('grunt-contrib-watch')

  grunt.registerTask('default', ['watch'])
