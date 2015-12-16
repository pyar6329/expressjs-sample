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
uglify = require 'gulp-uglify'

gulp.task 'browserify', ->
    srcFiles = [glob.sync('./public/javascripts/controllers/*.cjsx'),
                glob.sync('./public/javascripts/views/*.cjsx')]
    return browserify
            entries: srcFiles
            transform: ['coffee-reactify']
            #extensions: ['.coffee','.cjsx']
        .bundle()
        # .pipe uglify()
        .pipe source('application.js')
        .pipe gulp.dest('./public/javascripts')

gulp.task 'sass', ->
  compileCSSFileName = 'application.css'
  gulp.src ['./public/stylesheets/*.scss',
            '!./public/stylesheets/' + compileCSSFileName]
  # gulp.src './public/stylesheets/*.scss'
    .pipe sourcemaps.init()
    .pipe sass()
    .pipe concat(compileCSSFileName)
    .pipe minifyCss()
    .pipe sourcemaps.write('.')
    .pipe gulp.dest('./public/stylesheets')

gulp.task 'livereload', ->
  gulp.src './public'
    .pipe livereload(livereload: true)

gulp.task 'watch', ->
  gulp.watch 'public/javascripts/**/*.cjsx', ['browserify']
  gulp.watch 'public/stylesheets/**/*.scss', ['sass']

gulp.task 'default', ['watch', 'livereload']
