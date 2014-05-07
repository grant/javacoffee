gulp = require 'gulp'
gutil = require 'gulp-util'
watch = require 'gulp-watch'
coffee = require 'gulp-coffee'
plumber = require 'gulp-plumber'
coffeelint = require 'gulp-coffeelint'

src =
  coffee: ['src/**/*.coffee']

dest =
  coffee: 'lib'

gulp.task 'coffee', ->
  # Lint
  console.log '\nLinting coffeescript...\n'
  gulp.src src.coffee
    .pipe coffeelint()
    .pipe coffeelint.reporter()

gulp.task 'watch', ->
  gulp.watch src.coffee, ['coffee']

gulp.task 'default', ['coffee', 'watch']