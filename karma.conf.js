export default (config) => {
    return config.set({
        basePath: '',
        frameworks: ['jasmine'],

        files: [
            'vendor/angular/angular.js',
            'node_modules/angular-mocks/angular-mocks.js',
            'assets/*.js',
            'spec/*.js'
        ],

        exclude: [],
        preprocessors: {},
        reporters: ['progress'],
        port: 9876,
        colors: true,
        logLevel: config.LOG_INFO,
        autoWatch: true,
        browsers: ['PhantomJS', 'PhantomJS_custom'],
        singleRun: false,
        concurrency: Infinity
    })
}
