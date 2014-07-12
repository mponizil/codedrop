module.exports = (grunt) ->

  grunt.initConfig
    coffee:
      public:
        options: bare: true
        expand: true
        cwd: 'client/source/scripts'
        src: ['**/*.coffee']
        dest: 'client/library/scripts'
        ext: '.js'
    requirejs:
      build:
        options:
          baseUrl: 'client/library/scripts'
          name: '../../vendor/almond'
          include: ['codedrop']
          out: 'public/scripts/codedrop.js'
          paths:
            'jquery': '../../vendor/jquery-1.9.1'
            'jquery-cookie': '../../vendor/jquery.cookie'
            'underscore': '../../vendor/underscore'
            'backbone': '../../vendor/backbone'
            'backbone-localstorage': '../../vendor/backbone.localstorage'
            'quilt': '../../vendor/quilt'
            'list': '../../vendor/list'
    compass:
      public:
        options:
          sassDir: 'client/source/styles'
          cssDir: 'public/styles'
          relativeAssets: true
          force: true
    watch:
      public:
        files: ['client/source/**/*.coffee', 'client/vendor/*.js']
        tasks: ['coffee', 'requirejs']

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-requirejs')
  grunt.loadNpmTasks('grunt-contrib-compass')
  grunt.loadNpmTasks('grunt-contrib-watch')

  grunt.registerTask('default', ['watch'])
  grunt.registerTask('all', ['coffee', 'requirejs', 'compass'])
  grunt.registerTask('js', ['coffee', 'requirejs'])
