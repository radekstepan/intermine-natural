should = require "should"
prolog = require "../prolog"

q =
    'against an attribute of a class sentence':
        sentence: 'name of company'
        tree: 'Attribute: name -> Class: company'
    'against a reference of a class sentence':
        sentence: 'department of company'
        tree: 'Reference: department -> Class: company'
    'against an attribute of a class of a direct parent class sentence':
        sentence: 'name of department of company'
        tree: 'Attribute: name -> Class: department -> Class: company'
    'against a reference of a class of a direct parent class sentence':
        sentence: 'employee of department of company'
        tree: 'Reference: employee -> Class: department -> Class: company'
    'against an attribute of a class of a higher parent class sentence':
        sentence: 'name of employee of company'
        tree: 'Attribute: name -> Class: employee -> Class: company'

describe "testmodel.prolog", ->
    
    for test, {sentence, tree} of q
        do (test, sentence, tree) ->
            describe test + ', "' + sentence + '"', ->
                it 'should output parsed tree, "' + tree + '"', (done) ->
                    prolog.show_tree sentence, (output) ->
                        [output].should.eql [tree]
                        done()