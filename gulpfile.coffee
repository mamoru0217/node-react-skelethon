gulp          = require 'gulp'
gulpIf        = require 'gulp-if'
sass          = require 'gulp-sass'
autoprefixer  = require 'gulp-autoprefixer'
webpack       = require 'gulp-webpack'
webpackConfig = require './webpack.config.coffee'
nodemon       = require 'gulp-nodemon'
jshint        = require 'gulp-jshint'
browserSync   = require 'browser-sync'

gulp.task 'nodemon', (cb) ->
  called = false
  nodemon(script: 'server.coffee', watch: 'server.coffee')
    .on 'start', ->
      if !called
        cb()
      caled = true
    .on 'restart', ->
      setTimeout (->
        browserSync.reload()
          stream: false
      ), 500

gulp.task 'browserSync', ['nodemon'], ->
    browserSync(
      files: ['public/**/*.*']
      proxy: 'http://localhost:5000'
      port: 4000
      browser: ['google chrome']
    )

gulp.task 'lint', ->
  gulp.src '*.js'
    .pipe jshint()

gulp.task 'js', ->
  gulp.src ''
    .pipe webpack(webpackConfig)
    .pipe gulp.dest ''

gulp.task 'sass', ->
  gulp.src './src/scss/**/*.scss'
    .pipe sass()
    .pipe autoprefixer()
    .pipe gulp.dest './public/css'

gulp.task 'watch', ['browserSync'], ->
  gulp.watch ['./src/scss/**/*.scss'], ['sass']
  gulp.watch ['./src/script/**/*.js'], ['js']

gulp.task 'build', ['js', 'sass']

gulp.task 'default', ['watch']
