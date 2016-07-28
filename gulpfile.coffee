gulp    = require 'gulp'
coffee  = require 'gulp-coffee'
sass    = require 'gulp-sass'
plumber = require 'gulp-plumber'

coffeePipeline = (base) ->
    ->
        gulp.src ["#{base}/**/*.coffee"]
            .pipe plumber()
            .pipe coffee()
            .pipe gulp.dest "./#{base}"

gulp.task 'coffee-assets', coffeePipeline('assets')
gulp.task 'coffee-spec', coffeePipeline('spec')

gulp.task 'sass', ->
    gulp.src 'assets/*.scss'
    .pipe plumber()
    .pipe sass()
    .pipe gulp.dest 'assets/'

gulp.task 'build', ['coffee-assets', 'coffee-spec', 'sass']

gulp.task 'watch', ['build'], ->
    gulp.watch ['assets/*', 'spec/*'], ['build']
