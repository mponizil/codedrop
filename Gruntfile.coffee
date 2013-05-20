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
            'jquery': 'vendor/jquery-1.9.1'
            'jquery-cookie': 'vendor/jquery.cookie'
            'underscore': 'vendor/underscore'
            'backbone': 'vendor/backbone'
            'backbone-localstorage': 'vendor/backbone.localstorage'
            'quilt': 'vendor/quilt'
            'list': 'vendor/list'
    watch:
      public:
        files: ['coffee/**/*.coffee', 'public/vendor/*.js']
        tasks: ['coffee', 'requirejs']
    compass:
      public:
        options:
          sassDir: 'scss'
          cssDir: 'public/css'
          relativeAssets: true

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-requirejs')
  grunt.loadNpmTasks('grunt-contrib-compass')
  grunt.loadNpmTasks('grunt-contrib-watch')

  grunt.registerTask('default', ['watch'])
  grunt.registerTask('all', ['coffee', 'requirejs', 'compass'])
  grunt.registerTask('js', ['coffee', 'requirejs'])
