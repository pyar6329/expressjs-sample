gulp = require('gulp')
glob = require('glob')
watch = require('gulp-watch')
livereload = require('gulp-webserver')

browserify = require('browserify')
source = require('vinyl-source-stream')

gulp.task 'browserify', ->
    srcFiles = [glob.sync('./public/javascripts/controllers/*.cjsx'),
                glob.sync('./public/javascripts/views/*.cjsx')]
    return browserify
            entries: srcFiles
            transform: ['coffee-reactify']
            #extensions: ['.coffee','.cjsx']
        .bundle()
        .pipe source('application.js')
        .pipe gulp.dest('./public/javascripts')

gulp.task 'livereload', ->
  gulp.src './public'
    .pipe livereload(livereload: true)

gulp.task 'watch', ->
  gulp.watch 'public/javascripts/**/*.cjsx', ['browserify']

gulp.task 'default', ['browserify', 'watch', 'livereload']
