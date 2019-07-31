jade          = require 'gulp-jade'
gif           = require 'gulp-if'
gutil         = require 'gulp-util'
htmlmin       = require 'gulp-htmlmin'
livereload    = require 'gulp-livereload'
plumber       = require 'gulp-plumber'
replace       = require 'gulp-replace-task'

module.exports = (gulp, config) ->
  gulp.task 'compile:jade', ->
    gulp.src config.input.jade
    .pipe plumber()
    .on 'error', gutil.log
    .pipe gif config.input.replace.enabled, replace config.input.replace
    .pipe jade
      pretty: not config.minify
      locals: config.jade.locals
    .pipe gif config.minify, htmlmin
      collapseWhitespace: true
      removeComments: true
    .pipe gulp.dest config.output.path
    .pipe livereload()
