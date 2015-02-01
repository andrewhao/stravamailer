var gulp = require('gulp');
var mocha = require("gulp-spawn-mocha");

gulp.task('test', function() {
  return gulp.src(["test/**/*.coffee"]).pipe(mocha({
    bin: "node_modules/.bin/mocha",
    reporter: "spec",
    compilers: "coffee:coffee-script/register"
  })).on("error", console.warn.bind(console));
});

gulp.task('default', ['test']);
