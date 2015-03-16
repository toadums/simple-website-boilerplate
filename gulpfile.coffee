gulp =            require 'gulp'
coffee =          require 'gulp-coffee'
concat =          require 'gulp-concat'
jade =            require 'gulp-jade'
sass =            require 'gulp-sass'
connect =         require 'gulp-connect'
gutil =           require 'gulp-util'
plumber =         require 'gulp-plumber'

paths =
  public:     './site/public'
  scripts:    './site/scripts/*.coffee'
  styles:      'site/styles/**/*.sass'
  templates:  './site/templates/*.jade'

gulp.task 'sass', ->
  gulp.src paths.styles
    .pipe plumber()
    .pipe sass(errLogToConsole: true, sourceComments: 'normal', indentedSyntax: 'true')
    .pipe gulp.dest(paths.public)
    .pipe connect.reload()

gulp.task 'jade', ->
  gulp.src paths.templates
    .pipe plumber()
    .pipe jade(pretty: true)
    .pipe gulp.dest(paths.public)
    .pipe connect.reload()

gulp.task 'coffee', ->
  gulp.src paths.scripts
    .pipe plumber()
    .pipe concat('app.js')
    .pipe coffee({bare: true})
    .pipe gulp.dest(paths.public)
    .pipe connect.reload()

gulp.task 'watch', ->
  gulp.watch paths.scripts, ['coffee']
  gulp.watch paths.templates, ['jade']
  gulp.watch paths.styles, ['sass']

gulp.task 'server', ->
  connect.server root: 'site/public', livereload: true, port: 3000

gulp.task 'default', ['watch', 'sass', 'jade', 'coffee', 'server']

