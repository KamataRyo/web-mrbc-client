import gulp       from 'gulp'
import sourcemaps from 'gulp-sourcemaps'
import sass       from 'gulp-sass'
import babel      from 'gulp-babel'
import concat     from 'gulp-concat'
import plumber    from 'gulp-plumber'


gulp.task('babel', () => {
    return gulp.src('src/**/*.js')
        .pipe(plumber())
        .pipe(sourcemaps.init())
        .pipe(babel())
        .pipe(concat('all.js'))
        .pipe(sourcemaps.write('.'))
        .pipe(gulp.dest('dist'))
})

gulp.task('sass', () => {
    return gulp.src('src/**/*.scss')
        .pipe(plumber())
        .pipe(sass())
        .pipe(gulp.dest('dist'))
})

gulp.task('build', ['babel', 'sass'])

gulp.task('watch', ['build'], () => {
    gulp.watch(['src/*', 'spec/*'], ['build'])
})