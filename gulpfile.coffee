gulp = require('gulp')
glob = require('glob')

browserify = require('browserify')
source = require('vinyl-source-stream')

gulp.task 'default', ->
    srcFiles = [glob.sync('./public/javascripts/controllers/*.coffee'),
                glob.sync('./public/javascripts/views/*.cjsx')]
    return browserify
            entries: srcFiles
            transform: ['coffee-reactify']
            #extensions: ['.coffee','.cjsx']
        .bundle()
        .pipe source('application.js')
        .pipe gulp.dest('./public/javascripts')
