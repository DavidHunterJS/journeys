do ->
  'use strict'
  
  gulp         = require 'gulp'
  sass         = require 'gulp-sass'
  gutil        = require 'gulp-util'
  coffee       = require 'gulp-coffee'
  uglify       = require 'gulp-uglify'
  connect      = require 'gulp-connect'
  plumber      = require 'gulp-plumber'
  minifyCSS    = require 'gulp-minify-css'
  sourcemaps   = require 'gulp-sourcemaps'
  autoprefixer = require 'gulp-autoprefixer'


  gulp.task 'connect', ->
    connect.server
      port: 9000
      root: '../dist'
      livereload: true
    return
  
  
  gulp.task 'sas', ->
    gulp.src('styles/*.sass')
      .pipe(sourcemaps.init())
      .pipe(sass(
        indentedSyntax: true
        errLogToConsole: true
        )).on('error', sass.logError)
      .pipe(autoprefixer({
        browsers: ['last 2 versions']
      }))
      .pipe(sourcemaps.write('.'))
      .pipe(minifyCSS())
      .pipe(gulp.dest('../dist/css'))
      .pipe connect.reload()
  
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


  gulp.task 'watch', ->
    gulp.watch [ '*.html' ], [ 'html' ]
    gulp.watch [ './styles/*', './styles/*/*.sass' ], [ 'sas' ]
    gulp.watch [ 'js/*.js' ], [ 'js' ]
    # gulp.watch [ './coffee/*.coffee' ], [ 'coffeeTask' ]
    return
  
  gulp.task 'default', [
    'connect'
    'watch'
  ]
  return
