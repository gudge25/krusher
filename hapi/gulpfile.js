// Include gulp
const gulp = require('gulp');
const mocha = require('gulp-mocha');
const nodemon = require('gulp-nodemon');

gulp.task('ami', done => {
    nodemon({
        // exec: 'node --debug',
        script: 'ami/index.js',
        ext: 'js',
        // tasks: ['debug'],
        verbose: true,
        ignore: [
            '.idea/*',
            'node_modules/*',
            'test/*'
        ],
        env: {
            'NODE_ENV': 'development',
            'NODE_PATH': '.'
        }, 
        done: done

    }).on('restart', () => {
        console.log('restarted!');
    });
});
// Lint Tasks
gulp.task('lint', () => {
    return gulp.src([
        '**/*.js',
        '!node_modules/**/*.js',
        '!coverage.html'
    ]).pipe(jshint()).pipe(jshint.reporter('default'));
});
gulp.task('debug', () => {
    gulp.src([]).pipe(nodeInspector({
        debugPort: 5858,
        webHost: '0.0.0.0',
        webPort: 8080,
        saveLiveEdit: false,
        preload: true,
        inject: true,
        hidden: [],
        stackTraceLimit: 50,
        sslKey: '',
        sslCert: ''
    }));
});
gulp.task('dev', async function(done) {
      
    var stream = nodemon({
            // exec: 'node --debug',
            script: 'index.js',
            ext: 'js',
            // tasks: ['debug'],
            verbose: true,
            ignore: [
                '.idea/*',
                'node_modules/*',
                'test/*',
                'uploads/*'
            ],
            env: {
                'NODE_ENV': 'development',
                'NODE_PATH': '.'
            },
            done: done
    });
    
    stream
            .on('restart', function () {
                console.log('restarted!')
            })
            .on('crash', function() {
                console.error('Application has crashed!\n')
                stream.emit('restart', 10)  // restart the server in 10 seconds
            })    

    return stream;     
});
gulp.task('test', () => {
    gulp.src('test/unit/**/*.js').pipe(mocha({
        reporter: 'min',
        should: require('should')    // clearRequireCache: true,
                             // ignoreLeaks: true
    }));
});
// Watch Files For Changes
gulp.task('watch', () => {
    gulp.watch([
        '**/*.js',
        '!node_modules/**/*.js',
        '!clients/**/*.js',
        '!coverage.html'
    ], gulp.series(`lint`));    // gulp.watch(['routes/**/*.js', 'app.js', 'test/**/*.js'], ['lint', 'test']);
});

// Default Task
gulp.task('default', gulp.series([`dev`], function(done){ done(); }));