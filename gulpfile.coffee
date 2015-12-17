gulp = require 'gulp'
glob = require 'glob'
watch = require 'gulp-watch'
livereload = require 'gulp-webserver'

# CSS require files
sass = require 'gulp-sass'
sourcemaps = require 'gulp-sourcemaps'
minifyCss = require 'gulp-minify-css'
concat = require 'gulp-concat'

# coffee require files
browserify = require 'browserify'
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'
uglify = require 'gulp-uglify'

gulp.task 'browserify', ->
    srcFiles = [glob.sync('./public/javascripts/**/*.cjsx'),
                glob.sync('./public/javascripts/**/*.coffee')]
    browserify
            entries: srcFiles
            debug: true
            extensions: ['.coffee','.cjsx']
            transform: ['coffee-reactify']
      .bundle()
      .pipe source('application.js')
      .pipe buffer()
      .pipe sourcemaps.init
        loadMaps: true
      .pipe uglify()
      .pipe sourcemaps.write('./')
      .pipe gulp.dest('build/javascripts')

gulp.task 'sass', ->
  compileCSSFileName = 'application.css'
  gulp.src ['./public/stylesheets/*.scss',
            '!./public/stylesheets/' + compileCSSFileName]
    .pipe sourcemaps.init
      loadMaps: true
    .pipe sass()
    .pipe concat(compileCSSFileName)
    .pipe minifyCss()
    .pipe sourcemaps.write('./')
    .pipe gulp.dest('build/stylesheets')

gulp.task 'livereload', ->
  gulp.src './public'
    .pipe livereload(livereload: true)

gulp.task 'watch', ->
  gulp.watch 'public/javascripts/**/*.cjsx', ['browserify']
  gulp.watch 'public/stylesheets/**/*.scss', ['sass']

gulp.task 'build', ['browserify', 'sass']
gulp.task 'default', ['watch', 'livereload']
