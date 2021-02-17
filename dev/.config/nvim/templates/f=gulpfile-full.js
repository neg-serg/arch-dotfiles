var gulp = require('gulp'),
	jade = require('gulp-jade'),
	sass = require('gulp-sass'),
	coffee = require('gulp-coffee'),
	browserSync = require('browser-sync').create();

var src = {
	'jade': './*.jade',
	'scss': './sass/*.scss',
	'coffee': './coffee/*.coffee'
};
var d = './public/';
var dist = {
	'html': d + '*.html',
	'css': d + 'css/*.css',
	'js': d + 'js/*.js'
};

// ===========
// Compilation
// ===========

// Jade to html
gulp.task('jade', function() {
	return gulp.src(src.jade)
		.pipe(jade({
			pretty: true
		}))
		.pipe(gulp.dest(d));
});

// Scss to css
gulp.task('sass', function() {
	return gulp.src(src.scss)
		.pipe(sass().on('Error', sass.logError))
		.pipe(gulp.dest(d + 'css'));
});

// Coffeescript to javascript
gulp.task('coffee', function() {
	return gulp.src(src.coffee)
		.pipe(coffee())
		.pipe(gulp.dest(d + 'js'));
});

// =============
// Watch & serve
// =============

gulp.task('serve', function() {
	browserSync.init({
		server: {
			baseDir: "./public"
		},
		offline: false,
		open: false
	});

	gulp.watch(src.jade, ['jade']);
	gulp.watch(src.scss, ['sass']);
	gulp.watch(src.coffee, ['coffee']);
	gulp.watch([
		dist.html,
		dist.css,
		dist.js
	], browserSync.reload);
});
