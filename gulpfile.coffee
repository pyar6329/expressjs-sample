gulp = require 'gulp'
glob = require 'glob'
watch = require 'gulp-watch'
# livereload = require 'gulp-webserver'

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

# nodejs server files
# gls = require 'gulp-live-server'
# server = gls.new './bin/www'
nodemon = require 'gulp-nodemon'
livereload = require 'gulp-livereload'

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
  gulp.src ['./public/stylesheets/**/*.scss'
            '!./public/stylesheets/' + compileCSSFileName]
    .pipe sourcemaps.init
      loadMaps: true
    .pipe sass()
    .pipe concat(compileCSSFileName)
    .pipe minifyCss()
    .pipe sourcemaps.write('./')
    .pipe gulp.dest('build/stylesheets')

# gulp.task 'server:start', ->
#   server.start()
#
# gulp.task 'server:restart', ->
#   console.log 'server restarted'
#   server.start.bind(server)

gulp.task 'server', ->
  livereload.listen()
  # reloaded = undefined

  nodemon(
    script: './bin/www'
    ext: 'ect coffee js'
    ignore: ['public', 'build', 'app/views']
    env: {
      'NODE_ENV': 'development'
      'DEBUG': 'OoTalk_frontend'
    }
    stdout: false
    ).on 'restart', ->
      setTimeout (->
        gulp.src('./bin/www')
          .pipe(livereload())
      ), 250
  # ).on 'readable', ->
  #   @stdout.on 'data', (chunk) ->
  #     # if /\[nodemon\]\sstarting\s`node\s\.\/bin\/www`$/.test(chunk)
  #     if /^listening/.test(chunk)
  #       livereload.reload()
  #     process.stdout.write chunk

  gulp.watch(
    'public/javascripts/**/*.cjsx'
    ['browserify']
  ).on 'change', (event) ->
    livereload.changed event

  gulp.watch(
    'public/stylesheets/**/*.scss'
    ['sass']
  ).on 'change', (event) ->
    livereload.changed event

  gulp.watch(
    'app/views/*.ect'
  ).on 'change', (event) ->
    livereload.changed event

# gulp.task 'livereload', ->
#   gulp.src ['./public','./app']
#     .pipe livereload(livereload: true)

# gulp.task 'watch', ->
  # gulp.watch 'public/javascripts/**/*.cjsx', ['browserify']
  # gulp.watch 'public/stylesheets/**/*.scss', ['sass']
  # gulp.watch 'app/models/**/*.coffee', ['server:restart']
  # gulp.watch 'app/controllers/**/*.coffee', ['server:restart']
  # gulp.watch 'app/views/**/*.ect', ['server:restart']

gulp.task 'build', ['browserify', 'sass']
# gulp.task 'default', ['watch', 'livereload', 'server:restart']
gulp.task 'default', ['server']
