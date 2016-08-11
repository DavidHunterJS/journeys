do ->
  'use strict'
  
  gulp         = require 'gulp'
  sass         = require 'gulp-sass'
  gutil        = require 'gulp-util'
  coffee       = require 'gulp-coffee'
  uglify       = require 'gulp-uglify'
  connect      = require 'gulp-connect'
  plumber      = require 'gulp-plumber'
  cleanCSS     = require 'gulp-clean-css'
  sourcemaps   = require 'gulp-sourcemaps'
  autoprefixer = require 'gulp-autoprefixer'


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
  
  gulp.task 'sask', ->
    gulp.src('styles/*.sass')
      .pipe(sourcemaps.init())
      .pipe(sass(
        indentedSyntax: true
        errLogToConsole: true
        )).on('error', sass.logError)
      .pipe(autoprefixer({
        browsers: ['last 2 versions']
      }))
      .pipe(cleanCSS())
      .pipe(sourcemaps.write('.'))
      .pipe(gulp.dest('../dist/css'))
      .pipe connect.reload()

  gulp.task 'coffee', ->
    gulp.src('./scripts/*.coffee')
      .pipe(plumber())
      .pipe(coffee({bare: true}).on('error', gutil.log))
      .pipe(gulp.dest('./dev-js'))
      .pipe(uglify())
      .pipe(gulp.dest('../dist/scripts'))
      .pipe connect.reload()

  gulp.task 'watch', ->
    gulp.watch [ './*.html'], ['html']
    gulp.watch [ './styles/*', './styles/*/*.sass' ], [ 'sask' ]
    gulp.watch [ './scripts/*.coffee' ], [ 'coffee' ]
    return
  
  gulp.task 'default', [
    'connect'
    'watch'
  ]
  return
