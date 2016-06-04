do ->
  'use strict'
  
  gulp         = require 'gulp'
  gutil        = require 'gulp-util'
  plumber      = require 'gulp-plumber'
  connect      = require 'gulp-connect'
  coffee       = require 'gulp-coffee'
  uglify       = require 'gulp-uglify'


  gulp.task 'connect', ->
    connect.server
      port: 9000
      root: '../dist'
      livereload: true
    return
  
  gulp.task 'html', ->
    gulp.src('*.html')
      .pipe(gulp.dest('../dist'))
      .pipe connect.reload()
  
  
  gulp.task 'js', ->
    gulp.src('js/*.js')
      .pipe(plumber())
      .pipe(uglify())
      .pipe(gulp.dest('../dist/js'))
      .pipe connect.reload()
  
  gulp.task 'css', ->
    gulp.src('css/*.css')
      .pipe(plumber())
      .pipe(gulp.dest('../dist/css'))
      .pipe connect.reload()

  # CSS-TO-SASS
  ###gulp.task 'sass', ->
  gulp.src('*.sass')
    .pipe(sass(
      indentedSyntax: true
      errLogToConsole: true
    )).on('error', gutil.log)
    .pipe(gulp.dest('../dist/css/'))
    .pipe connect.reload()###

  ###gulp.task 'coffeeTask', ->
    gulp.src('./coffee/*.coffee')
      .pipe(plumber())
      .pipe(coffee({bare: true}).on('error', gutil.log))
      .pipe(gulp.dest('../dist/js/'))
      .pipe connect.reload()###
  
  gulp.task 'watch', ->
    gulp.watch [ '*.html' ], [ 'html' ]
    gulp.watch [ './css/*.css' ], [ 'css' ]
    gulp.watch [ 'js/*.js' ], [ 'js' ]
    # gulp.watch [ './coffee/*.coffee' ], [ 'coffeeTask' ]
    return
  
  gulp.task 'default', [
    'connect'
    'watch'
  ]
  return
