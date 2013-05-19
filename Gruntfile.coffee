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
    concat:
      'public/phat-sesh.js': [
        'public/jquery-1.9.1.js'
        'public/underscore.js'
        'public/backbone.js'
        'public/backbone.localstorage.js'
        'public/quilt.js'
        'public/list.js'
        'public/patches/*'
        'public/cookie.js'
        'public/sesh.js'
      ]
    watch:
      public:
        cwd: 'coffee'
        files: '**/*.coffee'
        tasks: ['coffee', 'concat']

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-concat')
  grunt.loadNpmTasks('grunt-contrib-watch')

  grunt.registerTask('default', ['watch'])
