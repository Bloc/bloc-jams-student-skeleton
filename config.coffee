exports.config =
    # See docs at http://brunch.readthedocs.org/en/latest/config.html.

    plugins:
        uglify:
            pattern: /\.js$/

        coffeelint:
            pattern: /^.*\.coffee$/
            options:
                indentation:
                    value: 2
                    level: "error"

    files:
        javascripts:
            joinTo:
                'javascripts/app.js': /^app/
                'javascripts/vendor.js': /^vendor\/scripts/
            order:
                # Files in `vendor` directories are compiled before other files
                # even if they aren't specified in order.
                before: [
                    'vendor/scripts/json2.js'
                    'vendor/scripts/jquery-1.9.1.js'
                    'vendor/scripts/underscore-1.4.4.js'
                    'vendor/scripts/jquery-2.1.0.js'
                ]
                after: [
                    'vendor/scripts/brunch-reload.js'
                ]

        stylesheets:
            joinTo:
                'stylesheets/app.css': /^(app\/styles|vendor\/styles)/
            order:
                before: [
                    'vendor/styles/bootstrap-theme.css'
                    'vendor/styles/bootstrap.css'
                    'vendor/styles/font-awesome.css'
                ]
        templates:
            joinTo: 'javascripts/app.js'
    server:
        path: 'server.coffee'
        port: 3000
        base: '/'
        app: 'express'
        debug: 'brunch:server'
        persistent: true
        interval: 100
        watched: ['public', 'express']
        ignore: /(^[.#]|(?:~)$)/
        source: /.*\.coffee$/
        linter:
            enabled: on
            coffeelint:
                pattern: /.*\.coffee$/
                options:
                    indentation:
                        value: 2
                        level: "error"
                    max_line_length:
                        level: "ignore"
        tester:
            enabled: on
            mocha:
                pattern: /^.*_test\.coffee$/
                options:
                    reporter:'spec'
