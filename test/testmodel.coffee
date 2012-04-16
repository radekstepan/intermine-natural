should = require "should"
prolog = require "../prolog"

q =
    'against an attribute of a class sentence':
        sentence: 'name of company'
        tree: 'q([company (Class), name (Attribute)])'
    'against a reference of a class sentence':
        sentence: 'department of company'
        tree: 'q([company (Class), department (Reference)])'
    'against an attribute of a class of a direct parent class sentence':
        sentence: 'name of department of company'
        tree: 'q([company (Class), department (Class), name (Attribute)])'
    'against a reference of a class of a direct parent class sentence':
        sentence: 'employee of department of company'
        tree: 'q([company (Class), department (Class), employee (Reference)])'

describe "testmodel.prolog", ->
    
    for test, {sentence, tree} of q
        do (test, sentence, tree) ->
            describe test + ', "' + sentence + '"', ->
                it 'should output parsed tree, "' + tree + '"', (done) ->
                    prolog.show_path sentence, (output) ->
                        [output].should.eql [tree]
                        done()