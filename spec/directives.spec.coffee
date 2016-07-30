'use strict'
describe 'the directive `sns-links`', ->
    $compile = null
    $rootScope = null
    it 'should be a test', ->
        expect true
            .toEqual true
    #
    # # Load the myApp module, which contains the directive
    # beforeEach(module('myApp'))
    #
    # # Store references to $rootScope and $compile
    # # so they are available to all tests in this describe block
    # beforeEach inject (_$compile_, _$rootScope_) ->
    #     # The injector unwraps the underscores (_) from around the parameter names when matching
    #     $compile = _$compile_
    #     $rootScope = _$rootScope_
    #     1
    # it 'Replaces the element with the appropriate content', ->
    #     # Compile a piece of HTML containing the directive
    #     element = $compile('<sns-links></sns-links>')($rootScope)
    #     # fire all the watches, so the scope expression {{1 + 1}} will be evaluated
    #     $rootScope.$digest()
    #     # Check that the compiled element contains the templated content
    #     expect(element[0].tagName).toEqual true
