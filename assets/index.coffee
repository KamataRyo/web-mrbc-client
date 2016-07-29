'use strict'

endpoint = 'http://web-mrbc.wakayamarb.org'
app = angular.module 'web-mrbc-client', []

app.config [
    '$locationProvider'
    ($locationProvider) ->
        $locationProvider.html5Mode(true).hashPrefix '!'
]

app.directive 'fileReader', ->
    return {
        restrict: 'A'
        link: (scope, element, attrs) ->

            getCompiledFileName = (filename) ->
                elements = filename.split '.'
                if elements[elements.length - 1] is 'rb'
                    elements[elements.length - 1] = 'mrb'
                    return elements.join '.'
                else
                    return filename + '.mrb'

            element.on 'change', (event) ->
                limit = 100000 #100kb
                scope.log = undefined
                scope.$apply()
                # file detected
                file = event.target.files[0]

                if file.size > limit
                    event.target.files = null
                    scope.log = "Too large file. Size is limit upto #{limit}."
                    scope.fileName = ''
                    scope.$apply()
                    return

                scope.fileName = file.name
                scope.compiledFileName = getCompiledFileName file.name
                scope.$apply()

                fileReader = new FileReader()
                # set me as source and enable upload(download)
                fileReader.onload = (e) ->
                    scope.fileContent = fileReader.result
                    scope.$apply()
                fileReader.readAsText file
            }

app.directive 'snsLinks', ->
    return {
        restrict: 'E'
        template: '<ul class="sns-links"><li>aaa</li></ul>'
        replace: true
    }


app.controller 'tabCtrl', [
    '$scope'
    '$location'
    '$http'
    '$httpParamSerializer'
    ($scope, $location, $http, $httpParamSerializer) ->
        # initialize tab states
        $scope.fileUploadActive  = 'active'
        $scope.directInputActive = 'inactive'
        $scope.fromURLActive     = 'inactive'
        $scope.active = 'fileUpload'

        # initialize options
        $scope.bytecodeFormats = [
            {version: 3, label: 'Ver.0003 (default)'}
            {version: 2, label: 'Ver.0002'}
        ]
        $scope.bytecodeFormatVersion = $scope.bytecodeFormats[0].version;

        # select to toggle tabs
        $scope.select = (selection) ->
            $scope.log = undefined
            $scope.fileUploadActive  = 'inactive'
            $scope.directInputActive = 'inactive'
            $scope.fromURLActive     = 'inactive'
            $scope[selection + 'Active'] = 'active'
            $scope.active = selection
            $location.hash selection

        # client side routing
        hash = $location.hash()
        if hash isnt '' then $scope.select hash


        # make request and download binary
        $scope.download = ->
            $scope.log = undefined
            arg = {
                version: $scope.bytecodeFormatVersion
                options: $scope.options
            }
            switch $scope.active
                when 'fileUpload'
                    arg.type    = 'source'
                    arg.content = $scope.fileContent
                when 'directInput'
                    arg.type    = 'source'
                    arg.content = $scope.source
                when 'fromURL'
                    arg.type    = 'url'
                    arg.content = $scope.urlContent
                else
                    $scope.log = 'Invalid Operation.'
                    return

            if arg.content is '' or !arg.content?
                $scope.log = 'Content required'
            else
                query = "#{endpoint}?" + $httpParamSerializer arg
                alert 'make request to ' + query
]
