module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    coffee:
      glob_to_multiple:
        expand: true
        cwd: 'src'
        src: ['*.coffee']
        dest: 'lib'
        ext: '.js'

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.registerTask 'clean', -> require('rimraf').sync('lib')
  grunt.registerTask('default', ['coffee'])
